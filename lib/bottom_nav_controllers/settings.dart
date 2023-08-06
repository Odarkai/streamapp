import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  State<Settings> createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    const inputBorder = OutlineInputBorder(
        borderSide: BorderSide(
          color: Colors.black,
        ));
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.brown.shade900,
      body: SafeArea(
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
                    const SizedBox(height: 30,),
                    Row(
                      children: [
                        const Icon(Icons.arrow_back_ios),
                        const SizedBox(width: 60,),
                        Text(
                          "Settings",
                          style: TextStyle(fontSize: 50.sp, color: Colors.red),
                        ),
                      ],
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
                            readOnly: true,
                            textAlign: TextAlign.center,
                            decoration: const InputDecoration(
                                hintText: "Account",
                                hintStyle: TextStyle(
                                  color: Colors.white,
                                ),
                                suffixIcon:  Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.arrow_forward_ios_rounded),
                                ),
                                prefixIcon:  Padding(
                                  padding: EdgeInsets.symmetric(vertical: 10),
                                  child: Icon(Icons.person),
                                ),
                                focusedBorder: inputBorder,
                                border: inputBorder,
                                filled: true,
                                enabledBorder: inputBorder,
                                contentPadding: EdgeInsets.all(10),
                                fillColor: Colors.grey
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: "Notifications",
                                  hintStyle:  TextStyle(
                                    color: Colors.white,
                                  ),
                                  suffixIcon:  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                  prefixIcon:  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.notification_important_outlined),
                                  ),
                                  focusedBorder: inputBorder,
                                  border: inputBorder,
                                  filled: true,
                                  enabledBorder: inputBorder,
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.grey
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: "Privacy & Security",
                                  hintStyle:  TextStyle(
                                    color: Colors.white,
                                  ),
                                  suffixIcon:  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                  prefixIcon:  Padding(
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
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: "Help and Support",
                                  hintStyle:  TextStyle(
                                    color: Colors.white,
                                  ),
                                  suffixIcon:  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                  prefixIcon:  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.headphones_sharp),
                                  ),
                                  focusedBorder: inputBorder,
                                  border: inputBorder,
                                  filled: true,
                                  enabledBorder: inputBorder,
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.grey
                              ),
                            )
                        ),
                      ],
                    ),
                    SizedBox(
                      height: 30.h,
                    ),
                    Row(
                      children: [
                        Expanded(
                            child: TextFormField(
                              readOnly: true,
                              textAlign: TextAlign.center,
                              decoration: const InputDecoration(
                                  hintText: "About",
                                  hintStyle:  TextStyle(
                                    color: Colors.white,
                                  ),
                                  suffixIcon:  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.arrow_forward_ios_rounded),
                                  ),
                                  prefixIcon:  Padding(
                                    padding: EdgeInsets.symmetric(vertical: 10),
                                    child: Icon(Icons.help_outline_outlined),
                                  ),
                                  focusedBorder: inputBorder,
                                  border: inputBorder,
                                  filled: true,
                                  enabledBorder: inputBorder,
                                  contentPadding: EdgeInsets.all(10),
                                  fillColor: Colors.grey
                              ),
                            )
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
