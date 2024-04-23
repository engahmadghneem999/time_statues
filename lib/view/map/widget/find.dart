import 'package:flutter/material.dart';



class Find extends StatelessWidget {
  const Find({super.key, required this.hint, required this.width, required this.height, required this.color, required this.paddingtop, required this.paddingleft, this.ontap});
final String hint;
final double width;
final double height;
final Color color;
final double paddingtop;
final double paddingleft;
final void Function()? ontap;
  @override
  Widget build(BuildContext context) {
    double widtht = MediaQuery.of(context).size.width;
    double heightt = MediaQuery.of(context).size.height;
    return Padding(
      padding: EdgeInsets.only(top: heightt*paddingtop),
      child: Container(
        padding: EdgeInsets.only(left: widtht*paddingleft),
        alignment: Alignment.center,
        width: width,
        height: height,
        decoration: BoxDecoration(color: color,borderRadius: BorderRadius.circular(18)),
        child: TextFormField(
          onTap: ontap,
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: TextStyle(color: Color(0xFFDA6317),fontSize: 14),
              prefixIcon: Icon(Icons.search,color: Color(0xFFDA6317),size: 35,),
              border: InputBorder.none
          ),
        ),
      ),
    );
  }
}
