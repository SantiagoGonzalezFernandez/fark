//Imports that are not mine
import 'package:flutter/material.dart';

//Imports that are mine
import 'package:fark/src/model/user_model.dart';
import 'package:fark/src/provider/users_provider.dart';
import 'package:fark/src/utils/fadeAnimation.dart';

class ProfilePage extends StatelessWidget {

  final usersProvider = new UsersProvider();
  
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: usersProvider.cargarUsers(),
      builder: (BuildContext context, AsyncSnapshot<List<UserModel>> snapshot) {
        if(snapshot.hasData){

          final users = snapshot.data;
          return _crearPerfil(context, users[0]);

        }else{
          return Center(child: CircularProgressIndicator());
        }
      },
    );
  }

  Widget _crearPerfil(BuildContext context, UserModel user) {
    return SingleChildScrollView(
      physics: BouncingScrollPhysics(),
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                Container(
                  width: double.infinity,
                  height: 350.0,
                  decoration: BoxDecoration(
                    color: Color(0xff2AB7CA),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(30.0),
                      bottomRight: Radius.circular(30.0)
                    )
                  ),
                ),
                Positioned(
                  top: 40.0,
                  right: 20.0,
                  child: GestureDetector(
                    child: Icon(
                      Icons.edit,
                      color: Colors.white,
                    ),
                    onTap: () => Navigator.pushNamed(context, 'editProfile', arguments: user),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 50.0),
                  child: Image(
                    image: NetworkImage(user.fotoUrl),
                    height: 300.0,
                  ),
                ),
                Positioned(
                  top: 230.0,
                  child: Container(
                    width: 320.0,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.all(Radius.circular(30.0))
                    ),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: 25.0,
                        horizontal: 20.0
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          FadeAnimation(
                            delay: 0.2,
                            child: Text(
                              user.nombre.toUpperCase(),
                              style: TextStyle(
                                fontFamily: 'ProductSans',
                                fontWeight: FontWeight.bold,
                                color: Colors.black,
                                fontSize: 23
                              ),
                            ),
                          ),
                          SizedBox(height: 5.0),
                          FadeAnimation(
                            delay: 0.3,
                            child: Text(
                              user.trabajo,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0
                              ),
                            ),
                          ),
                          SizedBox(height: 8.0),
                          FadeAnimation(
                            delay: 0.5,
                            child: Text(
                              user.descripcion,
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                                height: 1.2
                              ),
                              maxLines: 2,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                )
              ],
            ),
            SizedBox(height: 20.0),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeAnimation(
                  delay: 0.7,
                  child: Container(
                    height: 50.0,
                    width: 150.0,
                    margin: EdgeInsets.symmetric(horizontal: 50.0),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50.0),
                      color: Color(0xff2AB7CA)
                    ),
                    child: Center(
                      child: Text(
                        'Descargar CV',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          fontFamily: 'ProductSans'
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 20.0),
                FadeAnimation(
                  delay: 1,
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Text(
                              'Edad'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              user.edad.toString(),
                              style: TextStyle(
                                color: Color(0xff2AB7CA),
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            Text(
                              'Experiencia'.toUpperCase(),
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 18.0
                              ),
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              user.experiencia,
                              style: TextStyle(
                                color: Color(0xff2AB7CA),
                                fontSize: 22.0,
                                fontWeight: FontWeight.bold
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ],  
            )
          ],
        ),
      ),
    );
  }
}