import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({Key? key, required this.title, required this.svgSrc, required this.tap, required this.trailing}) : super(key: key);

  final String svgSrc;
  final VoidCallback tap;
  final Widget? trailing;
  final Widget title;


  @override
  Widget build(BuildContext context) {

    return Container(

      child: ListTile(

        onTap: tap,
        horizontalTitleGap: 0.0,
        leading: SvgPicture.asset(svgSrc,color: grey,height: 20,),
        title: title,
        trailing: trailing,
      ),
    );
  }
}
