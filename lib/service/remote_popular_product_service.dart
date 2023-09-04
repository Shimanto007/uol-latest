import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';

class RemotePopularProductService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/popular?platform=app';

  Future<dynamic> get() async {
    var response = await client.get(
      Uri.parse('$remoteUrl'),
    );
    return response;
  }
}