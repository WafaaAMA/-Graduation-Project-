import 'package:flutter/material.dart';

class _SecretTextformState extends StatefulWidget {
  const _SecretTextformState({super.key, required this.labelText, required this.controller, required this.fkey, this.controller_parent

  });
    final String labelText;
    final TextEditingController controller;
    final GlobalKey<FormState> fkey;
    final TextEditingController? controller_parent;
  @override
  State<_SecretTextformState> createState() => __SecretTextformStateState();
}

class __SecretTextformStateState extends State<_SecretTextformState> {
  @override
  bool obsecureText = true;
  Widget build(BuildContext context) {
    return  Form(
      key: widget.fkey,
      child: Padding(
        padding: EdgeInsets.only(
          left: 15,
          right: 15,
        ),
        child: TextFormField(
          obscureText: obsecureText,
          controller: widget.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(15),
              )
            ),
            labelText: widget.labelText,
            suffixIcon: IconButton(
              onPressed: (){
                setState(() {
                  obsecureText= !obsecureText;
                });
              }, 
              icon: obsecureText? Icon(Icons.visibility_off):Icon(Icons.visibility),
              ),

          ),
          validator: (val){
            if(val!.isEmpty){
              return"please , enter ${widget.labelText}";
              
            }
            if(widget.labelText=="Confiem Password"&&
            widget.controller_parent !=null  ){
            if (val != widget.controller_parent!.text){
              return "password does not match";
            }
            return null;

          } else{
            return null;
          }
          
          }
          
          
        ),
        ),
    );
  }
}