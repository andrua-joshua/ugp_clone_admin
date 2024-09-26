import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/models/station.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/routes.dart';
import 'package:ugp_clone_admin/routes/stations_screen/widgets/stations_screen_widgets.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';
import 'package:ugp_clone_admin/utils/buttons.dart';

class SearchStationsScreen extends StatefulWidget{
  const SearchStationsScreen({super.key});

  @override
  SearchStationsScreenState createState() => SearchStationsScreenState();

}


class SearchStationsScreenState extends State<SearchStationsScreen>{


  late final TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();
  }


  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.softWhiteColor,
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon(
            Icons.arrow_back,color: Colors.white,
          )),
        title: const Text(
          "Stations",
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
                child: FutureBuilder<List<Station>>(
                  future: ApiRepository().getAllStatations(), 
                  builder: (context, snapshot) {
                    
                    if(snapshot.hasData){
                      final data = snapshot.data;

                      return SingleChildScrollView(
                        child: Column(
                          children: [
                            const SizedBox(height: 20,),
                            Container(
                              constraints: const BoxConstraints.expand(height: 50),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5), // Shadow color
                                    spreadRadius: 2, // How much the shadow spreads
                                    blurRadius: 2, // How blurry the shadow is
                                    offset: Offset(0, 3), // X and Y offset of the shadow
                                  ),
                                ],
                              ),

                              padding: const EdgeInsets.all(10),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextFormField(
                                      controller: searchController,
                                      decoration: const InputDecoration(
                                        border: InputBorder.none,
                                        hintText: "Search by name",
                                        hintStyle: AppStyles.smallBlackTextStyle
                                      ),
                                    )),

                                  const SizedBox(width: 15,),
                                  const Icon(
                                    Icons.search, color: Colors.grey,
                                    size: 30,
                                  )
                                ],
                              ),
                            ),

                            const SizedBox(height: 20,),
                            SizedBox(
                              child: Column(
                                children: List.generate(
                                  data!.length, (x)=> UnitStationItem(
                                    station: data[x],)),
                              ),
                            )
                          ],
                        ),
                      );
                    }

                    if(snapshot.hasError){
                      return const Center(child:Text("Failed to load data", style: AppStyles.normalGreyTextStyle,));
                    }
                    
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },)),
              const SizedBox(height: 10,),
              DSolidButton(
                label: "Add Station", 
                btnHeight: 45, 
                bgColor: AppColors.primaryColor, 
                borderRadius: 10, 
                textStyle: AppStyles.normalWhiteTextStyle, 
                onClick: ()=> Navigator.pushNamed(context, RouteGenerator.addStationScreen)),
              const SizedBox(height: 10,)
            ],
          ),
          
          )),),
    );
  }
}