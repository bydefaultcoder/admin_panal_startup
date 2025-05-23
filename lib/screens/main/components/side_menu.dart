import '../../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';


class SideMenu extends StatelessWidget {
  const SideMenu({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
        return Drawer(
          child: ListView(
            children: [
              DrawerHeader(
            child: Image.asset("assets/images/logo.png"),
              ),
              DrawerListTile(
                title: "Dashboard",
                svgSrc: "assets/icons/menu_dashboard.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Dashboard');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Category",
                svgSrc: "assets/icons/menu_tran.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Category');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Sub Category",
                svgSrc: "assets/icons/menu_task.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('SubCategory');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Brands",
                svgSrc: "assets/icons/menu_doc.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Brands');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Variant Type",
                svgSrc: "assets/icons/menu_store.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('VariantType');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Variants",
                svgSrc: "assets/icons/menu_notification.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Variants');
               Navigator.pop(context);
            },
          ),
          DrawerListTile(
            title: "Units",
            svgSrc: "assets/icons/unit.svg",
            press: () {
              context.mainScreenProvider.navigateToScreen('Units');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Orders",
                svgSrc: "assets/icons/menu_profile.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Order');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Coupons",
                svgSrc: "assets/icons/menu_setting.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Coupon');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Posters",
                svgSrc: "assets/icons/menu_doc.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Poster');
               Navigator.pop(context);
                },
              ),
              DrawerListTile(
                title: "Notifications",
                svgSrc: "assets/icons/menu_notification.svg",
                press: () {
                  context.mainScreenProvider.navigateToScreen('Notifications');
                  Navigator.pop(context);
                },
              ),
              // DrawerListTile(
              //   title: "Warehouse",
              //   svgSrc: "assets/icons/menu_notificationr.svg",
              //   press: () {
              //     context.mainScreenProvider.navigateToScreen('Warehouse');
              //     // if (isMobile) Navigator.pop(context);
              //   },)
            ],
          ),
    );
  }
}

class DrawerListTile extends StatelessWidget {
  const DrawerListTile({
    Key? key,
    // For selecting those three line once press "Command+D"
    required this.title,
    required this.svgSrc,
    required this.press,
  }) : super(key: key);

  final String title, svgSrc;
  final VoidCallback press;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: press,
      horizontalTitleGap: 0.0,
      leading: SvgPicture.asset(
        svgSrc,
        colorFilter: ColorFilter.mode(Colors.white54, BlendMode.srcIn),
        height: 16,
      ),
      title: Text(
        title,
        style: TextStyle(color: Colors.white54),
      ),
    );
  }
}
