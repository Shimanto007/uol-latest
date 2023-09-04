import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';

class RemoteCategoryProductService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/get-category-products/';

  Future<dynamic> get(String id ) async {
    var response = await client.get(
        Uri.parse('$remoteUrl/$id?platform=app')
    );
    return response;
  }
}