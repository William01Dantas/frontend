import 'package:http/http.dart' as http;

class Auth{
  Future<void> getToken(String username, String password) async {
    final url = Uri.parse('http://172.17.192.1:8000/token');

    final response = await http.post(
      url,
      body: {
        'username': username,
        'password': password,
      },
    );

    if (response.statusCode == 200) {
      final token = response.body;
      print('Token obtido com sucesso: $token');
    } else {
      print('Erro ao obter o token: ${response.statusCode}');
    }
  }
}
