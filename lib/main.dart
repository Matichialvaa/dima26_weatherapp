import 'package:dima26_weatherapp/design_tokens.dart';
import 'package:flutter/material.dart';

import 'dart:ui';

void main() => runApp(const WeatherApp()); // needs a main

// equivalent to

//void main(){
//  runApp(const WeatherApp());
//}

class WeatherApp extends StatelessWidget {
  // statelesswidget is abstract class
  const WeatherApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // predefined block.
      title: 'Weather',
      debugShowCheckedModeBanner: true,
      home: const HomeScreen(),
      theme: ThemeData(fontFamily: 'Inter', useMaterial3: true),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(gradient: skyGradient),
        child: const SafeArea(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 20),
            child: WeatherCard(
              city: 'Buenos Aires',
              description: 'Clear sky',
              temperature: '25°C',
              humidity: 60,
              condition: '01d',
              windSpeed: 10,
              )
          ),
          
        )
      ),
    );
  }
}

class Glasscard extends StatelessWidget {
  final double radius;
  final Color? fill;
  final EdgeInsets padding;
  final Widget child;

  const Glasscard({
    super.key,
    this.radius = 22,
    this.fill,
    this.padding = const EdgeInsets.all(20),
    required this.child,
  });

  // tell flutter how to build widget.
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(radius),
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10), //blured filter
        child: Container(
          padding: padding,
          decoration: BoxDecoration(
            color: fill ?? Colors.white.withOpacity(0.1),
            borderRadius: BorderRadius.circular(radius),
            border: Border.all(color: Colors.white.withOpacity(0.2), width: 1),
          ),
          child: child, // container has the child. one father and several children. matapp - scaffold - container - child.
        ),
      ),
    );
  }
}

class InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;
  final String value;

  const InfoChip({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Glasscard(
      radius: 14,
      fill: AppColors.glassFill,
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [ // icono, un toque de espacio, y desp una columna dentro con numero y variable. 
          Icon(icon, size: 16, color: Colors.white),
          const SizedBox(width: 8),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(label, style: const TextStyle(fontSize: 12, color: Colors.white)),
              Text(value, style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.white)),
            ],
          ),
        ],
      ),
    );
  }
}


class WeatherIcon extends StatelessWidget {
  final String iconCode; // to match with right icon. 
  final double size;

  const WeatherIcon({
    super.key,
    required this.iconCode,
    this.size = 48,
  }); 

  @override
  Widget build(BuildContext context) {
    IconData glyph;
    Color color;

    switch (iconCode) {
      case '01d':
        glyph = Icons.wb_sunny;
        color = Colors.yellow;
        break;
      case '01n':
        glyph = Icons.nights_stay;
        color = Colors.blueGrey;
        break;
      case '02d':
      case '02n':
        glyph = Icons.cloud;
        color = Colors.grey;
        break;
      case '03d':
      case '03n':
        glyph = Icons.cloud_queue;
        color = Colors.grey;
        break;
      case '04d':
      case '04n':
        glyph = Icons.cloud_off;
        color = Colors.grey;
        break;
      case '09d':
      case '09n':
        glyph = Icons.grain; // rain
        color = Colors.blueAccent;
        break;
      case '10d':
      case '10n':
        glyph = Icons.beach_access; // rain
        color = Colors.blueAccent;
        break;
      case '11d':
      case '11n':
        glyph = Icons.flash_on; // thunderstorm
        color = Colors.yellowAccent;
        break;
      case '13d':
      case '13n':
        glyph = Icons.ac_unit; // snow
        color = Colors.lightBlueAccent;
        break;
      case '50d':
      case '50n':
        glyph = Icons.blur_on; // mist
        color = Colors.grey.shade400;
        break;
      default:
        glyph = Icons.help_outline; // unknown
        color = Colors.white70;
    }

    return Icon(glyph, size: size, color: color);
  }
}

class WeatherCard extends StatelessWidget {
  final String city;
  final String description;
  final String temperature;
  final int humidity;
  final String condition;
  final int windSpeed;
  final bool saved;

  const WeatherCard({
    super.key,
    required this.city,
    required this.description,
    required this.temperature,
    required this.humidity,
    required this.condition,
    required this.windSpeed,
    this.saved = false,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(city, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: Colors.white)),
            Icon( saved ? Icons.star : Icons.star_border, color: saved ? Colors.yellowAccent : Colors.white70),


          ],
        ),
        const SizedBox(height: 8),
        WeatherIcon(iconCode: condition, size: 64),
        const SizedBox(height: 8),
        Text(description, style: const TextStyle(fontSize: 16, color: Colors.white70)),
        const SizedBox(height: 8),
        Text(temperature, style: const TextStyle(fontSize: 32, fontWeight: FontWeight.bold, color: Colors.white)),
        const SizedBox(height: 8),
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            InfoChip(icon: Icons.water_drop, label: 'Humidity', value: '$humidity%'),
            const SizedBox(width: 16),
            InfoChip(icon: Icons.air, label: 'Wind', value: '$windSpeed km/h'),
          ],  
        ),
      ],
    );
  }
}

