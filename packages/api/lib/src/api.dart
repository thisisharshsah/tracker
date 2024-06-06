import 'package:http/http.dart' as http;

class Api {
  final String _baseUrl = 'https://api.todoist.com/rest/v2';

  Future<http.Response> get(String path) {
    return http.get(Uri.parse('$_baseUrl$path'));
  }

  Future<http.Response> getWithAuth(String path, String token) {
    return http.get(
      headers: <String, String>{
        'authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      Uri.parse('$_baseUrl$path'),
    );
  }

  Future<http.Response> post(String path,
      {required Map<String, dynamic> body}) {
    return http.post(Uri.parse('$_baseUrl$path'), body: body);
  }

  Future<http.Response> postWithAuth(String path,
      {Map<String, dynamic>? body, required String token}) {
    return http.post(
      headers: <String, String>{
        'authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      Uri.parse('$_baseUrl$path'),
      body: body,
    );
  }

  Future<http.Response> deleteWithAuth(String path, {required String token}) {
    return http.delete(
      headers: <String, String>{
        'authorization': 'Bearer $token',
        'Accept': 'application/json',
      },
      Uri.parse('$_baseUrl$path'),
    );
  }

  Future<http.Response> postWithAuthAndFiles(String path,
      {required Map<String, dynamic> body,
      required List<http.MultipartFile> files,
      required String token}) {
    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl$path'));
    request.headers.addAll(<String, String>{
      'authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    request.fields
        .addAll(body.map((key, value) => MapEntry(key, value.toString())));
    request.files.addAll(files);
    return request.send().then((response) async {
      return http.Response.fromStream(response);
    });
  }

  Future<http.Response> postWithAuthAndFile(String path,
      {required Map<String, dynamic> body,
      required http.MultipartFile file,
      required String token}) {
    var request = http.MultipartRequest('POST', Uri.parse('$_baseUrl$path'));
    request.headers.addAll(<String, String>{
      'authorization': 'Bearer $token',
      'Accept': 'application/json',
    });
    request.fields
        .addAll(body.map((key, value) => MapEntry(key, value.toString())));
    request.files.add(file);
    return request.send().then((response) async {
      return http.Response.fromStream(response);
    });
  }
}
