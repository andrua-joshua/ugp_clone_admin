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

class AddMissingPerson extends StatefulWidget{
  const AddMissingPerson({super.key});

  @override
  AddMissingPersonState createState()=> AddMissingPersonState();
}


class AddMissingPersonState extends State<AddMissingPerson>{

  final GlobalKey<FormState> key = GlobalKey<FormState>();

  late final TextEditingController name;
  late final TextEditingController description;
  late final TextEditingController status;

  XFile? file;
  bool isLoading = false;
  bool _loading = false;

  @override
  void initState() {
    super.initState();

    name = TextEditingController();
    description = TextEditingController();
    status = TextEditingController();

  }


  @override
  void dispose() {
    
    status.dispose();
    description.dispose();
    name.dispose();

    super.dispose();
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Add Missing Person",
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
                  hintText: "Name of Item", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 45, 
                  validator: notEmptyValidator,
                  controller: name),

                const SizedBox(height: 20,),
                DOutlinedTextInputField(
                  hintText: "Description", 
                  hintTextStyle: AppStyles.normalGreyTextStyle, 
                  valueTextStyle: AppStyles.normalBlackTextStyle, 
                  borderColor: Colors.grey, 
                  borderRadius: 10, 
                  btnHeight: 75, 
                  validator: notEmptyValidator,
                  controller: description),

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

                const SizedBox(height: 50,),
                _loading?
                const Center(
                  child: SizedBox(
                    height: 30, 
                    width: 30, child: CircularProgressIndicator(),),
                ):DSolidButton(
                  label: "Add Person", 
                  btnHeight: 45, 
                  bgColor: AppColors.primaryColor, 
                  borderRadius: 10, 
                  textStyle: AppStyles.normalWhiteTextStyle, 
                  onClick: ()=> addMissingPerson(value)),
                const SizedBox(height: 50,),
              ],
            )),
          ),)),),
    );
  }



  String? notEmptyValidator(String? str){
    if(str!.isEmpty){
      return "Filled can't be empty";
    }

    return null;
  }


  Future<void> addMissingPerson(ChangesProvider provider)async{
    setState(() {
      _loading = true;
    });
    if(key.currentState!.validate() && file!=null){
      final response =  await ApiRepository().addMissingPerson(
        name: name.text, 
        description: description.text, 
        file: file,
        status: status.text);

      if(response){
        provider.notifyAll();
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Failed to add Missing Person");
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