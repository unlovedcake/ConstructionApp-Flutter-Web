import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:responsive_admin_dashboard/constants/constants.dart';
import 'package:responsive_admin_dashboard/controllers/auth-provider.dart';
import 'package:responsive_admin_dashboard/controllers/controller.dart';
import 'package:responsive_admin_dashboard/screens/components/drawer_list_tile.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../controllers/local-storage.dart';
import '../../router/routes-name.dart';
import '../../widgets/dialog-add-new-customer.dart';

class DrawerMenu extends StatelessWidget {
  DrawerMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    int index = context.watch<Controller>().getIndexContentPage;

    return Drawer(
      child: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(appPadding),
            child: Image.asset("assets/images/logowithtext.png"),
          ),
          DrawerListTile(
              title: Text(
                'Project',
                style: TextStyle(color:index == 0 ? Colors.blue : grey,),
              ),
              svgSrc: 'assets/icons/BlogPost.svg',
              trailing: Icon(
                Icons.arrow_forward_ios,
                size: 12,
              ),
              tap: () {
                context.read<Controller>().setIndexContentPage(0);

              }),
          DrawerListTile(
            title: Text(
              'Customer',
              style: TextStyle(color:index == 1 ? Colors.blue : grey,),
            ),
            svgSrc: 'assets/icons/Dashboard.svg',
            trailing: null,
            tap: () {
              context.read<Controller>().setIndexContentPage(1);

            },
          ),
          DrawerListTile(
              title: Text(
                'Message',
                style: TextStyle(color:  grey,),
              ),
              svgSrc: 'assets/icons/Message.svg',
              trailing: null,
              tap: () {}),
          DrawerListTile(
              title: Text(
                'Statistics',
                style: TextStyle(color: grey),
              ),
              svgSrc: 'assets/icons/Statistics.svg',
              trailing: null,
              tap: () {}),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: appPadding * 2),
            child: Divider(
              color: grey,
              thickness: 0.2,
            ),
          ),
          DrawerListTile(
              title: Text(
                'Seetings',
                style: TextStyle(color: grey),
              ),
              svgSrc: 'assets/icons/Setting.svg',
              trailing: null,
              tap: () {}),
          DrawerListTile(
              title: Text(
                'Logout',
                style: TextStyle(color: grey),
              ),
              svgSrc: 'assets/icons/Logout.svg',
              trailing: null,
              tap: () async{
                SharedPreferences prefs = await SharedPreferences.getInstance();
                //prefs.remove('email');
                //context.read<LocalStorageHelper>().removeValue('isLoggedIn');
                LocalStorageHelper.removeValue('isLoggedIn');
                print("adadadad");
                print( prefs.setString('email',"email"));
                print("adadadadssss");
                AuthProvider.logout(context);

                Navigator.of(context).pushNamed(
                  RoutesName.LOGIN_URL,
                );
              }),
        ],
      ),
    );
  }
}
