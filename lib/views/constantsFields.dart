import 'package:custom_navigation_bar/custom_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:projecto_licenciatura/views/Perfil_componets/Perfil_Home-view_componets.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/ItemCard_componentes.dart';
import 'package:projecto_licenciatura/views/Post/Post_screen/Post_componentes/Post_details_componentes.dart';

class Constants{
  static const Ktextcolor = Colors.black;
  static const KWhite = Colors.white;
  static const KDefaultBakcolor = Color(0xFFFFC8E6C9);
  static const KDefaultIconcolor = Colors.green;
  static const KDefaultBakMenu = Color(0xFFFFA5D6A7);
  static Color colorAccent = Color(0xff007EF4);
  static Color textColor = Color(0xff071930);
  static  String myName =  "" ;
  static const KDefaultPadding = 16.0;
  static const String editar ="Editar";
  static const String remover ="Remover";
  static const Icon editarI =Icon(Icons.edit);
  static const Icon removeI =Icon(Icons.remove);
  static const List<String> choices =<String>[editar, remover];
  static const List<Icon> choicesI =<Icon>[editarI,removeI,];
  static const List suggestTipoList = ["Cliente", "Construtor"];
  static const List <String> suggestCargoList = ["Pintor/a", "Serralheiro/a", "Marceneiro/a", "Pedreiro/a", "Ajudante", "Arquitecto/a", "Jardineiro/a", "carpinteiro","Outros"];
  static const List <String> suggestCategoriaList = ["Pintura","Rebocagem", "Serralharia", "Marcenaria", "construcao", "Jardinagem", "carpintaria","Electricidade","Outros"];
 static const List<String> suggestProvinceList = ["Maputo","Gaza", "Imhambane", "Manica", "Sofala", "Tete", "Zambezia", "Niassa", "Cabo Delegado", "Nampula",];
  static const List <String> suggestCityList =["Boane","Manhiça"," Matola","Namaacha","Maputo Cidade",
  "Chibuto","Chókwè","Macia","Manjacaze","Praia do Bilene","Xai-Xai",
    "Inhambane","Massinga","Maxixe","Quissico","Vilankulo"
        "Catandica","Chimoio","Gondola","Manica","Sussundenga"
        "Beira","Dondo","Gorongosa","Marromeu","Nhamatanda"
        "Moatize","Nhamnayábuè","Tete,Ulongué"
        "Alto Molócué","Gurué","Maganja da Costa","Milange","MocubaQuelimane"
        "Cuamba","Lichinga","Mandimba"," Marrupa","Metangula"
        "Chiúre","Mocímboa da Praia","Montepuez","Mueda","Pemba"
        "Angoche","Ilha de Moçambique","Malema","Monapo","Nacala Porto"," Nampula","Ribaué"
  ];
 static const List <String> suggestCityListMaputo =["Boane","Manhiça"," Matola","Namaacha","Maputo Cidade"];
 static const List <String> suggestCityListGaza =["Chibuto","Chókwè","Macia","Manjacaze","Praia do Bilene","Xai-Xai"];
 static const List <String> suggestCityListInhambane =["Inhambane","Massinga","Maxixe","Quissico","Vilankulo"];
 static const List <String> suggestCityListManica =["Catandica","Chimoio","Gondola","Manica","Sussundenga"];
 static const List <String> suggestCityListSofala =["Beira","Dondo","Gorongosa","Marromeu","Nhamatanda"];
 static const List <String> suggestCityListTete =["Moatize","Nhamnayábuè","Tete,Ulongué"];
 static const List <String> suggestCityListZambezia =["Alto Molócué","Gurué","Maganja da Costa","Milange","MocubaQuelimane"];
 static const List <String> suggestCityListNiassa =["Cuamba","Lichinga","Mandimba"," Marrupa","Metangula"];
 static const List <String> suggestCityListCaboDelegado =["Chiúre","Mocímboa da Praia","Montepuez","Mueda","Pemba"];
 static const List <String> suggestCityListNampula =["Angoche","Ilha de Moçambique","Malema","Monapo","Nacala Porto"," Nampula","Ribaué"];

   static List<CustomNavigationBarItem> floatingButtonsProfissional = [
    CustomNavigationBarItem(
        icon: Icon( Icons.home, color: Colors.black, ),
        title: Text( "Home" )
    ),
    CustomNavigationBarItem(
        icon: Icon( Icons.post_add_outlined, color: Colors.black, ),
        title: Text( "Post" )
    ),
    CustomNavigationBarItem(
        icon: Icon( AntDesign.plus, color: Colors.black ),
        title: Text( "Nova" )
    ),

    CustomNavigationBarItem(
        icon: Icon( AntDesign.user, color: Colors.black ),
        title: Text( "Perfil" )
    ),
    CustomNavigationBarItem(
        icon: Icon( AntDesign.wechat, color: Colors.black ),
        title: Text( "Conversa" )
    ),
  ];
 static List <CustomNavigationBarItem> floatingButtonsInteressado =  [
    CustomNavigationBarItem(
        icon: Icon( Icons.home, color: Colors.black, ),
        title: Text( "Home" )
    ),
   CustomNavigationBarItem(
       icon: Icon( Icons.post_add_outlined, color: Colors.black, ),
       title: Text( "Publicacao" )
   ),
    CustomNavigationBarItem(
        icon: Icon( AntDesign.user, color: Colors.black ),
        title: Text( "Perfil" )
    ),

    CustomNavigationBarItem(
        icon: Icon( AntDesign.wechat, color: Colors.black ),
        title: Text( "Conversa" )
    ),
  ];




  static boxDecorationCadastro()
  {
    return
    BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(
          20.0 ), );
  }

static message({text})
{return
  Container(
      child: Center(
        child: Text(text,style: TextStyle(
          color: Colors.grey,
        ),),
      )
  );
}
  static bodyPost({quantcategoria,eleImge,mapUser,currentPost,iterable})
  {
    return
      Expanded(
          child: GridView.builder(
              itemCount: quantcategoria,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                childAspectRatio: 0.75,
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
              ),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                    alignment: Alignment.center,
                    child:
                    ItemCard(
                        imagem:  eleImge[index],
                        index: index,
                        press: () =>
                            Navigator.push( context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      DetailsScreen(
                                          index: index,
                                          listElements:iterable,
                                          mapUser: mapUser,
                                           currentPost:currentPost,
                                      ), ) )
                    )
                );
              }
          )
      );
  }
  static title(context,{text})
  {return
    Container(
      alignment: Alignment.center,
      child: Text.rich(
        TextSpan( text: text,
          style: Theme
              .of( context )
              .textTheme
              .headline4
              .copyWith( color: Colors.grey[900] ),
        ),
      ),
    );
  }
  static cirlularProgress()
  {return
    Center(
        child: CircularProgressIndicator(
          backgroundColor: Colors.green[300],
          strokeWidth: 2, ) );
  }
  static globalAppBar(context,{title,action,button})
  {
    return AppBar(
      elevation: 0,
      brightness: Brightness.light,
      backgroundColor: Colors.green[50],
      title: title,
      leading: IconButton(
        onPressed: () {
          Navigator.pop( context );
        },
        icon: Icon( Icons.arrow_back_ios, size: 20, color: Colors.black, ),
      ),
      actions:action,
      bottom: button,
    );
  }

  static globalformat(label)
  { return
    Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w400,
            color: Colors.black87,
          ),),
          SizedBox(height: 5,)]);
  }

  static globalformatField(Icon icon,{hepiText,hint})
  {
    return InputDecoration(
      helperText: hepiText,
        hintText: hint,
        contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
        enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(color: Colors.grey[400],)
        ),
        focusedBorder: UnderlineInputBorder(
            borderRadius: BorderRadius.circular(10)
        ),
        prefixIcon: icon ,
        border: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey[400],
          ),
        )
    );
  }
 static Widget makebutton({label,index,function})
  {
    return
      Container(
        padding: EdgeInsets.only(top: 3, left: 3),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border(
              top: BorderSide(color: Colors.blue[900]),
              left: BorderSide(color: Colors.blue[900]),
              right: BorderSide(color: Colors.blue[900]),
              bottom: BorderSide(color: Colors.blue[900]),
            )),
        child: MaterialButton(
          minWidth: double.infinity,
          height:40,
          onPressed:function,
          color: Colors.green[400],
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(50)),
          child: Text(label, style: TextStyle(
              fontWeight: FontWeight.w600,
              fontSize: 20),),),);
  }

  static Widget appBarMain(BuildContext context,{nome,idUser}) {
    return
      AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: Colors.white,
        flexibleSpace: SafeArea(
          child: Container(
            padding: EdgeInsets.only(right: 16),
            child: Row(
              children: <Widget>[
                IconButton(
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  icon: Icon(Icons.arrow_back,color: Colors.black,),
                ),
                SizedBox(width: 2,),
                CircleAvatar(
                  backgroundColor:Colors.blueGrey[50],
                  child: Text(nome[0]),
                  maxRadius: 20,
                ),
                SizedBox(width: 12,),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      GestureDetector(
                          onTap:(){ Navigator.push(
                              context, MaterialPageRoute( builder: (_) => Perfil_Home_view(id: idUser,))
                          );},
                          child: Text(nome,style: TextStyle(fontWeight: FontWeight.w600),)),
                      SizedBox(height: 6,),
                      // Text("Online",style: TextStyle(color: Colors.green,fontSize: 12),),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
  }

  static InputDecoration textFieldInputDecoration(String hintText) {
    return InputDecoration(
        hintText: hintText,
        hintStyle: TextStyle(color: Colors.white54),
        focusedBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)),
        enabledBorder:
        UnderlineInputBorder(borderSide: BorderSide(color: Colors.white)));
  }

 static TextStyle simpleTextStyle() {
    return TextStyle(color: Colors.black, fontSize: 16);
  }

 static TextStyle biggerTextStyle() {
    return TextStyle(color: Colors.white, fontSize: 17);
  }
}