from flask import Flask, request, jsonify
import joblib
import pandas as pd
import numpy as np
import os
from sklearn.svm import SVC
from imblearn.over_sampling import SMOTE

app = Flask(__name__)

# ✅ تحديد مسارات الملفات
MODEL_PATH = "svm_disease_prediction_new.pkl"
SEVERITY_PATH = "Symptom-severity.csv"
TRAIN_DATA_PATH = "dataset (2).csv"
CLEANED_DATA_PATH = "dataset_cleaned.csv"

# ✅ التحقق من وجود الملفات الأساسية قبل البدء
if not os.path.exists(TRAIN_DATA_PATH):
    raise FileNotFoundError(f"❌ الملف غير موجود: {TRAIN_DATA_PATH}")

if not os.path.exists(SEVERITY_PATH):
    raise FileNotFoundError(f"❌ الملف غير موجود: {SEVERITY_PATH}")

# ✅ تنظيف البيانات إذا لم يكن الملف المنظف موجودًا
if not os.path.exists(CLEANED_DATA_PATH):
    print("🔹 تنظيف بيانات التدريب...")
    train_data = pd.read_csv(TRAIN_DATA_PATH)

    # طباعة الأعمدة للتحقق
    print("🔹 أعمدة الملف الأصلي:", train_data.columns.tolist())

    # التأكد من وجود عمود 'Disease'
    if 'Disease' not in train_data.columns:
        raise ValueError("❌ عمود 'Disease' غير موجود في الملف dataset (2).csv")

    # تنظيف الأعراض المدمجة (مثل "skin rash itching" إلى "skin_rash,itching")
    print("🔹 معالجة الأعراض المدمجة والتنسيق غير الموحد...")
    replacements = {
        "skin rash itching": "skin_rash,itching",
        "dischromic  patches": "dischromic_patches",
        "continuous sneezing": "continuous_sneezing",
        "nodal skin eruptions": "nodal_skin_eruptions",
    }

    # التعامل مع القيم الفارغة (NaN) قبل التنظيف
    for col in train_data.columns[:-1]:
        train_data[col] = train_data[col].fillna("")

    # تطبيق الاستبدال على الأعراض
    for col in train_data.columns[:-1]:
        for original, replacement in replacements.items():
            train_data[col] = train_data[col].str.replace(original, replacement)

    # تحويل المسافات إلى _ في الأعراض
    for col in train_data.columns[:-1]:
        train_data[col] = train_data[col].str.strip().str.lower().str.replace(" ", "_")

    # حفظ البيانات المنظفة
    train_data.to_csv(CLEANED_DATA_PATH, index=False)
    print(f"✅ تم تنظيف البيانات وحفظها في {CLEANED_DATA_PATH}")

# ✅ تحميل بيانات التدريب المنظفة
print("🔹 تحميل بيانات التدريب المنظفة...")
train_data = pd.read_csv(CLEANED_DATA_PATH)

# طباعة الأعمدة للتحقق
print("🔹 أعمدة الملف المنظف:", train_data.columns.tolist())

# التأكد من وجود عمود 'Disease'
if 'Disease' not in train_data.columns:
    raise ValueError("❌ عمود 'Disease' غير موجود في الملف dataset_cleaned.csv")

print("🔹 تحميل بيانات شدة الأعراض...")
severity_data = pd.read_csv(SEVERITY_PATH)
symptom_severity = {row["Symptom"]: row["weight"] for _, row in severity_data.iterrows()}

# ✅ استخراج الأعراض الفريدة من بيانات التدريب
print("🔹 استخراج الأعراض الفريدة من بيانات التدريب...")
symptom_columns = set()
for column in train_data.columns[:-1]:
    symptoms_in_column = train_data[column].dropna().unique()
    for symptom in symptoms_in_column:
        symptoms = symptom.split(",")
        for s in symptoms:
            formatted_symptom = s.strip().lower().replace(" ", "_")
            if formatted_symptom:
                symptom_columns.add(formatted_symptom)
symptom_columns = sorted(list(symptom_columns))
num_features = len(symptom_columns)
print(f"🔹 عدد الأعراض الفريدة: {num_features}")
print(f"🔹 الأعراض: {symptom_columns}")

# ✅ تدريب الموديل إذا لم يكن موجودًا
if not os.path.exists(MODEL_PATH):
    print("🔹 تدريب موديل جديد...")
    # تحويل البيانات إلى متجهات
    X = np.zeros((len(train_data), num_features))
    y = train_data['Disease'].values  # استخدام العمود 'Disease' مباشرة

    for i, row in train_data.iterrows():
        for col in train_data.columns[:-1]:
            symptom = row[col]
            if pd.isna(symptom) or not symptom:
                continue
            symptoms = symptom.split(",")
            for s in symptoms:
                formatted_symptom = s.strip().lower().replace(" ", "_")
                if formatted_symptom in symptom_columns:
                    idx = symptom_columns.index(formatted_symptom)
                    X[i, idx] = symptom_severity.get(formatted_symptom, 0)

    # طباعة توزيع الأمراض
    print("🔹 توزيع الأمراض قبل الموازنة:")
    print(pd.Series(y).value_counts())

    # موازنة البيانات باستخدام SMOTE
    print("🔹 موازنة البيانات باستخدام SMOTE...")
    smote = SMOTE(random_state=42)
    X_balanced, y_balanced = smote.fit_resample(X, y)

    # طباعة توزيع الأمراض بعد الموازنة
    print("🔹 توزيع الأمراض بعد الموازنة:")
    print(pd.Series(y_balanced).value_counts())

    # تدريب الموديل
    model = SVC()
    model.fit(X_balanced, y_balanced)

    # حفظ الموديل
    joblib.dump(model, MODEL_PATH)
    print(f"✅ تم تدريب الموديل وحفظه في {MODEL_PATH}")

# ✅ تحميل الموديل
print("🔹 تحميل الموديل...")
model = joblib.load(MODEL_PATH)

@app.route("/")
def home():
    return "✅ API يعمل بنجاح! استخدم /predict لإرسال بيانات الأعراض."

@app.route("/symptoms", methods=["GET"])
def get_symptoms():
    print(f"🔍 استرجاع قائمة الأعراض ({len(symptom_severity)} عرض)")
    return jsonify(list(symptom_severity.keys()))

@app.route("/predict", methods=["POST"])
def predict():
    try:
        data = request.get_json()
        symptoms = data.get("symptoms", [])

        # ✅ التحقق من صحة الأعراض المدخلة
        valid_symptoms = set(symptom_severity.keys())
        input_symptoms = [s.strip().lower() for s in symptoms]
        invalid_symptoms = [s for s in input_symptoms if s not in valid_symptoms]
        if invalid_symptoms:
            return jsonify({"error": f"❌ أعراض غير معروفة: {invalid_symptoms}"}), 400

        # ✅ تجهيز مدخلات النموذج
        symptoms_vector = np.zeros(num_features)

        for i, symptom in enumerate(symptom_columns):
            if symptom in input_symptoms:
                symptoms_vector[i] = symptom_severity.get(symptom, 0)

        print(f"🔹 Input Symptoms: {input_symptoms}")
        print(f"🔹 Symptoms Vector: {symptoms_vector}")

        symptoms_vector = symptoms_vector.reshape(1, -1)

        # ✅ التنبؤ بالمرض
        prediction = model.predict(symptoms_vector)[0]
        print(f"🔹 Model Classes: {model.classes_}")
        print(f"✅ المرض المتوقع: {prediction}")

        return jsonify({"prediction": prediction})

    except Exception as e:
        print(f"❌ خطأ أثناء التنبؤ: {str(e)}")
        return jsonify({"error": str(e)}), 500

if __name__ == "__main__":
    app.run(debug=True, host="0.0.0.0", port=5000)