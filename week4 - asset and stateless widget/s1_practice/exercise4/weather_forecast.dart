import 'package:flutter/material.dart';

enum WeatherCondition {
  sunny,
  rainy,
  cloudy,
  snowy,
  windy,
  foggy,
  thundery,
  unknown
}

class WeatherForecast extends StatelessWidget {
  final WeatherCondition weatherCondition;
  final double maxTem;
  final double minTem;
  final String location;
  final String date;

  const WeatherForecast(
      {super.key,
      required this.weatherCondition,
      required this.maxTem,
      required this.minTem,
      required this.date,
      required this.location});

  Color getWeatherBackgroundColor(){
    switch (weatherCondition){
      case WeatherCondition.sunny:
        return Colors.yellow;
      case WeatherCondition.rainy:
        return Colors.blue;
      case WeatherCondition.cloudy:
        return Colors.grey;
      case WeatherCondition.snowy:
        return Colors.white;
      case WeatherCondition.windy:
        return Colors.green;
      case WeatherCondition.foggy:
        return Colors.grey;
      case WeatherCondition.thundery:
        return Colors.yellow;
      case WeatherCondition.unknown:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

 Icon getWeatherIcon(){
    switch (weatherCondition){
      case WeatherCondition.sunny:
        return const Icon(Icons.wb_sunny, color: Colors.black);
      case WeatherCondition.rainy:
        return const Icon(Icons.beach_access, color: Colors.black);
      case WeatherCondition.cloudy:
        return const Icon(Icons.cloud, color: Colors.black);
      case WeatherCondition.snowy:
        return const Icon(Icons.ac_unit, color: Colors.black);
      case WeatherCondition.windy:
        return const Icon(Icons.air, color: Colors.black);
      case WeatherCondition.foggy:
        return const Icon(Icons.cloud_queue, color: Colors.black);
      case WeatherCondition.thundery:
        return const Icon(Icons.flash_on, color: Colors.black);
      case WeatherCondition.unknown:
        return const Icon(Icons.help, color: Colors.black);
      default:
        return const Icon(Icons.help, color: Colors.black);
    }
  }



  @override
  Widget build(BuildContext context) {
    //weather card widget
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: getWeatherBackgroundColor(),
        borderRadius: BorderRadius.circular(20),
      ),
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              getWeatherIcon(),
              const SizedBox(width: 10),
              Text(
                location,
                style: const TextStyle(color: Colors.black, fontSize: 24),
              ),
            ],
          ),
          const SizedBox(height: 10),
          Text(
            date,
            style: const TextStyle(color: Colors.black, fontSize: 12),
          ),
          const SizedBox(height: 10),
          Row(
            children: [
              Text(
                'Max: $maxTem°C',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
              const SizedBox(width: 10),
              Text(
                'Min: $minTem°C',
                style: const TextStyle(color: Colors.black, fontSize: 16),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

void main() {
  runApp(
    MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          title: const Text("Weather Forecast"),
        ),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: ListView(
            children: const [
              WeatherForecast(
                weatherCondition: WeatherCondition.sunny,
                maxTem: 30,
                minTem: 20,
                date: "2022-10-10",
                location: "Cambodia",
              ),
              SizedBox(height: 20),
              WeatherForecast(
                weatherCondition: WeatherCondition.rainy,
                maxTem: 25,
                minTem: 15,
                date: "2022-10-11",
                location: "Malaysia",
              ),
              SizedBox(height: 20),
              WeatherForecast(
                weatherCondition: WeatherCondition.cloudy,
                maxTem: 28,
                minTem: 18,
                date: "2022-10-12",
                location: "Singapore",
              ),
              SizedBox(height: 20),
              WeatherForecast(
                weatherCondition: WeatherCondition.snowy,
                maxTem: 10,
                minTem: 0,
                date: "2022-10-13",
                location: "Korea",
              ),
              SizedBox(height: 20),
              WeatherForecast(
                weatherCondition: WeatherCondition.windy,
                maxTem: 20,
                minTem: 10,
                date: "2022-10-14",
                location: "Japan",
              ),
              SizedBox(height: 20),
              WeatherForecast(
                weatherCondition: WeatherCondition.foggy,
                maxTem: 15,
                minTem: 5,
                date: "2022-10-15",
                location: "China",
              ),
              SizedBox(height: 20),
              WeatherForecast(
                weatherCondition: WeatherCondition.thundery,
                maxTem: 35,
                minTem: 25,
                date: "2022-10-16",
                location: "Thailand",
              ),
              SizedBox(height: 20),
              WeatherForecast(
                weatherCondition: WeatherCondition.unknown,
                maxTem: 0,
                minTem: 0,
                date: "2022-10-17",
                location: "Unknown",
              ),
            ],
          ),
        ),
      ),
    ),
  );
}
