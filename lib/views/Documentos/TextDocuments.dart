import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';

class TextDocuments extends StatelessWidget {
  final String text1,textTitle,titletext1;
  final String text2,titletext2;
  final Function onpressedPdf;
  final Function downLoad;
  const TextDocuments({Key key,this.text1,this.onpressedPdf,this.downLoad,this.textTitle,this.titletext1, this.text2,this.titletext2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: Constants.globalAppBar( context,
        title: Text(
            textTitle, style: TextStyle( color: Colors.black )),
       action:[ Row(
         children: [
           IconButton(icon: Icon(Icons.picture_as_pdf,color: Colors.red,), onPressed:onpressedPdf),
           IconButton(icon: Icon(Icons.download_sharp,color: Colors.red,), onPressed: (){} //downLoad
           ),
         ],
       )] ),
        body: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              Container(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ListTile(
                        title: Text(titletext1,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(text1,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 20),),
                    ),
                    ListTile(
                      title: Text(titletext2,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(text2,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 20),)),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
