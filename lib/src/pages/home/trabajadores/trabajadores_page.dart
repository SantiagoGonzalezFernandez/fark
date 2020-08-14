//Imports that are not mine
import 'package:fark/src/utils/fadeAnimation.dart';
import 'package:fark/src/widget/FarkLogo.dart';
import 'package:flutter/material.dart';

//Imports that are mine
import 'package:fark/src/provider/users_provider.dart';
import 'package:fark/src/model/user_model.dart';

class TrabajadoresPage extends StatelessWidget {

  final usersProvider = new UsersProvider();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _crearListado()
    );
  }

  Widget _crearListado(){
    return FutureBuilder(
      future: usersProvider.cargarUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if(snapshot.hasData){

          final users = snapshot.data;

          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: users.length,
            itemBuilder: (context, index) => _crearItem(context, users[index])
          );
        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearItem(BuildContext context, UserModel user){
    return Dismissible(
      key: UniqueKey(),
      background: Container(color: Color(0xff2AB7CA)),
      onDismissed: (direction){
        //Crear un chat con ese user
      },
      child: GestureDetector(
        onTap: () => Navigator.pushNamed(context, 'profileRandom', arguments: user),
        child: FadeAnimation(
          delay: 0.2,
          child: Padding(
            padding: EdgeInsets.only(top: 10.0, bottom: 10.0, right: 20.0, left: 20.0),
            child: Stack(
              children: [
                Container( 
                  width: double.infinity,
                  height: 150,
                  decoration: BoxDecoration(
                    color: Color(0xff2AB7CA),
                    borderRadius: BorderRadius.circular(25.0),
                    boxShadow: [BoxShadow(
                      color:  Color(0xff2AB7CA),
                      blurRadius: 20.0,
                      offset: Offset(0, 10)
                    )]
                  ),
                  child: Container(
                    padding: user.fotoUrl == null  
                    ? EdgeInsets.only(top: 0.0, right: 20.0)
                    : EdgeInsets.only(top: 20.0, right: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        SizedBox(width: 20.0),
                        user.fotoUrl == null //Aca va la imagen
                        ? FarkLogo(fontSize: 54) 
                        : Image(
                          image: NetworkImage(user.fotoUrl),
                          width: 130,
                        ),
                        SizedBox(width: 20.0,),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,    
                            mainAxisAlignment: MainAxisAlignment.center,     
                            children: [
                              Text(
                                user.nombre.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                  fontSize: 23.0,
                                ),
                                overflow: TextOverflow.ellipsis,
                                softWrap: false,
                                maxLines: 2,
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                user.trabajo,
                                style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(height: 5.0),
                              Text(
                                user.experiencia.toUpperCase(),
                                style: TextStyle(
                                  fontFamily: 'ProductSans',
                                  color: Colors.white,
                                ),
                              ),
                              user.fotoUrl == null 
                              ? SizedBox(height: 0)                     
                              : SizedBox(height: 20)
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}