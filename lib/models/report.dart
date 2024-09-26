class Report{

  final int id;
  final String category;
  final String details;
  final String type;
  final String firstname;
  final String lastname;
  final String phone;
  final String attachment;
  final double longitude;
  final double latitude;



  const Report({
    required this.attachment,
    required this.category,
    required this.details,
    required this.firstname,
    required this.id,
    required this.lastname,
    required this.latitude,
    required this.longitude,
    required this.phone,
    required this.type
  });


  factory Report.formJson(Map<String, dynamic> json)
    => Report(
      attachment: json['attachment']??"", 
      category: json['category']??"", 
      details: json['details']??"", 
      firstname: json['firstname']??"", 
      id: json['id']??"", 
      lastname: json['lastName']??"", 
      latitude: json['latitude']??"", 
      longitude: json['longitude']??"", 
      phone: json['phone']??"", 
      type: json['type']??"");
}