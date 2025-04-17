// ignore_for_file: public_member_api_docs, sort_constructors_first
class Weather {
  final String id;
  final String city;
  final double wind;
  final double hum;
  final double temp;
  final String desc;
  final  String iconImage ;
  final String  localTime  ;
  Weather({
    required this.id,
    required this.city,
    required this.wind,
    required this.hum,
    required this.temp,
    required this.desc,
    required this.iconImage,
    required this.localTime,
  });

  Weather.empty() : this(id: '', city: '', wind: 0, hum: 0, temp: 0, desc: '', iconImage: '', localTime: ''); // dummy 
}
