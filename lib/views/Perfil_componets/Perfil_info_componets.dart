import 'package:flutter/material.dart';

class perfil_info extends StatelessWidget {
  final String text;
  final IconData icon;
  final Function onpressed;

  const perfil_info({Key key, @required this.text, @required this.icon, @required this.onpressed}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onpressed,
      child: Card(
          color: Colors.grey[300],
           margin: EdgeInsets.symmetric(vertical: 10,horizontal: 25),
           child: ListTile(
                leading: Icon(
                  icon,
                  color: Colors.black,
                ),
             title: Text(text,style: TextStyle(
               color: Colors.black,

             ),),
           ),

          ),
    );
  }
}
