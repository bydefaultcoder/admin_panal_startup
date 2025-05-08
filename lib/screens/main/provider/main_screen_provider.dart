import '../../brands/brand_screen.dart';
import '../../category/category_screen.dart';
import '../../coupon_code/coupon_code_screen.dart';
import '../../dashboard/dashboard_screen.dart';
import '../../notification/notification_screen.dart';
import '../../order/order_screen.dart';
import '../../posters/poster_screen.dart';
import '../../variants/variants_screen.dart';
import '../../units/unit_screen.dart';
import '../../variants_type/variants_type_screen.dart';
import '../../warehouse/warehouse_screen.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../sub_category/sub_category_screen.dart';

class MainScreenProvider extends ChangeNotifier{
  late Widget selectedScreen = DashboardScreen();
  late String HeaderText = "Dashboard";

  navigateToScreen(String screenName) {
    switch (screenName) {
      case 'Dashboard':
        HeaderText = "Dashboard";
        selectedScreen = DashboardScreen();
        break; // Break statement needed here
      case 'Category':
        HeaderText = "Category";
        selectedScreen = CategoryScreen();
        break;
      case 'SubCategory':
        HeaderText = "SubCategory";
        selectedScreen = SubCategoryScreen();
        break;
      case 'Brands':
        HeaderText = "Brands";
        selectedScreen = BrandScreen();
        break;
      case 'VariantType':
        HeaderText = "VariantType";
        selectedScreen = VariantsTypeScreen();
        break;
      case 'Variants':
        HeaderText = "Variants";
        selectedScreen = VariantsScreen();
        break;
      case 'Coupon':
        HeaderText = "Coupon";
        selectedScreen = CouponCodeScreen();
        break;
      case 'Poster':
        HeaderText = "Poster";
        selectedScreen = PosterScreen();
        break;
      case 'Order':
        HeaderText = "Order";
        selectedScreen = OrderScreen();
      case 'Notifications':
        HeaderText = "Notifications";
        selectedScreen = NotificationScreen();
        break;
      case 'Units':
        HeaderText = "Units";
        selectedScreen = UnitScreen();
        break;
      case 'Warehouse':
        HeaderText = "Warehouse";
        selectedScreen = WarehouseScreen();
        break;
      default:
        selectedScreen = DashboardScreen();
    }
    notifyListeners();
  }
  
  
}