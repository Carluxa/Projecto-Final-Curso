import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';

class TextDocuments extends StatefulWidget {
  final String text1,textTitle,titletext1;
  final String text2,titletext2;
  final Function onpressedPdf;
  final Function downLoad;
  final Table tb;
  final String diagrama;
  const TextDocuments({Key key,this.text1,this.onpressedPdf,this.downLoad,this.textTitle,this.titletext1, this.text2,this.titletext2,this.tb,this.diagrama}) : super(key: key);

  @override
  _TextDocumentsState createState() => _TextDocumentsState();
}

class _TextDocumentsState extends State<TextDocuments> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
       appBar: Constants.globalAppBar( context,
        title: Text(
            widget.textTitle, style: TextStyle( color: Colors.black )),
       action:[ Row(
         children: [
           IconButton(icon: Icon(Icons.picture_as_pdf,color: Colors.red,), onPressed:widget.onpressedPdf),
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
                        title: Text(widget.titletext1,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(widget.text1,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 20),),
                    ),
                    ListTile(
                      title: Text(widget.titletext2,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
                        subtitle: Text(widget.text2,textAlign:TextAlign.justify, style: TextStyle(color: Colors.black,fontSize: 20),)),
                       widget.diagrama!=null?Image.asset(widget.diagrama):Container(),
                       Table(
                         defaultColumnWidth: FlexColumnWidth(.6),
                         border: TableBorder.all(color: Colors.blueAccent),
                         children: [
                           TableRow(
                             children: [
                               SizedBox(width:20,child: Text("Autorização provisória")),
                               Text('600.00 MTn'),
                             ]),
                           TableRow(
                             children: [
                               Text('DUAT'),
                               Text('300.00 MTn'),
                             ]
                           ),
                           TableRow(
                             children: [
                               Text('Taxa anual'),
                               Text('300.00 MTn/HA'),
                             ]
                           )
                         ],
                       )
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
