import 'package:flutter/material.dart';
import 'package:sys_health_app/screens/homeAtendente/index.dart';


class LoginAtendente extends StatefulWidget {
  const LoginAtendente({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<LoginAtendente> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Atendente"),
        ),
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
                  return HomeAtendente();
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
