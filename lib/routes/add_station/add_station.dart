import 'dart:async';
import 'dart:io';
import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/repository/geolocation_service.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/app_text_input_fields.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';

class AddStation extends StatefulWidget{
  const AddStation({super.key});

  @override
  AddStationState createState()=> AddStationState();
}


class AddStationState extends State<AddStation>{

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController details;
  late final TextEditingController traffic;
  late final TextEditingController cid;
  late final TextEditingController counter;
  late final TextEditingController lat;
  late final TextEditingController lng;

  XFile? file;
  bool isLoading = false;
  bool _loading = false;
  bool _isSetting = false;

  @override
  void initState() {
    super.initState();

    name = TextEditingController();
    details = TextEditingController();
    traffic = TextEditingController();
    cid = TextEditingController();
    counter = TextEditingController();
    lat = TextEditingController();
    lng = TextEditingController();

  }


  @override
  void dispose() {
    
    name.dispose();
    details.dispose();
    traffic.dispose();
    cid.dispose();
    counter.dispose();
    lat.dispose();
    lng.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Station",
          style: AppStyles.normalBlackTextStyle,
        ),
      ),


      body: Consumer<ChangesProvider>(
        builder: (context, value, child)
         => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Form(
              key: key,
              child:Column(
              children: [
                
                const SizedBox(height: 50,),
                DOutlinedTextInputField(
                  hintText: "Name", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: name),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Details", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 75, 
                  validator: notEmptyValidator,
                  controller: details),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Traffic", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: traffic),
                
                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "CID", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: cid),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Counter", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45,
                  validator: notEmptyValidator, 
                  controller: counter),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Longitude", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  validator: notEmptyValidator,
                  btnHeight: 45, 
                  controller: lng),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Latitude", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: lat),

                const SizedBox(height: 10,),
                _isSetting? const Center(
                  child: SizedBox(
                    height: 30, 
                    width: 30, child: CircularProgressIndicator(),),
                ):
                 Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child:DSolidButton(
                  label: "Set To Current Location", 
                  btnHeight: 45, 
                  bgColor: AppColors.secondaryColor, 
                  borderRadius: 20, 
                  textStyle: AppStyles.normalWhiteTextStyle, 
                  onClick: ()=> setToCurrentLocation())),                

                const SizedBox(height: 50,),
                _loading?
                const Center(
                  child: SizedBox(
                    height: 30, 
                    width: 30, child: CircularProgressIndicator(),),
                ):
                 DSolidButton(
                  label: "Add Station", 
                  btnHeight: 45, 
                  bgColor: AppColors.primaryColor, 
                  borderRadius: 10, 
                  textStyle: AppStyles.normalWhiteTextStyle, 
                  onClick: ()=> addStation(value)),
                const SizedBox(height: 50,),
              ],
            )),
          ),)),),
    );
  }


  String? notEmptyValidator(String? str){
    if(str!.isEmpty){
      return "Filled cant be empty";
    }

    return null;
  }

  Future<void> addStation(ChangesProvider provider)async{
    setState(() {
      _loading = true;
    });
    if(key.currentState!.validate()){
      final response =  await ApiRepository().addStation(
        name: name.text, 
        cid: cid.text, 
        traffic: traffic.text, 
        longitude: double.parse(lng.text), 
        latitude: double.parse(lat.text), 
        counter: counter.text, 
        details: details.text,
        );

      if(response){
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Failed to add Station");
      }

      
    }

    setState(() {
      _loading = false;
    });
  }

  Future<void> setToCurrentLocation()async{
    setState(() {
      _isSetting = true;
    });
    final location = await GeolocationServiceGeolocatorApi().getCurrentLocation();
    setState(() {
      
      lat.text = "${location.lat}";
      lng.text = "${location.long}";
      _isSetting = false;
    });
    
  }


  Widget PickerOptionsDialog()
   => SizedBox(height: 100,
   child: Column(
    children: [
      TextButton(
        onPressed: ()=> _pickFromGallery(), 
        child: const Text(
          "Pick from gallery",
          style: AppStyles.normalBlackTextStyle,)),
      // const SizedBox(height: 10,),
      TextButton(
        onPressed: ()=> _pickFromCamera(), 
        child: const Text(
          "Take from camera",
          style: AppStyles.normalBlackTextStyle,))
    ],
   ),);


  Future<void> _pickFromGallery()async{
    
    setState(() {
      isLoading = true;  
    });

    XFile? _file = await ImagePicker().pickImage(
      source: ImageSource.gallery);

    setState(() {
      isLoading  = false;
    });

    if(_file!=null){
      setState(() {
        file = _file;
        // widget.onSelect(file!);
      });
    }
  }


  Future<void> _pickFromCamera()async{

    setState(() {
      isLoading = true;
    });

    XFile? _file = await ImagePicker().pickImage(
      source: ImageSource.camera);

    setState(() {
      isLoading = false;
    });

    if(_file!=null){
      setState(() {
        file = _file;
        // widget.onSelect(file!);
      });
    }
  }
}