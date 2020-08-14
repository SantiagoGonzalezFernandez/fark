//Imports that are not mine
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:mime_type/mime_type.dart';
import 'package:http_parser/http_parser.dart';

//Imports that are mine
import 'package:fark/src/model/user_model.dart';

class UsersProvider{
  
  final String _url = 'https://fark-37da7.firebaseio.com';

  Future<bool> crearUser(UserModel user) async{

    final url = '$_url/users.json';

    final resp = await http.post(url, body: userModelToJson(user));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<bool> editarUser(UserModel user) async{

    final url = '$_url/users/${user.id}.json';

    final resp = await http.put(url, body: userModelToJson(user));

    final decodedData = json.decode(resp.body);

    print(decodedData);

    return true;
  }

  Future<List<UserModel>> cargarUsers() async{

    final url = '$_url/users.json';
    final resp = await http.get(url);

    final Map<String, dynamic> decodedData = json.decode(resp.body);
    final List<UserModel> users = new List();


    if(decodedData == null) return [];

    decodedData.forEach((id, user) {
      final userTemp = UserModel.fromJson(user);
      userTemp.id = id;

      users.add(userTemp);
    }); 

    return users;
  }

  Future<int> borrarUser(String id) async{

    final url = '$_url/users/$id.json';
    final resp = await http.delete(url);

    print(resp.body);

    return 1;
  }

  Future<String> subirImagen(File imagen) async{
    final url = Uri.parse('https://api.cloudinary.com/v1_1/dzxc1sxnq/image/upload?upload_preset=hbxgjfqy');
    final mimeType = mime(imagen.path).split('/'); // Image/png

    final imageUploadRequest = http.MultipartRequest(
      'POST',
      url
    );

    final file = await http.MultipartFile.fromPath(
      'file', 
      imagen.path,
      contentType: MediaType( mimeType[0], mimeType[1])
    );

    imageUploadRequest.files.add(file);

    final streamResponse = await imageUploadRequest.send(); 
    final resp = await http.Response.fromStream(streamResponse);

    if(resp.statusCode != 200 && resp.statusCode != 201){
      print('Algo salio mal');
      print(resp.body);
      return null;      
    }

    final respData = json.decode(resp.body);
    print(respData);

    return respData['secure_url'];
  }

}