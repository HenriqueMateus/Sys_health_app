import 'package:flutter/material.dart';

class LoginMedico extends StatefulWidget {
  const LoginMedico({Key? key}) : super(key: key);

  @override
  _LoginMedicoState createState() => _LoginMedicoState();
}

class _LoginMedicoState extends State<LoginMedico> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'User',
              ),
            ),
            TextField(
              obscureText: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: 'Password',
              ),
            ),
            ElevatedButton(
              child: Text('Login'),
              onPressed: () {
                // Navigator.push(context, MaterialPageRoute(builder: (context) {
                //   return RegisterUser();
                // }));
              },
              // ElevatedButton(
              //   child: Text('Cadastrar'),
              //   onPressed: () {
              //     Navigator.push(context, MaterialPageRoute(builder: (context){
              //       return RegisterUser();
              //     }));
              //   },
              // )
            )],
        ),
      );
  }
}
