import 'package:http/http.dart' as http;
import 'package:uol_new/constant.dart';

class RemoteBannerService {
  var client = http.Client();
  var remoteUrl = '$baseUrl/settings?platform=app';

  Future<dynamic> get() async {
    var response = await http.get(
      Uri.parse('$remoteUrl')
    );
    // print(response.body);
    return response;
  }
}