import 'package:flutter/material.dart';
import 'package:ugp_clone_admin/models/report.dart';
import 'package:ugp_clone_admin/routes.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';

class UnitReportWidget extends StatelessWidget{
  final Report report;
  const UnitReportWidget({
    super.key,
    required this.report
    });



  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(
        context, RouteGenerator.reportDetailsScreen, arguments: report),
      child:Container(
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
          
          const SizedBox(width: 10,),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  report.category,
                  style: AppStyles.normalBlackTextStyle,
                ),
                const SizedBox(height: 5,),
                Text(
                  "Details: ${report.details}",
                  style: AppStyles.smallGreyTextStyle,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                
              ],
            ) ),

            const SizedBox(width: 10,),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: AppColors.primaryColor,
              ),
              padding: const EdgeInsets.all(7),
              child: Text(report.type, style: AppStyles.normalWhiteTextStyle,),
            ),
        ],
      ),
    ));;
  }

}

