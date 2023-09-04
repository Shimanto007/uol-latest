import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';

class RemoteBestSellerProductService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/bestseller?platform=app';

  Future<dynamic> get() async {
    var response = await client.get(
      Uri.parse('$remoteUrl'),
    );
    return response;
  }
}