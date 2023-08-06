import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_app/auth_screen/sign_in_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
  }

  signUp() async{
    setState(() {
      isLoading = true;
    });
    try{
      UserCredential userCredential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text);
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        await FirebaseFirestore.instance.collection('user-data').doc(authCredential.uid).set({
          'name': nameController.text,
          'phone': phoneController.text,
        });
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: const Center(
               child:  Text("Account Created Successfully",
                style: TextStyle(fontSize: 20),),
             ),
              backgroundColor: Colors.green.shade900,
              behavior: SnackBarBehavior.floating,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height -760,
                  right: 20,
                  left: 20
              ),
            ));
        Navigator.push(context, CupertinoPageRoute(builder: (_) => const SignInScreen()));
      }else{
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: const Text("Something went wrong",
              style: TextStyle(fontSize: 20),),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height -760,
                  right: 20,
                  left: 20
              ),
            ));
      }
    }on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: const Center(
               child:  Text("Password is weak",
                style: TextStyle(fontSize: 20),),
             ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height -760,
                  right: 20,
                  left: 20
              ),
            ));

      } else if (e.code == 'email-already-in-use') {
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content:  const Center(
               child: Text("An account already exists for that email",
                style: TextStyle(fontSize: 20),),
             ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: EdgeInsets.only(
                  bottom: MediaQuery.of(context).size.height -760,
                  right: 20,
                  left: 20
              ),
            ));
      }
    } catch(e){
      print(e);
    }
  }


  void navigateToSignInScreen(){
    Navigator.push(context, MaterialPageRoute(builder: (context)=> const SignInScreen()));
  }

  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown,
      body: SafeArea(
        child: Form(
          key: formKey,
          child: Column(
            children: [
              SizedBox(
                height: 150.h,
                width: ScreenUtil().screenWidth,
                child: Padding(
                  padding: EdgeInsets.only(left: 20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      const SizedBox(height: 50,),
                      Center(
                        child: Text(
                          "CineGH",
                          style: TextStyle(fontSize: 50.sp, color: Colors.red),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                child: Padding(
                  padding: EdgeInsets.all(20.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: TextFormField(
                              controller: nameController,
                              keyboardType: TextInputType.text,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: "Name",
                                  hintStyle: TextStyle(
                                    color: Colors.white,
                                  ),
                                  focusedBorder: inputBorder,
                                  border: inputBorder,
                                  filled: true,
                                  enabledBorder: inputBorder,
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.grey
                              ),
                              validator: (val){
                                if(val!.isEmpty){
                                  return "Name can't be empty";
                                }
                                return null;
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                controller: emailController,
                                keyboardType: TextInputType.emailAddress,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    hintText: "Email",
                                    hintStyle:  TextStyle(
                                      color: Colors.white,
                                    ),
                                    focusedBorder: inputBorder,
                                    border: inputBorder,
                                    filled: true,
                                    enabledBorder: inputBorder,
                                    contentPadding: EdgeInsets.all(10),
                                    fillColor: Colors.grey
                                ),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Email can't be empty";
                                  }
                                  return null;
                                },
                              )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                controller: phoneController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    hintText: "Phone",
                                    hintStyle:  TextStyle(
                                      color: Colors.white,
                                    ),
                                    focusedBorder: inputBorder,
                                    border: inputBorder,
                                    filled: true,
                                    enabledBorder: inputBorder,
                                    contentPadding: EdgeInsets.all(10),
                                    fillColor: Colors.grey
                                ),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Phone number can't be empty";
                                  }
                                  return null;
                                },
                              )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Row(
                        children: [
                          Expanded(
                              child: TextFormField(
                                controller: passwordController,
                                keyboardType: TextInputType.text,
                                obscureText: true,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle:  TextStyle(
                                      color: Colors.white,
                                    ),
                                    focusedBorder: inputBorder,
                                    border: inputBorder,
                                    filled: true,
                                    enabledBorder: inputBorder,
                                    contentPadding: EdgeInsets.all(10),
                                    fillColor: Colors.grey
                                ),
                                validator: (val){
                                  if(val!.isEmpty){
                                    return "Password can't be empty";
                                  }
                                  return null;
                                },
                              )
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      // elevated button
                      Center(
                        child: SizedBox(
                          height: 50,
                          child: ElevatedButton(onPressed: () {
                            if(formKey.currentState!.validate()){
                              signUp();
                            }
                          },
                            style: ButtonStyle(
                                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
                                shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                                    RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20)
                                    )
                                )
                            ),
                            child: !isLoading ?
                            Text("Sign Up",
                              style: TextStyle(fontSize: 18.sp, color: Colors.white),
                            ): const Center(
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(height: 10,),
                      const Center(child: Text("Or",
                        style: TextStyle(fontSize: 20, color: Colors.white),)),
                      const SizedBox(height: 10,),
                      const Center(child: Text("Create account with",
                        style: TextStyle(fontSize: 20, color: Colors.white),)),
                      const SizedBox(height: 20,),
                      const Center(child:  Image(image: AssetImage("assets/google.png"), height: 30,)),
                      const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            const Text("Already have an account?", style: TextStyle(fontSize: 20, color: Colors.white),),
                            const SizedBox(width: 10,),
                            InkWell(
                                onTap: navigateToSignInScreen,
                                child: const Text("Sign in", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold ),))
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
