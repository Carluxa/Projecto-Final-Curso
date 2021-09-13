import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:projecto_licenciatura/views/constantsFields.dart';

class Widgetsclass{

  static Widget makeinputEmail({label,icon,email,function,hintText,nome}) {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.globalformat(label),
          TextFormField(
            initialValue: nome,
              onChanged: function,
              decoration:Constants.globalformatField(icon,hepiText: hintText),
              validator: (String value){
                if (value.isEmpty) {
                  return "campo obrigatório*";
                }
                if (!RegExp(r"[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-].[a-z]").hasMatch(
                    value)) {
                  return 'Por favor, insira um endereço de e-mail válido';
                }
                return null;
              }
          ),
          SizedBox(height: 5,),
        ],
      );
  }
  static
  //todo nao guarda na db
  Widget makeinputNumber({label,icon,funtion,help,numbers}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label,),
        TextFormField(
          initialValue: numbers,
          keyboardType: TextInputType.number,
          inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
          decoration: Constants.globalformatField(icon,hepiText:help),
          onChanged: funtion,
          validator: (value){
            if(value.isEmpty)
            {
              return "Campo obrigatorio*";
            }
            if(!RegExp(r"[0-9]").hasMatch(value))
            {
              return"Por favor, insira um numero valido";
            }
            return null;
          },
        ),
        SizedBox(height: 5,),
      ],
    );
  }


  static  Widget makeinputBI({label,icon,funtion,bi}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
          initialValue: bi,
          //controller: namecon,
          decoration: Constants.globalformatField(icon,hepiText: "Introduza o número do Bilhete de Identidade",),
          onChanged: funtion,
          validator: (String value){
            if(value.isEmpty)
            {
              return "Campo obrigatorio*";
            }
            if(value.length != 13)
            {
              return "Campo invalido";
            }
            if (!RegExp (r"[0-9]+[A-Z]").hasMatch(value)) {
              return  'Por favor, insira um BI válido' ;}
            return null;
          }, ),
        SizedBox(height: 20,),
      ],
    );
  }


  static Widget makeinputNumberTelefone({label, icon, function,telefone}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
            initialValue: telefone,
            keyboardType: TextInputType.phone,
            inputFormatters: <TextInputFormatter>[FilteringTextInputFormatter.digitsOnly,],
            decoration: Constants.globalformatField(icon),
            onChanged: function,
            validator: (value){
              if(value.isEmpty)
              {
                return "Campo obrigatorio*";
              }
              if(label=='Telefone')
              {
                if(value.length==8)
                {
                  return "Numero invalido";
                }
              }
              return null;
            }),
        SizedBox(height: 5,),
      ],
    );
  }



  static makeinputSenha({helperText,senha,label,icon, pass,seePassword,function,funtionSenha,readonly}){
    return
      Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Constants.globalformat(label),
            TextFormField(
              initialValue: senha,
               readOnly: readonly,
                controller: pass,
                onChanged: function,
                validator: (String value) {
                  if (value.isEmpty) {
                    return "Porfavor Introduza senha valido";
                  }
                  return null;
                },
                obscureText: seePassword,
                decoration: InputDecoration(
                  helperText: helperText,
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
                  enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: BorderSide(color: Colors.grey[400],)
                  ),
                  focusedBorder: UnderlineInputBorder(
                      borderRadius: BorderRadius.circular(10)
                  ),
                  border: OutlineInputBorder( borderSide: BorderSide( color: Colors.grey[400], ), ),
                  prefixIcon: icon,
                  suffixIcon:  IconButton(icon: Icon(seePassword ? Icons.remove_red_eye_outlined : Icons.remove_red_eye,color: Colors.grey,),
                    onPressed: funtionSenha,),
                )
            ),SizedBox(height: 20,)
          ]);
  }

  static Widget makeinputCargo({label,icon,texthint,value,funtion,funtionItem})
  {
    return
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Constants.globalformat(label),
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[600],width: 0.3),
              borderRadius: BorderRadius.circular(10),
            ),
            padding: EdgeInsets.only(),
            child:
            DropdownButton(
              hint: texthint,
              dropdownColor: Colors.green[50],
              elevation: 5,
              icon: icon,
              iconSize: 25.0,
              underline: SizedBox(),
              isExpanded: true,
              value: value,
              items:funtionItem,
              onChanged :funtion
            ),
          ),
          SizedBox(height: 5,),
        ]
    );
  }


  static Widget makeinputName({label,icon,function,nome}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Constants.globalformat(label),
        TextFormField(
          initialValue: nome,
          decoration: Constants.globalformatField(icon),
          onChanged: function,
          validator: (String value){
            if(value.isEmpty)
            {
              return "Campo obrigatorio*";
            }
            if(value.length <= 2)
            {
              return "Nome Invalido";
            }
            return null;
          },

        ),
        SizedBox(height: 5,),
      ],
    );
  }


}