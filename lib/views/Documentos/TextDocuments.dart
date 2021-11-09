import 'package:flutter/material.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';

class TextDocuments extends StatefulWidget {
  final String text1,textTitle,titletext1;
  final String text2,titletext2;
  final Function onpressedPdf;
  final Function downLoad;
  final String tb;
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
          // IconButton(icon: Icon(Icons.download_sharp,color: Colors.red,), onPressed: (){} //downLoad
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
                       widget.tb!=null?Column(
                         children: [
                           Text("Tabela 1 Valor das Taxas",
                             style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                           ),
                           Table(
                             columnWidths: {0: FractionColumnWidth(.6), 1: FractionColumnWidth(.6)},
                             border: TableBorder.all(color: Colors.blueAccent),
                             children: [
                               TableRow(
                                 children: [
                                   Text("Autorização provisória",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                   Text('600.00 MTn',style: TextStyle(fontSize: 16),),
                                 ]),
                               TableRow(
                                 children: [
                                   Text('DUAT',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                   Text('300.00 MTn',style: TextStyle(fontSize: 16),),
                                 ]
                               ),
                               TableRow(
                                 children: [
                                   Text('Taxa anual',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                   Text('300.00 MTn/HA',style: TextStyle(fontSize: 16),),
                                 ]
                               )
                             ],
                           ),
                           SizedBox(height: 30,),
                           Text("Tabela 2. índice para os ajustamentos da taxa anual relativos à localização e dimensão dos terrenos e a finalidade do seu uso",
                             style: TextStyle(fontStyle: FontStyle.italic, fontSize: 14),
                           ),
                           Table(
                             columnWidths: {0: FractionColumnWidth(.6), 1: FractionColumnWidth(.6)},
                             border: TableBorder.all(color: Colors.blueAccent),
                             children: [
                               TableRow(
                                   children: [
                                     Text("Terrenos confrontante com as  ",style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                     Text('Índice',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                   ]),
                               TableRow(
                                   children: [
                                     Text('Zonas de protecção parcial',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                     Text('1.5',style: TextStyle(fontSize: 16),),
                                   ]
                               ),
                               TableRow(
                                   children: [
                                     Text('Zonas prioritárias de desenvolvimento',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                     Text('0.5',style: TextStyle(fontSize: 16),),
                                   ]
                               ),
                               TableRow(
                                 children: [
                                   Text('Restantes Zonas',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                   Text('1.0',style: TextStyle(fontSize: 16),),
                                 ]),
                               TableRow(
                                 children: [
                                   Text('Dimensão: Até 100 Ha',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                   Text('1.0',style: TextStyle(fontSize: 16),),
                                 ]),
                                   TableRow(
                                   children: [
                                   Text('De 101 a 100 HA',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                               Text('1.5',style: TextStyle(fontSize: 16),),
                             ]),
                               TableRow(
                                   children: [
                                     Text('Superior a 1000 Ha',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                     Text('2.0',style: TextStyle(fontSize: 16),),
                                   ]),
                               TableRow(
                                   children: [
                                     Text('Finalidade do uso: Associação com fins de beneficiência',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 18),),
                                     Text('0.5',style: TextStyle(fontSize: 16),),
                                   ])
                             ],
                           ),
                         ],
                       ):Text(""),
                  ],
                ),
              ),
            ],
          ),
        ),
    );
  }
}
