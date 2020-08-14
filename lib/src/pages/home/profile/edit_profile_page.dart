//Imports that are not mine
import 'dart:io';
import 'package:dropdownfield/dropdownfield.dart';
import 'package:flutter/material.dart';

//Imports that are mine
import 'package:fark/src/model/user_model.dart';
import 'package:fark/src/utils/validacion.dart';
import 'package:fark/src/provider/users_provider.dart';
import 'package:image_picker/image_picker.dart';

class EditProfilePage extends StatefulWidget {
  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {

  final formKey       = GlobalKey<FormState>();
  final scaffoldKey   = GlobalKey<ScaffoldState>();
  final userProvider  = UsersProvider();

  UserModel user = new UserModel();
  bool _guardando = false;
  File foto;

  @override
  Widget build(BuildContext context) {

    final UserModel userData = ModalRoute.of(context).settings.arguments;
    if(userData != null){
      user = userData;
    }

    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      appBar: AppBar(
        centerTitle: true,
        title: Text('Editar Perfil'),
        backgroundColor: Color(0xff2AB7CA),
        actions: [
          IconButton(
            icon: Icon(Icons.photo_size_select_actual),
            onPressed: _seleccionarFoto,
          )
        ],
      ),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        child: Container(
          padding: EdgeInsets.all(15.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _mostrarFoto(),
                _crearNombre(),
                _crearDescripcion(),
                _crearEdad(),
                SizedBox(height: 20.0),
                _crearTrabajo(),
                SizedBox(height: 20.0),
                _crearExperiencia(),
                SizedBox(height: 20.0),
                _crearBoton()
              ],
            ),
          ),
        ),
      )
    );
  }

  Widget _crearNombre(){
    return TextFormField(
      cursorColor: Color(0xff2AB7CA),
      initialValue: user.nombre,
      keyboardType: TextInputType.name,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Nombre Completo'
      ),
      validator: (value) {
        if(value.length < 3){
          return 'Ingrese su nombre completo';
        }else if(value.length >= 20){
          return 'Maximo 20 caracteres';
        }else{
          return null;
        }
      },
      onSaved: (newValue) => user.nombre = newValue,
    );
  }

  Widget _crearDescripcion(){
    return TextFormField(
      cursorColor: Color(0xff2AB7CA),
      initialValue: user.descripcion,
      textCapitalization: TextCapitalization.sentences,
      decoration: InputDecoration(
        labelText: 'Descripcion'
      ),
      validator: (value) {
        if(value.length < 3){
          return 'Ingrese una descripcion mas amplia';
        }else if(value.length >= 76){
          return 'Maximo 76 caracteres';
        }else{
          return null;
        }
      },
      onSaved: (newValue) => user.descripcion = newValue,
    );
  }

  Widget _crearEdad(){
    return TextFormField(
      cursorColor: Color(0xff2AB7CA),
      initialValue: user.edad.toString(),
      keyboardType: TextInputType.numberWithOptions(decimal: false),
      decoration: InputDecoration(
        labelText: 'Edad'
      ),
      validator: (value) {
        if(isNumeric(value)){
          if(value.length >= 3){
            return 'El numero es demasiado alto';
          }else{
            return null;
          }
        }else{
          return 'Solo numeros';
        }
      },
      onSaved: (newValue) => user.edad = int.parse(newValue),
    );
  }

  Widget _crearTrabajo(){
    return DropDownField(
      value: user.trabajo,
      controller: jobSelected,
      hintText: 'Trabajo',
      enabled: true,
      items: jobs,
      itemsVisibleInDropdown: 5,
      textStyle: TextStyle(
        fontWeight: FontWeight.normal
      ),
      onValueChanged: (value) {
        setState(() {
          user.trabajo = value;
        });
      },
    );
  }

  Widget _crearExperiencia(){
    return DropDownField(
      value: user.experiencia,
      controller: experienciaSelected,
      hintText: 'Experiencia',
      enabled: true,
      items: experiencias,
      itemsVisibleInDropdown: 5,
      textStyle: TextStyle(
        fontWeight: FontWeight.normal
      ),
      onValueChanged: (value) {
        setState(() {
          user.experiencia = value;
        });
      },
    );
  }

  Widget _crearBoton(){
    return RaisedButton(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 0.0, vertical: 15.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.save,
              color: Colors.white,
            ),
            SizedBox(width: 5.0),
            Text(
              'Guardar',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16.0,
                fontFamily: 'ProductSans'
              ),
            ),
          ],
        ),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50.0)
      ),
      elevation: 0.0,
      color: Color(0xff2AB7CA),
      onPressed: (_guardando) ? null : _submit,
    );
  }

  void _submit() async{

    if(!formKey.currentState.validate() || user.experiencia.isEmpty || user.trabajo.isEmpty){
      return;
    }

    formKey.currentState.save();

    setState(() {
      _guardando = true;
    });

    if(foto != null){
      user.fotoUrl = await userProvider.subirImagen(foto);
    }

    if(user.id == null){
      userProvider.crearUser(user);
    }else{
      userProvider.editarUser(user);
    }

    mostrarSnackBar('Cambio guardado');

    Navigator.pop(context);
  }

  void mostrarSnackBar(String mensaje){
    final snackBar = SnackBar(
      content: Text(mensaje),
      duration: Duration(milliseconds: 1500),
    );
    
    scaffoldKey.currentState.showSnackBar(snackBar);
  }

  Widget _mostrarFoto(){
    if(user.fotoUrl != null){
      return FadeInImage(
        image: NetworkImage(user.fotoUrl),
        height: 300.0,
        fit: BoxFit.cover,
        placeholder: AssetImage('assets/image/icon/icon.png'),
      );
    }else{
      return Image(
        image: AssetImage(foto?.path ?? 'assets/image/icon/icon.png'),
        height: 300.0,
        fit: BoxFit.cover,
      );
    }
  }

  _seleccionarFoto() async{

    final _picker = ImagePicker();

    final pickedFile = await _picker.getImage(
      source: ImageSource.gallery
    );

    foto = File(pickedFile.path);

    if(foto != null){
      user.fotoUrl = null;
    }

    setState(() {});
  }
}

String selectJob = '';
final jobSelected = TextEditingController();
List<String> jobs = [
  'Sin Definir',
  'Flutter Developer',
  'Android Developer',
  'IOS Developer',
  'Agile Coach',
  'Panadero',
  'Albanil',
  'Carpintero',
  'Plomero',
  'Electricista',
  'Arquitecto',
  'Astronomo',
  'Abogado',
  'Disenador',
  'Dentista',
  'Economista'
];

String selectExperiencia = '';
final experienciaSelected = TextEditingController();
List<String> experiencias = [
  'Sin Definir',
  'Entry',
  'JR',
  'SSR',
  'SR',
  'Master'
];