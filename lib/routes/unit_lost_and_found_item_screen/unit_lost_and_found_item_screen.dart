import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/models/lost_and_found.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_fontsize.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';

class UnitLostAndFoundScreen extends StatefulWidget{
  final LostAndFound item;
  const UnitLostAndFoundScreen({super.key, required this.item});


  @override
  UnitLostAndFoundScreenState createState() => UnitLostAndFoundScreenState();

}


class UnitLostAndFoundScreenState extends State<UnitLostAndFoundScreen>{



  bool  isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)),
        title: const Text(
          "Item Details",
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 40,),
                    Center(
                      child: Container(
                        height: 180,
                        width: 200,
                        decoration: BoxDecoration(
                            color: Colors.white,
                            image: DecorationImage(
                              fit: BoxFit.cover,
                              image: NetworkImage(widget.item.imgUrl))
                          ),
                      ),
                    ),
                    const SizedBox(height: 30,),
                    unitInfo(
                      label: "Name on Item: ", value: widget.item.nameOnItem),

                    unitInfo(
                      label: "Property Type: ", value: widget.item.propertyType),

                    unitInfo(
                      label: "Location: ", value: widget.item.location),

                    unitInfo(
                      label: "Storage: ", value: widget.item.storage),

                    unitInfo(
                      label: "Contact Person: ", value: widget.item.contactPerson),

                    unitInfo(
                      label: "Contact Phone: ", value: widget.item.contactPerson),

                    unitInfo(
                      label: "Serial Number: ", value: widget.item.serialNo),

                    unitInfo(
                      label: "Status: ", value: widget.item.status),

                    unitInfo(
                      label: "Details: ", value: widget.item.details),    
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
              label: "Delete Item", 
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



  Widget unitInfo({
    required String label,
    required String value
  })=> Padding(
    padding: const EdgeInsets.symmetric(vertical: 5),
    child:SizedBox(
        child: LayoutBuilder(
          builder: (context, constraints) {
            double width = constraints.maxWidth*0.46;
            return Row(
              children: [
                SizedBox(
                  width: width,
                  child:Text(
                  label,
                  style: const TextStyle(
                    fontSize: AppFontsize.normalFontSize,
                    color: Color.fromARGB(255, 87, 86, 86)
                  ),
                )),
                const SizedBox(width: 15,),
                Expanded(
                  child:Text(
                  value,
                  style: AppStyles.normalBlackTextStyle,
                  ))
              ],
            );
          }, ),
      ));


  Future<void> delete(ChangesProvider provider, BuildContext context)async{
    setState(() {
      isDeleting = true;
    });
    try{
      
      final res = await ApiRepository().deleteLostAndFound(id: widget.item.id);

      if(res){
        Fluttertoast.showToast(msg: "Deleted Item successfully");
        provider.notifyAll();
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Failed to delete Item");  
      }

    }catch(err){
      Fluttertoast.showToast(msg: "Failed to delete Item {Error}");
      
    }finally{
      setState(() {
        isDeleting = false;
      });
    }
}

}