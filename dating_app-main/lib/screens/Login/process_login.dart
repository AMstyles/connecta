// import 'dart:convert';

// import '../../../services/httprequest.dart';

// class Login {
//   login(username, password) async {
//     dynamic res = '';
//     // Method body
//     Map<String, String> body = {'username': username, 'password': password};
//     final httpClient = HttpClient();
//     final response = await httpClient.post('/users/flutter_user_login', body);

//     // Handle the response here (e.g., print the status code)
//     if (response.statusCode == 200) {
//       // print('Login successful');
//       final responseBody = jsonDecode(response.body);
//       final token = responseBody['data']['token'];
//       httpClient.setToken(token);
//       res = 'Success';
//     } else if (response.statusCode == 403) {
//       res = 'DiffIP';
//     } else {
//       // print('Failed to login');
//       res = 'Failed';
//     }

//     return res;
//   }
// }
