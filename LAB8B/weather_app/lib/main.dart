import 'package:flutter/material.dart';
import 'weather_service.dart';
import 'weather_model.dart';

void main() {
  runApp(MaterialApp(home: WeatherScreen()));
}

class WeatherScreen extends StatefulWidget {
  @override
  _WeatherScreenState createState() => _WeatherScreenState();
}

class _WeatherScreenState extends State<WeatherScreen> {
  final WeatherService _weatherService = WeatherService();
  late Future<Weather> _weatherFuture;

  @override
  void initState() {
    super.initState();
    _loadWeather();
  }

  void _loadWeather() {
    setState(() {
      _weatherFuture = _weatherService.fetchWeather();
    });
  }

  String getRecommendation(double temp) {
    if (temp < 20) return "Trời khá lạnh, nhớ mang theo áo khoác nhé!";
    if (temp > 33) return "Trời rất nóng, nhớ bôi kem chống nắng!";
    return "Thời tiết rất đẹp để ra ngoài đi dạo!";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Trợ lí thời tiết.'),),
      body: Center(
        child: FutureBuilder<Weather>(
          future: _weatherFuture,
          builder:(context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            }
            else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Lỗi: ${snapshot.error}', textAlign: TextAlign.center),
                  ElevatedButton(
                    onPressed: _loadWeather, // Nút Retry
                    child: Text('Thử lại'),
                  )
                ],
              );
            }
            else if (snapshot.hasData) {
              final weather = snapshot.data!;
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.thermostat, size: 80, color: Colors.orange),
                  Text(
                    '${weather.temperature} °C',
                    style: TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 20),
                  // Hiển thị gợi ý cho người dùng
                  Text(
                    getRecommendation(weather.temperature),
                    style: TextStyle(fontSize: 18, color: Colors.blueAccent),
                    textAlign: TextAlign.center,
                  ),
                ],
              );
            }
            return Text('Không có dữ liệu');
          },
          )
        )
    );
  }
}
