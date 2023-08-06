import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:stream_app/auth_screen/sign_up_screen.dart';
import 'package:stream_app/home_screen/home_screen.dart';


class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool obscureText = true;
  bool isLoading = false;

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  signIn () async {
    setState(() {
      isLoading = true;
    });
    try{
      UserCredential userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text
      );
      var authCredential = userCredential.user;
      print(authCredential!.uid);
      if(authCredential.uid.isNotEmpty){
        setState(() {
          isLoading = false;
        });
        Navigator.push(context, CupertinoPageRoute(builder: (_) => const HomeScreen()));
      }else{
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content:  const Center(
               child: Text("Something went wrong",
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
    }on FirebaseAuthException catch (e){
      if(e.code == 'user-not-found'){
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
             SnackBar(content: const Center(
               child: Text("No user found",
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
      }else if(e.code == 'wrong-password'){
        setState(() {
          isLoading = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Center(
              child: Text("Wrong password",
                style: TextStyle(fontSize: 20),),
            ),
              backgroundColor: Colors.redAccent,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.all(Radius.circular(10))
              ),
              margin: EdgeInsets.all(50),
            ));
      }
    } catch(e){
      print(e);
    }
  }

  void navigateToSignUpScreen (){
    Navigator.push(context, MaterialPageRoute(builder: (_) => const SignUpScreen()));
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
                  child: Form(
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
              ),
              Expanded(
                child: Container(
                  height: 100,
                  width: ScreenUtil().screenWidth,
                  decoration: const BoxDecoration(
                    color: Colors.black38,
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(20.w),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(
                            height: 20.h,
                          ),
                          Text(
                            "Sign in",
                            style: TextStyle(
                                fontSize: 25.sp, color: Colors.white, fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(height: 20,),
                          Text(
                            "Login to access your account",
                            style: TextStyle(
                              fontSize: 20.sp,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 15.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: emailController,
                                  keyboardType: TextInputType.text,
                                  decoration: const InputDecoration(
                                    hintText: "Email Address",
                                    hintStyle: TextStyle(
                                        color: Colors.white,
                                    ),
                                    suffixIcon: Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Icon(Icons.email_outlined),
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
                                ),
                              ),
                            ],
                          ),
                          SizedBox(
                            height: 40.h,
                          ),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: passwordController,
                                  keyboardType: TextInputType.text,
                                  obscureText: true,
                                  decoration: const InputDecoration(
                                    hintText: "Password",
                                    hintStyle:  TextStyle(
                                        color: Colors.white,
                                    ),
                                    suffixIcon:  Padding(
                                      padding: EdgeInsets.symmetric(vertical: 10),
                                      child: Icon(Icons.lock_outline_rounded),
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
                            height: 50.h,
                          ),
                          // elevated button
                          Center(
                            child: SizedBox(
                              height: 50,
                              child: ElevatedButton(onPressed: () {
                                if(formKey.currentState!.validate()){
                                  signIn();
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
                                Text("Sign In",
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
                          const Center(child: Text("Forgot Password?",
                            style: TextStyle(fontSize: 20, color: Colors.white),)),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20,),
              const Text("Sign in with",
                style: TextStyle(
                color: Colors.white, fontSize: 20),),
              const SizedBox(height: 20,),
              const Image(image: AssetImage("assets/google.png"), height: 30,),
              const SizedBox(height: 20,),
              Padding(
                padding: const EdgeInsets.only(left: 60),
                child: Row(
                  children: [
                   Text("New to CineGH?", style: TextStyle(fontSize: 20, color: Colors.white),),
                    SizedBox(width: 10,),
                    InkWell(
                      onTap: navigateToSignUpScreen,
                        child: Text("Sign Up Now", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.bold),))
                  ],
                ),
              ),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
