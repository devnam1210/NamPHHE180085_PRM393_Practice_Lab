import 'dart:convert';
import 'package:http/http.dart' as http;
import 'weather_model.dart';

class WeatherService {
  Future<Weather> fetchWeather() async {
    final url = Uri.parse(
        'https://api.open-meteo.com/v1/forecast?latitude=21.0285&longitude=105.8542&current_weather=true');
    final response = await http.get(url);
    print('DỮ LIỆU TỪ SERVER: ${response.body}');
    if (response.statusCode == 200) {
      final jsonMap = json.decode(response.body);
      return Weather.fromJson(jsonMap);
    } else {
      throw Exception('Lỗi mạng: Không thể tải thời tiết');
    }
  }
}