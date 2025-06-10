using System;
using Microsoft.EntityFrameworkCore.Migrations;

#nullable disable

namespace CareFirst.Migrations
{
    /// <inheritdoc />
    public partial class InitialCreated : Migration
    {
        /// <inheritdoc />
        protected override void Up(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.CreateTable(
                name: "AppSettings",
                columns: table => new
                {
                    MaxBooking = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                });

            migrationBuilder.CreateTable(
                name: "AwarenessVideo",
                columns: table => new
                {
                    VideoID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Title = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Duration = table.Column<int>(type: "int", nullable: true),
                    category = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    UploadDate = table.Column<DateOnly>(type: "date", nullable: true),
                    ViewCount = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Awarenes__BAE5124A2A2CB6BC", x => x.VideoID);
                });

            migrationBuilder.CreateTable(
                name: "Disease",
                columns: table => new
                {
                    DiseaseID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Disease__69B533A9009E97BA", x => x.DiseaseID);
                });

            migrationBuilder.CreateTable(
                name: "DoctorDepartment",
                columns: table => new
                {
                    DoctorAppointmentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    DepartmentPicture = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DoctorDe__0C56E767129044D9", x => x.DoctorAppointmentID);
                });

            migrationBuilder.CreateTable(
                name: "DoctorMedicalCenter",
                columns: table => new
                {
                    DoctorMedicalCenterID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Location = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DoctorMe__B2E93E85AEC84BCF", x => x.DoctorMedicalCenterID);
                });

            migrationBuilder.CreateTable(
                name: "NurseDepartment",
                columns: table => new
                {
                    NurseAppointmentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Info = table.Column<string>(type: "nvarchar(max)", nullable: false),
                    DepartmentPicture = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__NurseDep__2E2C437A97183C8C", x => x.NurseAppointmentID);
                });

            migrationBuilder.CreateTable(
                name: "NurseMedicalCenter",
                columns: table => new
                {
                    NurseMedicalCenterID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(100)", maxLength: 100, nullable: false),
                    Location = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__NurseMed__056ABD0DDFA31F2F", x => x.NurseMedicalCenterID);
                });

            migrationBuilder.CreateTable(
                name: "SupperUser",
                columns: table => new
                {
                    SupperUserID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    UserName = table.Column<string>(type: "nvarchar(30)", maxLength: 30, nullable: true),
                    Password = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    Role = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__SupperUs__670B66F848B8786E", x => x.SupperUserID);
                });

            migrationBuilder.CreateTable(
                name: "UserTable",
                columns: table => new
                {
                    UserID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Email = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    PhoneNumber = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Age = table.Column<int>(type: "int", nullable: false),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    PasswordHash = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Gender = table.Column<int>(type: "int", nullable: false),
                    ProfilePicture = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    VerificationToken = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    VerifiedAt = table.Column<DateTime>(type: "datetime2", nullable: true),
                    PasswordResetToken = table.Column<string>(type: "nvarchar(200)", maxLength: 200, nullable: true),
                    ResetTokenExpires = table.Column<DateTime>(type: "datetime2", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__UserTabl__1788CCAC7D15E634", x => x.UserID);
                });

            migrationBuilder.CreateTable(
                name: "Symptom",
                columns: table => new
                {
                    SymptomID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Symptoms = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Disease_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Symptom__D26ED8B612615737", x => x.SymptomID);
                    table.ForeignKey(
                        name: "FK__Symptom__Disease__53A266AC",
                        column: x => x.Disease_id,
                        principalTable: "Disease",
                        principalColumn: "DiseaseID");
                });

            migrationBuilder.CreateTable(
                name: "Doctor",
                columns: table => new
                {
                    DoctorID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(50)", maxLength: 50, nullable: false),
                    Info = table.Column<string>(type: "nvarchar(max)", nullable: true),
                    Rating = table.Column<int>(type: "int", nullable: false),
                    Location = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    ProfilePicture = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    Department_Id = table.Column<int>(type: "int", nullable: false),
                    MedicalCenter_Id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Doctor__2DC00EDFA5567581", x => x.DoctorID);
                    table.ForeignKey(
                        name: "FK__Doctor__Departme__30592A6F",
                        column: x => x.Department_Id,
                        principalTable: "DoctorDepartment",
                        principalColumn: "DoctorAppointmentID");
                    table.ForeignKey(
                        name: "FK__Doctor__MedicalC__314D4EA8",
                        column: x => x.MedicalCenter_Id,
                        principalTable: "DoctorMedicalCenter",
                        principalColumn: "DoctorMedicalCenterID");
                });

            migrationBuilder.CreateTable(
                name: "Nurse",
                columns: table => new
                {
                    NurseID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Info = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Age = table.Column<int>(type: "int", nullable: false),
                    ProfilePicture = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    Department_Id = table.Column<int>(type: "int", nullable: true),
                    MedicalCenter_Id = table.Column<int>(type: "int", nullable: true)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Nurse__4384786950687BBD", x => x.NurseID);
                    table.ForeignKey(
                        name: "FK__Nurse__Departmen__46486B8E",
                        column: x => x.Department_Id,
                        principalTable: "NurseDepartment",
                        principalColumn: "NurseAppointmentID");
                    table.ForeignKey(
                        name: "FK__Nurse__MedicalCe__473C8FC7",
                        column: x => x.MedicalCenter_Id,
                        principalTable: "NurseMedicalCenter",
                        principalColumn: "NurseMedicalCenterID");
                });

            migrationBuilder.CreateTable(
                name: "AppointmentDoctor",
                columns: table => new
                {
                    AppointmentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AppointmentDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Doctor_id = table.Column<int>(type: "int", nullable: false),
                    User_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Appointm__8ECDFCA204777518", x => x.AppointmentID);
                    table.ForeignKey(
                        name: "FK__Appointme__Docto__3429BB53",
                        column: x => x.Doctor_id,
                        principalTable: "Doctor",
                        principalColumn: "DoctorID");
                    table.ForeignKey(
                        name: "FK__Appointme__User___351DDF8C",
                        column: x => x.User_id,
                        principalTable: "UserTable",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "BookDoctor",
                columns: table => new
                {
                    BookDoctorID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    PhoneNumber = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    TimeBook = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Doctor_id = table.Column<int>(type: "int", nullable: false),
                    User_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__BookDoct__5C665E5E2BCC2D74", x => x.BookDoctorID);
                    table.ForeignKey(
                        name: "FK__BookDocto__Docto__3AD6B8E2",
                        column: x => x.Doctor_id,
                        principalTable: "Doctor",
                        principalColumn: "DoctorID");
                    table.ForeignKey(
                        name: "FK__BookDocto__User___3BCADD1B",
                        column: x => x.User_id,
                        principalTable: "UserTable",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "DoctorsAvailableTime",
                columns: table => new
                {
                    AvailableTimeID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    TimeAvailable = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Doctor_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__DoctorsA__6EC40C2486A70DF9", x => x.AvailableTimeID);
                    table.ForeignKey(
                        name: "FK__DoctorsAv__Docto__37FA4C37",
                        column: x => x.Doctor_id,
                        principalTable: "Doctor",
                        principalColumn: "DoctorID");
                });

            migrationBuilder.CreateTable(
                name: "AppointmentNurse",
                columns: table => new
                {
                    AppointmentID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    AppointmentDate = table.Column<DateTime>(type: "datetime2", nullable: false),
                    Status = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Nurse_id = table.Column<int>(type: "int", nullable: false),
                    User_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__Appointm__8ECDFCA27E9FECBB", x => x.AppointmentID);
                    table.ForeignKey(
                        name: "FK__Appointme__Nurse__4A18FC72",
                        column: x => x.Nurse_id,
                        principalTable: "Nurse",
                        principalColumn: "NurseID");
                    table.ForeignKey(
                        name: "FK__Appointme__User___4B0D20AB",
                        column: x => x.User_id,
                        principalTable: "UserTable",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "BookNurse",
                columns: table => new
                {
                    BookNurseID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Name = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    PhoneNumber = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: false),
                    Nurse_id = table.Column<int>(type: "int", nullable: false),
                    User_id = table.Column<int>(type: "int", nullable: false),
                    TimeBook = table.Column<DateTime>(type: "datetime2", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__BookNurs__86DACD43FB357395", x => x.BookNurseID);
                    table.ForeignKey(
                        name: "FK__BookNurse__Nurse__4DE98D56",
                        column: x => x.Nurse_id,
                        principalTable: "Nurse",
                        principalColumn: "NurseID");
                    table.ForeignKey(
                        name: "FK__BookNurse__User___4EDDB18F",
                        column: x => x.User_id,
                        principalTable: "UserTable",
                        principalColumn: "UserID");
                });

            migrationBuilder.CreateTable(
                name: "ReviewDoctor",
                columns: table => new
                {
                    ReviewDoctorID = table.Column<int>(type: "int", nullable: false)
                        .Annotation("SqlServer:Identity", "1, 1"),
                    Rating = table.Column<int>(type: "int", nullable: true),
                    Comment = table.Column<string>(type: "nvarchar(255)", maxLength: 255, nullable: true),
                    Doctor_id = table.Column<int>(type: "int", nullable: false),
                    AppointmentDoctor_id = table.Column<int>(type: "int", nullable: false)
                },
                constraints: table =>
                {
                    table.PrimaryKey("PK__ReviewDo__7E37B3A3D916E83B", x => x.ReviewDoctorID);
                    table.ForeignKey(
                        name: "FK__ReviewDoc__Appoi__3F9B6DFF",
                        column: x => x.AppointmentDoctor_id,
                        principalTable: "AppointmentDoctor",
                        principalColumn: "AppointmentID");
                    table.ForeignKey(
                        name: "FK__ReviewDoc__Docto__3EA749C6",
                        column: x => x.Doctor_id,
                        principalTable: "Doctor",
                        principalColumn: "DoctorID");
                });

            migrationBuilder.CreateIndex(
                name: "IX_AppointmentDoctor_Doctor_id",
                table: "AppointmentDoctor",
                column: "Doctor_id");

            migrationBuilder.CreateIndex(
                name: "IX_AppointmentDoctor_User_id",
                table: "AppointmentDoctor",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_AppointmentNurse_Nurse_id",
                table: "AppointmentNurse",
                column: "Nurse_id");

            migrationBuilder.CreateIndex(
                name: "IX_AppointmentNurse_User_id",
                table: "AppointmentNurse",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_BookDoctor_Doctor_id",
                table: "BookDoctor",
                column: "Doctor_id");

            migrationBuilder.CreateIndex(
                name: "IX_BookDoctor_User_id",
                table: "BookDoctor",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_BookNurse_Nurse_id",
                table: "BookNurse",
                column: "Nurse_id");

            migrationBuilder.CreateIndex(
                name: "IX_BookNurse_User_id",
                table: "BookNurse",
                column: "User_id");

            migrationBuilder.CreateIndex(
                name: "IX_Doctor_Department_Id",
                table: "Doctor",
                column: "Department_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Doctor_MedicalCenter_Id",
                table: "Doctor",
                column: "MedicalCenter_Id");

            migrationBuilder.CreateIndex(
                name: "IX_DoctorsAvailableTime_Doctor_id",
                table: "DoctorsAvailableTime",
                column: "Doctor_id");

            migrationBuilder.CreateIndex(
                name: "IX_Nurse_Department_Id",
                table: "Nurse",
                column: "Department_Id");

            migrationBuilder.CreateIndex(
                name: "IX_Nurse_MedicalCenter_Id",
                table: "Nurse",
                column: "MedicalCenter_Id");

            migrationBuilder.CreateIndex(
                name: "IX_ReviewDoctor_AppointmentDoctor_id",
                table: "ReviewDoctor",
                column: "AppointmentDoctor_id");

            migrationBuilder.CreateIndex(
                name: "IX_ReviewDoctor_Doctor_id",
                table: "ReviewDoctor",
                column: "Doctor_id");

            migrationBuilder.CreateIndex(
                name: "IX_Symptom_Disease_id",
                table: "Symptom",
                column: "Disease_id");

            migrationBuilder.CreateIndex(
                name: "UQ__UserTabl__85FB4E386B84F6E2",
                table: "UserTable",
                column: "PhoneNumber",
                unique: true);

            migrationBuilder.CreateIndex(
                name: "UQ__UserTabl__A9D10534B2810CE1",
                table: "UserTable",
                column: "Email",
                unique: true);
        }

        /// <inheritdoc />
        protected override void Down(MigrationBuilder migrationBuilder)
        {
            migrationBuilder.DropTable(
                name: "AppointmentNurse");

            migrationBuilder.DropTable(
                name: "AppSettings");

            migrationBuilder.DropTable(
                name: "AwarenessVideo");

            migrationBuilder.DropTable(
                name: "BookDoctor");

            migrationBuilder.DropTable(
                name: "BookNurse");

            migrationBuilder.DropTable(
                name: "DoctorsAvailableTime");

            migrationBuilder.DropTable(
                name: "ReviewDoctor");

            migrationBuilder.DropTable(
                name: "SupperUser");

            migrationBuilder.DropTable(
                name: "Symptom");

            migrationBuilder.DropTable(
                name: "Nurse");

            migrationBuilder.DropTable(
                name: "AppointmentDoctor");

            migrationBuilder.DropTable(
                name: "Disease");

            migrationBuilder.DropTable(
                name: "NurseDepartment");

            migrationBuilder.DropTable(
                name: "NurseMedicalCenter");

            migrationBuilder.DropTable(
                name: "Doctor");

            migrationBuilder.DropTable(
                name: "UserTable");

            migrationBuilder.DropTable(
                name: "DoctorDepartment");

            migrationBuilder.DropTable(
                name: "DoctorMedicalCenter");
        }
    }
}
