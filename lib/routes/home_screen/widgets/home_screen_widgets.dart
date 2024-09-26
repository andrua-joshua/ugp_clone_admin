import 'package:flutter/material.dart';
import 'package:ugp_clone_admin/utils/app_colors.dart';
import 'package:ugp_clone_admin/utils/app_styles.dart';

class HomeTopWidget extends StatefulWidget{
  const HomeTopWidget({super.key});


  @override
  HomeScreenWidgetsState createState() => HomeScreenWidgetsState();

}


class HomeScreenWidgetsState extends State<HomeTopWidget>{



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


  String message = "Be vigilant, Be Safe, call 999 for any emergency!";
  String messageHolder = "";


  @override
  Widget build(BuildContext context) {
    // _init();
    return SizedBox(
      height: 280,
      width: double.infinity,
      child: Stack(
        children: [
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              constraints: const BoxConstraints.expand(height: 260),
              decoration: const BoxDecoration(
                color: AppColors.primaryColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(15),
                  bottomRight: Radius.circular(15)
                )
              ),

              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                children: [
                  const SizedBox(height: 15,),
                  SizedBox(
                    child: Row(
                      children: [
                        const Expanded(
                          child: Text(
                            "Hello, John Doe", 
                            style: AppStyles.titleBoldWhiteTextStyle,)),

                        IconButton(
                          onPressed: (){}, 
                          icon: const Icon(
                            Icons.phone_callback_outlined,
                            color: Colors.white,
                            size: 30,
                          ))
                        
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
                  SizedBox(
                    child: Row(
                      children: [
                        Container(
                          height: 50,
                          width: 50,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Colors.white
                          ),
                        ),

                        const SizedBox(width: 10,),
                        Expanded(
                          child:Text(
                          message,
                          style: AppStyles.normalWhiteTextStyle,
                        ))
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),

          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
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
                margin: const EdgeInsets.symmetric(horizontal: 10),
                child: Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: searchController,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          hintText: "Search in app",
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
          )
        ],
      ),
    );
  }


  Future<void> _init()async{
    int len = message.length;
    for(int i =1; i<len; i++){
      await Future.delayed(Duration(microseconds: 3000));
      setState(() {
        messageHolder= message..substring(0,i);
        print(":::>>>>>>>>  $messageHolder");
      });
      
    }
  }
}




class UnitHomeItem extends StatelessWidget{
  final double width;
  final String label;
  final Function() onclick;
  const UnitHomeItem({
    super.key,
    required this.label,
    required this.onclick,
    required this.width});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ()=> onclick(),
      child:Container(
      width: width,
      height: width,
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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 70,
            width: 80,
            color: AppColors.softWhiteColor,
          ),
          const SizedBox(height: 10,),
          Text(
            label,
            style: AppStyles.smallBlackTextStyle,
          )
        ],
      ),
    ));
  }
}