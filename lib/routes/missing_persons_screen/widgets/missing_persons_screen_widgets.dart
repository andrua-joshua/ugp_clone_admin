import 'package:flutter/material.dart';
import 'package:ugp_clone_admin/models/missing_person.dart';
import 'package:ugp_clone_admin/routes.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';

class UnitMissingPersonItem extends StatelessWidget{
  final MissingPerson person;

  const UnitMissingPersonItem({
    super.key,
    required this.person
  });


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> Navigator.pushNamed(context, RouteGenerator.unitMissingPersonScreen, arguments:  person),
      child:Container(
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5), // Shadow color
            spreadRadius: 2, // How much the shadow spreads
            blurRadius: 2, // How blurry the shadow is
            offset: const Offset(0, 3), // X and Y offset of the shadow
          ),
        ],
        borderRadius: BorderRadius.circular(6)
      ),

      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Container(
            decoration: BoxDecoration(
              color: const Color.fromARGB(255, 202, 202, 202),
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(person.imgUrl))
            ),
            height: 90,
            width: 90,
          ),
          const SizedBox(width: 10,),
          Expanded(
            child:Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  person.name,
                  style: AppStyles.normalBlackTextStyle,
                ),
                const SizedBox(height: 5,),
                Text(
                  "Status: ${person.status}",
                  style: AppStyles.smallGreyTextStyle,
                ),

                Text(
                  "Date Found: ${person.dateReported}",
                  style: AppStyles.smallGreyTextStyle,
                ),
                
              ],
            ) )
        ],
      ),
    ));
  }
}