import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/models/station.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/routes.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';

class UnitStationItem extends StatefulWidget{
  final Station station;

  const UnitStationItem({
    super.key,
    required this.station
  });


  @override
  UnitStationItemState createState() => UnitStationItemState();

}

class UnitStationItemState extends State<UnitStationItem>{

  bool isDeleting = false;

  @override
  Widget build(BuildContext context) {
    return Consumer<ChangesProvider>(
      builder: (context, value, child)
       => GestureDetector(
      onTap: ()=> Navigator.pushNamed(
        context, 
        RouteGenerator.googleMapsScreen,
        arguments: Marker(
            markerId: MarkerId("${widget.station.id}"), 
            infoWindow: InfoWindow(title: widget.station.name, snippet: widget.station.details),
            position: LatLng(widget.station.latitude, widget.station.longitude))
        ),
      child:Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 2, // How blurry the shadow is
            offset: Offset(0, 3), // X and Y offset of the shadow
          ),
        ],
        borderRadius: BorderRadius.circular(6)
      ),

      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Expanded(
            child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.station.name,
              style: AppStyles.normalBlackTextStyle,
            ),
            const SizedBox(height: 5,),
            Text(
              "Details: ${widget.station.details}",
              style: AppStyles.smallGreyTextStyle,
            ),

            Text(
              "CID: ${widget.station.cid}",
              style: AppStyles.smallGreyTextStyle,
            ),

            Text(
              "Counter Phone: ${widget.station.counter}",
              style: AppStyles.smallGreyTextStyle,
            ),

            Text(
              "Traffic: ${widget.station.traffic}",
              style: AppStyles.smallGreyTextStyle,
            ),

            
          ],
        )),
      const SizedBox(width: 10,),
      isDeleting?
              const Center(
                child: SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(),
                ),
              )
        : DSolidButton(
        label: "  Remove  ", 
        btnHeight: 42, 
        bgColor: Colors.red, 
        borderRadius: 10, 
        textStyle: AppStyles.normalWhiteTextStyle, 
        onClick: ()=> delete(value, context)),

      const SizedBox(width: 10,)
        ],
      ) 
        
    ),));
  }


  Future<void> delete(ChangesProvider provider, BuildContext context)async{
    setState(() {
      isDeleting = true;
    });
    try{
      
      final res = await ApiRepository().deleteStation(id: widget.station.id);

      if(res){
        Fluttertoast.showToast(msg: "Deleted station successfully");
        provider.notifyAll();
        // Navigator.pop(context);
      }else{
        Fluttertoast.showToast(msg: "Failed to delete station");  
      }

    }catch(err){
      Fluttertoast.showToast(msg: "Failed to delete Station {Error}");
      
    }finally{
      setState(() {
        isDeleting = false;
      });
    }
}
}