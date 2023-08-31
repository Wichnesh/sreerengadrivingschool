import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sree_renga_drivingscl/utils/colorUtils.dart';
import 'package:get/get.dart';
import 'package:sree_renga_drivingscl/utils/imageUtils.dart';

import '../controller/login_Controller.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: Duration(seconds: 2),
    );

    _animation = Tween<double>(begin: .7, end: 1).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.ease,
      ),
    )
      ..addListener(
        () {
          setState(() {});
        },
      )
      ..addStatusListener(
        (status) {
          if (status == AnimationStatus.completed) {
            _controller.reverse();
          } else if (status == AnimationStatus.dismissed) {
            _controller.forward();
          }
        },
      );

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  LoginController _loginController = Get.put(LoginController());
  @override
  Widget build(BuildContext context) {
    double _width = MediaQuery.of(context).size.width;
    double _height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Colors.white,
      body: ScrollConfiguration(
        behavior: MyBehavior(),
        child: SingleChildScrollView(
          child: SizedBox(
            height: _height,
            child: Column(
              children: [
                Expanded(child: SizedBox()),
                Expanded(
                  flex: 4,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      SizedBox(
                          height: 110,
                          width: 110,
                          child: Image.asset(
                            logo,
                            height: 100,
                            width: 100,
                          )),
                      const Text(
                        'SIGN IN',
                        style: TextStyle(
                          fontSize: 25,
                          fontWeight: FontWeight.w600,
                          color: buttonColor,
                        ),
                      ),
                      const SizedBox(),
                      component(Icons.account_circle_outlined, 'User name...'),
                      component1(Icons.lock_outline, 'Password...', true),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // RichText(
                          //   text: TextSpan(
                          //     text: 'Forgotten password!',
                          //     style: const TextStyle(
                          //       color: Color(0xffA9DED8),
                          //     ),
                          //     recognizer: TapGestureRecognizer()
                          //       ..onTap = () {
                          //         HapticFeedback.lightImpact();
                          //         Fluttertoast.showToast(
                          //             msg:
                          //                 'Forgotten password! button pressed');
                          //       },
                          //   ),
                          // ),
                          // SizedBox(width: _width / 10),
                          // RichText(
                          //   text: TextSpan(
                          //     text: 'Create a new Account',
                          //     style: TextStyle(color: Color(0xffA9DED8)),
                          //     recognizer: TapGestureRecognizer()
                          //       ..onTap = () {
                          //         HapticFeedback.lightImpact();
                          //         Fluttertoast.showToast(
                          //           msg: 'Create a new Account button pressed',
                          //         );
                          //       },
                          //   ),
                          // ),
                        ],
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Stack(
                    children: [
                      Center(
                        child: Container(
                          margin: EdgeInsets.only(bottom: _width * .07),
                          height: _width * .7,
                          width: _width * .7,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: LinearGradient(
                              colors: [
                                Colors.transparent,
                                Colors.transparent,
                                Color(0xff09090A),
                              ],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter,
                            ),
                          ),
                        ),
                      ),
                      GetBuilder<LoginController>(builder: (controller) {
                        if (controller.isLoading.value) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        } else {
                          return Center(
                            child: Transform.scale(
                              scale: _animation.value,
                              child: InkWell(
                                splashColor: Colors.transparent,
                                highlightColor: Colors.transparent,
                                onTap: () {
                                  HapticFeedback.lightImpact();
                                  _loginController.onInit();
                                  _loginController.loginApiDio();
                                },
                                child: Container(
                                  height: _width * .2,
                                  width: _width * .2,
                                  alignment: Alignment.center,
                                  decoration: const BoxDecoration(
                                    color: primarycolor,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Text(
                                    'SIGN-IN',
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      })
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget component(IconData icon, String hintText) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _loginController.userNameText,
        style: TextStyle(color: Colors.white.withOpacity(.9)),
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }

  Widget component1(IconData icon, String hintText, bool isPassword) {
    double _width = MediaQuery.of(context).size.width;
    return Container(
      height: _width / 8,
      width: _width / 1.22,
      alignment: Alignment.center,
      padding: EdgeInsets.only(right: _width / 30),
      decoration: BoxDecoration(
        color: const Color(0xff212428),
        borderRadius: BorderRadius.circular(15),
      ),
      child: TextField(
        controller: _loginController.passwordText,
        style: TextStyle(color: Colors.white.withOpacity(.9)),
        obscureText: isPassword,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          prefixIcon: Icon(
            icon,
            color: Colors.white.withOpacity(.7),
          ),
          border: InputBorder.none,
          hintMaxLines: 1,
          hintText: hintText,
          hintStyle: TextStyle(
            fontSize: 14,
            color: Colors.white.withOpacity(.5),
          ),
        ),
      ),
    );
  }
}

class MyBehavior extends ScrollBehavior {
  @override
  Widget buildViewportChrome(
      BuildContext context, Widget child, AxisDirection axisDirection) {
    return child;
  }
}
