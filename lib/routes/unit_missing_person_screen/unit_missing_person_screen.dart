import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/models/missing_person.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_fontsize.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';

class UnitMissingPersonScreen extends StatefulWidget{
  final MissingPerson person;
  const UnitMissingPersonScreen({super.key, required this.person});



  @override
  UnitMissingPersonScreenState createState()=> UnitMissingPersonScreenState();
}


class UnitMissingPersonScreenState extends State<UnitMissingPersonScreen>{


  // final String description = "The [overflow] property's behavior is affected by the [softWrap] argument. If the [softWrap] is true or null, the glyph causing overflow, and those that follow, will not be rendered. Otherwise, it will be shown with the given overflow option.";


  bool isDeleting = false;


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          )),

        title: const Text(
          "Person Information",
          style: AppStyles.normalWhiteTextStyle,
        ),
      ),


      body: Consumer<ChangesProvider>(
        builder: (context, value, child)
         => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 10
          ),

          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const SizedBox(height: 40,),
                      Center(
                        child: Container(
                          width: 150,
                          height: 150,
                          
                          decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.person.imgUrl))
                          ),
                        ),
                      ),

                      const SizedBox(height: 40,),

                      SizedBox(
                        child: Row(
                          children: [
                            const Text(
                              "Name:",
                              style: const TextStyle(
                                fontSize: AppFontsize.normalFontSize,
                                color: Color.fromARGB(255, 87, 86, 86)
                              ),
                            ),
                            const SizedBox(width: 15,),
                            Expanded(
                              child:Text(
                              widget.person.name,
                              style: AppStyles.normalBlackTextStyle,
                              ))
                          ],
                        ),
                      ),
                      const SizedBox(height: 10,),
                      Text(
                        "Description:  ${widget.person.description}",
                        style: const TextStyle(
                          fontSize: AppFontsize.normalFontSize,
                          color: Color.fromARGB(255, 87, 86, 86)
                        ),
                      )

                    ],
                  ),
                ),),
              const SizedBox(height: 10,),
              isDeleting?
              const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              )
              : DSolidButton(
                label: "Delete person", 
                btnHeight: 45, 
                bgColor: Colors.red, 
                borderRadius: 10, 
                textStyle: AppStyles.normalWhiteTextStyle, 
                onClick: ()=> delete(value, context)),
              const SizedBox(height: 10,)
            ],
          )
          
           )),),
    );
  }


  Future<void> delete(ChangesProvider provider, BuildContext context)async{
    setState(() {
      isDeleting = true;
    });
    try{
      
      final res = await ApiRepository().deleteMissingPerson(id: widget.person.id);

      if(res){
        Fluttertoast.showToast(msg: "Deleted successfully");
        provider.notifyAll();
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Failed to delete");  
      }

    }catch(err){
      Fluttertoast.showToast(msg: "Failed to delete");
      
    }finally{
      setState(() {
        isDeleting = false;
      });
    }

  }


}