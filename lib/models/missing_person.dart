/**
 * 
 * private Integer id;
    private String name;
    private String description;
    private String status;
    private Date dateReported;
    private String imgUrl;
 */

class  MissingPerson {

  final int id;
  final String name;
  final String description;
  final String status;
  final String dateReported;
  final String imgUrl;

  const MissingPerson({
    required this.dateReported,
    required this.description,
    required this.id,
    required this.imgUrl,
    required this.name,
    required this.status
  });


  factory MissingPerson.fromJson(Map<String, dynamic> json)
    => MissingPerson(
      dateReported: json["dateReported"]??"", 
      description: json["description"]??"", 
      id: json['id']??"", 
      imgUrl: json['imgUrl']??"", 
      name: json['name']??"", 
      status: json['status']??"");

  
}