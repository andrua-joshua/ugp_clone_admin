import 'dart:convert';

// import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:ugp_clone_admin/models/lost_and_found.dart';
import 'package:ugp_clone_admin/models/missing_person.dart';
import 'package:ugp_clone_admin/models/report.dart';
import 'package:ugp_clone_admin/models/station.dart';
import 'package:ugp_clone_admin/utils/app_constants.dart';

class ApiRepository {


  Future<List<LostAndFound>> getAllLostAndFound()async{
    final uri = Uri.parse("${AppConstants.baseUrl}lostAndFound/getAll");

    try{

      final response = await http.get(
        uri
      );


      if(response.statusCode == 200){
        print("data fetched succ: ${response.body}");
        final data = jsonDecode(response.body) as List;

        return data.map((element)=> LostAndFound.fromJson(element)).toList();
      }else{
        print("there wasnt  any data printed by the server");
        return [];
      }

    }catch(err){
      print("error fetching data:   $err");
      rethrow;
    }

  }


  Future<List<MissingPerson>> getAllMissingPerson()async{
    final uri = Uri.parse("${AppConstants.baseUrl}missingPerson/getAll");

    try{

      final response = await http.get(
        uri
      );


      if(response.statusCode == 200){
        final data = jsonDecode(response.body) as List;

        return data.map((element)=> MissingPerson.fromJson(element)).toList();
      }else{
        print("there wasnt  any data printed by the server");
        return [];
      }

    }catch(err){
      print("error fetching data:  $err");
      rethrow;
    }

  }



  Future<List<Report>> getAllReports()async{
    final uri = Uri.parse("${AppConstants.baseUrl}report/getAllReports");

    try{

      final response = await http.get(
        uri
      );


      if(response.statusCode == 200){
        final data = jsonDecode(response.body) as List;

        return data.map((element)=> Report.formJson(element)).toList();
      }else{
        print("there wasnt  any data printed by the server");
        return [];
      }

    }catch(err){
      print("error fetching data:  $err");
      rethrow;
    }

  }



  Future<List<Station>> getAllStatations()async{
    final uri = Uri.parse("${AppConstants.baseUrl}station/getAll");

    try{

      final response = await http.get(
        uri
      );


      if(response.statusCode == 200){
        final data = jsonDecode(response.body) as List;

        return data.map((element)=> Station.fromJson(element)).toList();
      }else{
        print("there wasnt  any data printed by the server");
        return [];
      }

    }catch(err){
      print("error fetching data:   $err");
      rethrow;
    }

  }



  /**
   * 
   * private String category;
    private String details;
    private String type;
    private String firstname;
    private String lastname;
    private String phone;
    private double longitude;
    private double latitude;
   */

  Future<void> makeReport({
    required String category,
    required String details,
    required String type,
    required String lastname,
    required String firstname,
    required String phone,
    double? lng,
    double? lat,
    XFile? attachment
  })async{
    final uri = Uri.parse("${AppConstants.baseUrl}report/addReport");

    try{

      final req =  http.MultipartRequest("post",uri);

      req.fields['category'] = category;
      req.fields['details'] = details;
      req.fields['type'] = type;
      req.fields['firstname'] = firstname;
      req.fields['lastname'] = lastname;
      req.fields['phone'] = phone;
      req.fields['longitude'] = "${lng??0.0}";
      req.fields['latitude'] = "${lat??0.0}";
     if(attachment!=null){
          final image = await http.MultipartFile.fromPath(
            "attachment", attachment.path);

          req.files.add(image);
        
        }
     

      final res = await req.send();

      if(res.statusCode == 200){
        return;
      }
      else{
        print("failed to send report");
      }


      

    }catch(err){
      print("error fetching data:   $err");
      rethrow;
    }

  }



  Future<bool> addMissingPerson({
    required String name,
    required String description,
    required String status,
    XFile? file
  })async{
    final uri = Uri.parse("${AppConstants.baseUrl}missingPerson/addMissingPerson");

    try{

      final req =  http.MultipartRequest("post",uri);

      req.fields['name'] = name;
      req.fields['description'] = description;
      req.fields['status'] = status;
      if(file!=null){
          final image = await http.MultipartFile.fromPath(
            "file", file.path);

          req.files.add(image);
        
        }
      

      final res = await req.send();

      if(res.statusCode == 200){
        return true;
      }
      else{
        print("failed to Add Missing person");
        return false;
      }


      

    }catch(err){
      print("error fetching data:   $err");
      rethrow;
    }

  }





  Future<bool> addLostAndFound({
    required String category,
    required String details,
    required String contactPhone,
    required String serialNo,
    required String contactPerson,
    required String status,
    required String storage,
    required String propertyType,
    required String nameOnItem,
    required String location,
    XFile? file
  })async{
    final uri = Uri.parse("${AppConstants.baseUrl}lostAndFound/addLostAndFound");

    try{

      final req =  http.MultipartRequest("POST",uri);

      req.fields['category'] = category;
      req.fields['details'] = details;
      req.fields['location'] = location;
      req.fields['propertyType'] = propertyType;
      req.fields['storage'] = storage;
      req.fields['contactPhone'] = contactPhone;
      req.fields['contactPerson'] = contactPerson;
      req.fields['serialNo'] = serialNo;
      req.fields['status'] = status;
      if(file!=null){
          final image = await http.MultipartFile.fromPath(
            "file", file.path);

          req.files.add(image);
        
        }
      

      final res = await req.send();

      if(res.statusCode == 200){
        return true;
      }
      else{
        print(":::>>>>Failed to add Lost And Found: ${res.statusCode}");
        return false;
      }


      

    }catch(err){
      print(">>>>>>>Error fetching data:   $err");
      rethrow;
    }

  }


  /**
   * {
  "name": "StationZ",
  "cid": "GenZ",
  "traffic": "non",
  "longitude":30.294,
  "latitude": -67.900,
  "counter": "counter",
  "details": "this is the details part"
}
   */

  Future<bool> addStation({
    required String name,
    required String cid,
    required String traffic,
    required double longitude,
    required double latitude,
    required String counter,
    required String details
  })async{

    final uri = Uri.parse("${AppConstants.baseUrl}station/addStation");

    final payload = {
        "name": name,
        "cid": cid,
        "traffic": traffic,
        "longitude":longitude,
        "latitude": latitude,
        "counter": counter,
        "details": details
      };

    try{

      final response = await http.post(
        uri,
        headers: {
          "Content-Type": "application/json"
        },
        body: jsonEncode(payload)
      );

      if(response.statusCode == 200){
        print("Station added successfuly");
        return true;
      }else{
        print("Failed to add station");
        return false;
      }

    } catch(err){
      print("Error adding the station:  $err");
      rethrow;
    }   

  }


  Future<bool> deleteMissingPerson({
    required int id
  })async{

    final uri = Uri.parse("${AppConstants.baseUrl}missingPerson/delete/$id");

    try{

      final res = await http.delete(uri);

      if(res.statusCode == 200){
        return true;
      }else {
        return false;
      }
    }catch(e){
      print(":::::::::::Failed to delet missing person:  $e");
      rethrow;
    }

  }


  Future<bool> deleteLostAndFound({
    required int id
  })async{
    
    final uri = Uri.parse("${AppConstants.baseUrl}lostAndFound/delete/$id");

    try{

      final res = await http.delete(uri);

      if(res.statusCode == 200){
        return true;
      }else {
        return false;
      }
    }catch(e){
      print(":::::::::::Failed to delete Lost and found:  $e");
      rethrow;
    }
  }

  Future<bool> deleteStation({
    required int id
  })async{
    
    final uri = Uri.parse("${AppConstants.baseUrl}station/delete/$id");

    try{

      final res = await http.delete(uri);

      if(res.statusCode == 200){
        return true;
      }else {
        return false;
      }
    }catch(e){
      print(":::::::::::Failed to delete Station:  $e");
      rethrow;
    }


  }


  Future<bool> deleteReport({
    required int id
  })async{
    
    final uri = Uri.parse("${AppConstants.baseUrl}report/delete/$id");

    try{

      final res = await http.delete(uri);

      if(res.statusCode == 200){
        return true;
      }else {
        return false;
      }
    }catch(e){
      print(":::::::::::Failed to delete report:  $e");
      rethrow;
    }


  }


}