import 'package:final_project/models/http_exception.dart';
import 'package:final_project/providers/auth.dart';
import 'package:final_project/utils/colors.dart';
import 'package:final_project/utils/widgets.dart';
import 'package:final_project/widgets/common_button.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

enum AuthMode { SignUp, SignIn }

class AuthScreen extends StatefulWidget {
  static const routeName = '/auth';
  const AuthScreen({super.key});

  @override
  State<AuthScreen> createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  AuthMode _authMode = AuthMode.SignIn;
  final Map<String, String> _authData = {
    "username": "Nguyen",
    "password": "123456",
  };
  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An Error Occured!'),
        content: Text(message),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text('OK'),
          ),
        ],
      ),
    );
  }

  Future<void> _submit(BuildContext context) async {
    try {
      if (_authMode == AuthMode.SignIn) {
        await Provider.of<Auth>(context, listen: false).login(
            _authData['username'] as String, _authData['password'] as String);
      }
    } on HttpException catch (error) {
      _showErrorDialog(error.toString());
    } catch (e) {
      _showErrorDialog("Error! " + e.toString());
    }
  }

  final _passwordController = TextEditingController();
  void _switchAuthMode() {
    if (_authMode == AuthMode.SignIn) {
      setState(() {
        _authMode = AuthMode.SignUp;
      });
    } else {
      setState(() {
        _authMode = AuthMode.SignIn;
      });
    }
  }

  void login(String username, String password) {}

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final deviceSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(top: statusBarHeight, left: 20, right: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            BoxEmpty.sizeBox20,
            const Text(
              "Login to Your Account",
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w700,
              ),
            ),
            BoxEmpty.sizeBox20,
            Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                color: AppColors.lightGrey,
              ),
              // height: 45,
              child: const TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'User name', // Placeholder
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.person),
                ),
              ),
            ),
            BoxEmpty.sizeBox20,
            Container(
              padding: const EdgeInsets.only(right: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                border: Border.all(
                  color: Colors.transparent,
                  width: 1.0,
                ),
                color: AppColors.lightGrey,
              ),
              // height: 45,
              child: const TextField(
                textAlign: TextAlign.left,
                decoration: InputDecoration(
                  hintText: 'Password', // Placeholder
                  border: InputBorder.none,
                  prefixIcon: Icon(Icons.password),
                ),
              ),
            ),
            BoxEmpty.sizeBox20,
            if (_authMode != AuthMode.SignIn)
              Column(
                children: [
                  Container(
                    padding: const EdgeInsets.only(right: 15),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20.0),
                      border: Border.all(
                        color: Colors.transparent,
                        width: 1.0,
                      ),
                      color: AppColors.lightGrey,
                    ),
                    // height: 45,
                    child: const TextField(
                      textAlign: TextAlign.left,
                      decoration: InputDecoration(
                        hintText: 'Password', // Placeholder
                        border: InputBorder.none,
                        prefixIcon: Icon(Icons.password),
                      ),
                    ),
                  ),
                  BoxEmpty.sizeBox20,
                ],
              ),
            CommonButton(
                title:
                    '${_authMode == AuthMode.SignIn ? 'Sign in' : 'Sign up'}',
                onPress: () => _submit(context)),
            BoxEmpty.sizeBox15,
            Row(
              children: [
                TextButton(
                  onPressed: _switchAuthMode,
                  child: Text(
                    '${_authMode == AuthMode.SignIn ? 'Create account' : 'Login'}',
                    textAlign: TextAlign.left,
                    style: Theme.of(context).textTheme.headlineMedium,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
