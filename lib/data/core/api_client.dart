import 'package:http/http.dart' as http;
import 'package:mausam/common/exception/app_exception.dart';
import 'package:mausam/data/core/api_constants.dart';

class ApiClient {
  dynamic getWeatherFromLocation(String location) async {
    http.Response response = await http.post(
      Uri.http(
        ApiConstant.mainUrl,
        '/v1/current.json',
        {
          "key": ApiConstant.apiKey,
          "q": location,
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else if (response.statusCode == 400) {
      throw BadRequestException();
    } else {
      throw Exception();
    }
  }

  dynamic getWeatherFromValue(double latitude, double longitude) async {
    http.Response response = await http.post(
      Uri.http(
        ApiConstant.mainUrl,
        '/v1/current.json',
        {
          "key": ApiConstant.apiKey,
          "q": "$latitude, $longitude",
        },
      ),
    );
    if (response.statusCode == 200) {
      return response.body;
    } else {
      throw Exception();
    }
  }
}
