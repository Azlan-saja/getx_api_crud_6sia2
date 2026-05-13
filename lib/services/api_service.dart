import 'dart:convert';
import 'package:getx_api_crud_6sia2/models/user_model.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'https://jsonplaceholder.typicode.com';

  // GET
  Future<List<UserModel>> getUsers() async {
    final response = await http.get(
      Uri.parse('$baseUrl/users'),
      headers: {'Accept': 'application/json'},
    );
    if (response.statusCode == 200) {
      final List data = jsonDecode(response.body);
      // Masukkan Data Kedalam Model User
      return data.map((user) => UserModel.fromJson(user)).toList();
    }
    return [];
  }

  // POST
  Future<UserModel?> createUser(String name, String email) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"name": name, "email": email}),
    );

    if (response.statusCode == 201) {
      return UserModel.fromJson(jsonDecode(response.body));
    }
    return null;
  }

  // PUT
  Future<bool> updateUser(int id, String name, String email) async {
    final response = await http.put(
      Uri.parse("$baseUrl/users/$id"),
      headers: {
        "Content-Type": "application/json",
        "Accept": "application/json",
      },
      body: jsonEncode({"name": name, "email": email}),
    );

    return response.statusCode == 200;
  }

  // DELETE
  Future<bool> deleteUser(int id) async {
    final response = await http.delete(
      Uri.parse("$baseUrl/users/$id"),
      headers: {"Accept": "application/json"},
    );
    return response.statusCode == 200 || response.statusCode == 204;
  }
}
