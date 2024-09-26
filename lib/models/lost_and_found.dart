/**
 * 
 *     private Integer id;
    private String nameOnItem;
    private String imgUrl;
    private String propertyType;
    private String location;
    private String storage;
    private String contactPhone;
    private String contactPerson;
    private String serialNo;
    private String status;
    private String details;
    private Date dateFound;

 */


class LostAndFound {

  final String nameOnItem;
  final String imgUrl;
  final String propertyType;
  final String location;
  final String storage;
  final String contactPerson;
  final String contactPhone;
  final String serialNo;
  final String status;
  final String details;
  final String dateFound;
  final int id;


  const LostAndFound({
    required this.id,
    required this.contactPerson,
    required this.contactPhone,
    required this.dateFound,
    required this.details,
    required this.imgUrl,
    required this.location,
    required this.nameOnItem,
    required this.propertyType,
    required this.serialNo,
    required this.status,
    required this.storage
  });


  factory LostAndFound.fromJson(Map<String, dynamic> json)
    => LostAndFound(
      id: json['id'],
      contactPerson: json["contactPerson"]??"", 
      contactPhone: json["contactPhone"]??"", 
      dateFound: json["dateFound"]??"", 
      details: json["details"]??"", 
      imgUrl: json['imgUrl']??"", 
      location: json["location"]??"", 
      nameOnItem: json["nameOnItem"]??"unknown", 
      propertyType: json["propertyType"]??"", 
      serialNo: json["serialNo"]??"", 
      status: json["status"]??"", 
      storage: json["storage"]??"");




}