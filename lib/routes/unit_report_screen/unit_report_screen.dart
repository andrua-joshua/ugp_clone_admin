import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/models/report.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/routes.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_fontsize.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';
import 'package:url_launcher/url_launcher.dart';

class UnitReportScreen extends StatefulWidget{
  final Report report;
  const UnitReportScreen({super.key, required this.report});


  @override
  UnitReportScreenState createState() => UnitReportScreenState();

}


class UnitReportScreenState extends State<UnitReportScreen>{


  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Report Details", style: AppStyles.titleBlackTextStyle,),
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
                      Text(widget.report.type.toUpperCase(), style: AppStyles.titleBoldBlackTextStyle,),
                      const SizedBox(height: 20,),
                      unitInfo(
                        label: "Category", value: widget.report.category),

                      unitInfo(
                        label: "Details", value: widget.report.details),
                      
                      widget.report.attachment.isNotEmpty? Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child:DSolidButton(
                        label: "Check Attachment", 
                        btnHeight: 45, 
                        bgColor: AppColors.primaryColor, 
                        borderRadius: 10, 
                        textStyle: AppStyles.normalWhiteTextStyle, 
                        onClick: (){
                          launchUrl(Uri.parse(widget.report.attachment));
                        })): const Center(
                          child: Text("No Attachment provided", style: AppStyles.normalGreyTextStyle,),
                        ),

                      const SizedBox(height: 20,),

                      const Text("Reporter details", style: AppStyles.normalBlackTextStyle,),
                      unitInfo(
                        label: "First Name", value: widget.report.firstname),
                      unitInfo(
                        label: "Last Name", value: widget.report.lastname),
                      unitInfo(
                        label: "Phone", value: widget.report.phone),
                      DSolidButton(
                        label: "Check Location", 
                        btnHeight: 45, 
                        bgColor: Colors.orange, 
                        borderRadius: 10, 
                        textStyle: AppStyles.normalWhiteTextStyle, 
                        onClick: ()=> Navigator.pushNamed(
                          context, RouteGenerator.googleMapsScreen,
                          arguments: Marker(
                            markerId: MarkerId("${widget.report.id}"),
                            position: LatLng(widget.report.latitude, widget.report.longitude)
                            )))
                    ],
                  ),
                )),
              const SizedBox(height: 10,),
              isDeleting?
              const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              )
              :DSolidButton(
                label: "Delete Report", 
                btnHeight: 45, 
                bgColor: Colors.red, 
                borderRadius: 10, 
                textStyle: AppStyles.normalWhiteTextStyle, 
                onClick: ()=> delete(value, context)),
              const SizedBox(height: 10,),
            ],
          ),)),),
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
      
      final res = await ApiRepository().deleteReport(id: widget.report.id);

      if(res){
        Fluttertoast.showToast(msg: "Report Deleted successfully");
        provider.notifyAll();
        Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Failed to delete Report");  
      }

    }catch(err){
      Fluttertoast.showToast(msg: "Failed to delete Repory {Error}");
      
    }finally{
      setState(() {
        isDeleting = false;
      });
    }

  }
}