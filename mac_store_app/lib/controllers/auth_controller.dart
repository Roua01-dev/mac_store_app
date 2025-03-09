import 'package:mac_store_app/global_variable.dart';
import 'package:mac_store_app/models/user.dart';
import 'package:http/http.dart' as http;
import 'package:mac_store_app/services/manage_http_response.dart';

class AuthController {
  Future<void> SignUpUsers({
    required context,
    required String email,
    required String password,
    required String fullname,
  }) async {
    try {
      //initailize the user model
      User user = User(
        id: '',
        fullname: fullname,
        email: email,
        password: password,
        state: '',
        city: '',
        locality: '',
      );
      //make a POST request to the server for signup
      http.Response response = await http.post(
        Uri.parse('$uri/api/signup'),
        body: user.toJson(), //convert user oject to json for the request body
        headers: <String, String>{
          'Content-Type':
              'application/json ; charset=utf-8', //specify the context type as json
        }, //set the headers for the request
      );
      manageHttpResponse(
        response: response,
        context: context,
        onSuccess: () {
          showSnackBar(context, 'Account has been Created for you ');
        },
      );
    } catch (e) {}
  }
}
