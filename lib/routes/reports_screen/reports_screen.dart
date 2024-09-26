import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ugp_clone_admin/models/report.dart';
import 'package:ugp_clone_admin/providers/changes_provider.dart';
import 'package:ugp_clone_admin/repository/api_repository.dart';
import 'package:ugp_clone_admin/routes/reports_screen/widgets/reports_screen_widget.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';

class ReportsScreen extends StatefulWidget{
  const ReportsScreen({super.key});


  @override
  ReportsScreenState createState() => ReportsScreenState();
}



class ReportsScreenState extends State<ReportsScreen>{

  final TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.primaryColor,
        leading: IconButton(
          onPressed: ()=> Navigator.pop(context), 
          icon: const Icon(Icons.arrow_back, color: Colors.white,)),
        title: const Text(
          "Reports", style: AppStyles.normalWhiteTextStyle,),
      ),
      backgroundColor: AppColors.softWhiteColor,
      body: Consumer<ChangesProvider>(
        builder: (context, value, child)
          => SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 15
          ),
          child: FutureBuilder<List<Report>>(
            future: ApiRepository().getAllReports(), 
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
                                    hintText: "Search ",
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
                              data!.length, (x)=> UnitReportWidget(
                                report:  data[x])),
                          ),
                        )

                    ],
                  ),
                );
              }

              if(snapshot.hasError){
                return const Center(
                  child:Text(
                  "Failed to fetch data",
                  style: AppStyles.normalGreyTextStyle,
                ));
              }

              return const Center(
                child: CircularProgressIndicator(),
              );
            },),) )
      ),
    );
  }
}