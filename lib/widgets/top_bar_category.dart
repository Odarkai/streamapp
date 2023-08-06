import 'package:flutter/material.dart';
import 'package:stream_app/constants/colors.dart';

class Categories extends StatefulWidget {
  const Categories({super.key});

  @override
  State<Categories> createState() => _CategoriesState();

}

class _CategoriesState extends State<Categories> {

  List<String> categoryList =[
    "All",
    "Comedy",
    "Drama",
    "Kids",
    "History",
  ];
  double appPadding = 30.0;

  int selectedCategoryIndex = 0;

  Widget _buildCategory(BuildContext context, int index) {

    Size size = MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          selectedCategoryIndex = index;
        });
      },
      child: Padding(padding: EdgeInsets.only(right: appPadding / 3),
        child: Container(
          padding: EdgeInsets.symmetric(horizontal: appPadding / 2),
          width: size.width * 0.25,
          decoration: BoxDecoration(
            color: selectedCategoryIndex == index ? GlobalVariables.cinemaColor : Colors.black.withOpacity(0.1),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Center(
            child: Text(
              categoryList[index], style: TextStyle(
              fontWeight: FontWeight.bold,
              color: selectedCategoryIndex == index ? Colors.white : Colors.white,
            ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    Size size = MediaQuery.of(context).size;

    return Padding(
      padding:  EdgeInsets.only(
        left: appPadding,
        top: appPadding / 2,
        bottom: appPadding,
      ),
      child: SizedBox(
        height: size.height * 0.05,
        child: ListView.builder(
          physics: const BouncingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          itemCount: categoryList.length,
          itemBuilder: (context, index){
            return _buildCategory(context, index);
          },
        ),
      ),
    );
  }
}