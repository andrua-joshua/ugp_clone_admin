/**
 * 
 * private Integer id;
    private String details;
    private  String cid;
    private String counter;
    private String traffic;
    private double longitude;
    private double latitude;
}
 */

class Station{

  final int id;
  final String details;
  final String cid;
  final String counter;
  final String traffic;
  final double longitude;
  final double latitude;
  final String name;


  const Station({
    required this.cid,
    required this.counter,
    required this.details,
    required this.id,
    required this.latitude,
    required this.longitude,
    required this.traffic,
    required this.name
  });



  factory Station.fromJson(Map<String, dynamic> json)
    => Station(
    cid: json["cid"]??"",
    counter: json["counter"]??"", 
    details: json["details"]??"", 
    id: json["id"], 
    name: json['name']??"",
    latitude: json["latitude"]??0.0, 
    longitude: json["longitude"]??0.0, 
    traffic: json['traffic']??"");


}