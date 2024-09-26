import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/app_text_input_fields.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';

class AddLostAndFound extends StatefulWidget{
  const AddLostAndFound({super.key});

  @override
  AddLostAndFoundState createState()=> AddLostAndFoundState();
}


class AddLostAndFoundState extends State<AddLostAndFound>{

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  late final TextEditingController nameOnItem;
  late final TextEditingController propertyType;
  late final TextEditingController location;
  late final TextEditingController storage;
  late final TextEditingController contactPhone;
  late final TextEditingController contactPerson;
  late final TextEditingController serialNo;
  late final TextEditingController status;
  late final TextEditingController details;
  late final TextEditingController category;

  XFile? file;
  bool isLoading = false;

  bool _loading = false;

  @override
  void initState() {
    super.initState();

    nameOnItem = TextEditingController();
    propertyType = TextEditingController();
    location = TextEditingController();
    storage = TextEditingController();
    contactPhone = TextEditingController();
    contactPerson = TextEditingController();
    serialNo = TextEditingController();
    status = TextEditingController();
    details = TextEditingController();
    category = TextEditingController();

  }


  @override
  void dispose() {
    
    nameOnItem.dispose();
    propertyType.dispose();
    location.dispose();
    storage.dispose();
    contactPerson.dispose();
    contactPhone.dispose();
    serialNo.dispose();
    status.dispose();
    details.dispose();
    category.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Lost And Found",
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
                const SizedBox(height: 20,),

                Align(
                  alignment: Alignment.center,
                  child: file!=null?
                  FutureBuilder<Uint8List>(
                    future: file!.readAsBytes(), 
                    builder: (context, snapshot) {
                      
                      if(snapshot.hasData){
                        final data  = snapshot.data;

                        return Container(
                            constraints: BoxConstraints.expand(height: 200),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              border: Border.all(color: Colors.grey, width: 0.4),
                              image: DecorationImage(
                                fit: BoxFit.cover,
                                image: MemoryImage(data!))
                            ),
                          );
                      }


                      return const CircularProgressIndicator();
                    },):
                    Container(
                    constraints: BoxConstraints.expand(height: 200),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      border: Border.all(color: Colors.grey, width: 0.4),
                    ),

                    child: Center(
                      child: TextButton(
                        onPressed: ()=> showDialog(
                            context: context,
                            builder: (context) => AlertDialog(
                              content: PickerOptionsDialog(),
                            ),
                          ),
                        child: const Text(
                          "Add Image",
                          style: AppStyles.normalGreyTextStyle,
                        )),
                    ),
                  ),),
                const SizedBox(height: 50,),
                DOutlinedTextInputField(
                  hintText: "Name on item", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: nameOnItem),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Property Type", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: propertyType),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Location", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: location),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Storage", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: storage),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Contact Phone", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: contactPhone),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Contact Person", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  validator: notEmptyValidator,
                  btnHeight: 45, 
                  controller: contactPerson),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "SerialNo", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: serialNo),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Status", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: status),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Details", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: details),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Category", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: category),

                const SizedBox(height: 50,),
                _loading?
                const Center(
                  child: SizedBox(
                    height: 30, 
                    width: 30, child: CircularProgressIndicator(),),
                ):
                DSolidButton(
                  label: "Add Item", 
                  btnHeight: 45, 
                  bgColor: AppColors.primaryColor, 
                  borderRadius: 10, 
                  textStyle: AppStyles.normalWhiteTextStyle, 
                  onClick: (){
                    addLostAndFound(value);
                  }),
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


  Future<void> addLostAndFound(ChangesProvider provider)async{
    setState(() {
      _loading = true;
    });
    print("============>>>> Adding lost and found item");
    if(key.currentState!.validate() && file!=null){
      final response =  await ApiRepository().addLostAndFound(
        category: category.text, 
        details: details.text, 
        contactPhone: contactPhone.text, 
        serialNo: serialNo.text, 
        contactPerson: contactPerson.text, 
        status: status.text, 
        storage: storage.text, 
        propertyType: propertyType.text, 
        nameOnItem: nameOnItem.text, 
        location: location.text,
        file: file);

      if(response){
        provider.notifyAll();
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Failed to add Lost and found item");
      }

      
    }else{
      Fluttertoast.showToast(msg: "Make sure to add the image There");
    }

    setState(() {
      _loading = false;
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