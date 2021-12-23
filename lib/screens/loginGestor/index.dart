import 'package:flutter/material.dart';
import 'package:sys_health_app/screens/homeGestor/index.dart';

class LoginGestor extends StatefulWidget {
  const LoginGestor({Key? key}) : super(key: key);

  @override
  _LoginGestorState createState() => _LoginGestorState();
}

class _LoginGestorState extends State<LoginGestor> {
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
                Navigator.push(context, MaterialPageRoute(builder: (context) {
                  return HomeGestor();
                }));
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
