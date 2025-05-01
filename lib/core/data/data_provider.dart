// import 'dart:convert';

import 'package:get/get_connect.dart';
import 'package:admin/models/api_response.dart';
import '../../models/coupon.dart';
import '../../models/my_notification.dart';
import '../../models/order.dart';
import '../../models/poster.dart';
import '../../models/product.dart';
import '../../models/unit.dart';
import '../../models/variant_type.dart';
import '../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import '../../../models/category.dart';
import '../../models/brand.dart';
import '../../models/sub_category.dart';
import '../../models/variant.dart';
import 'package:admin/utility/snack_bar_helper.dart';

class DataProvider extends ChangeNotifier {
  HttpService service = HttpService();

  List<Category> _allCategories = [];
  List<Category> _filteredCategories = [];
  List<Category> get categories => _filteredCategories;

  List<SubCategory> _allSubCategories = [];
  List<SubCategory> _filteredSubCategories = [];
  List<SubCategory> get subCategories => _filteredSubCategories;

  List<Brand> _allBrands = [];
  List<Brand> _filteredBrands = [];
  List<Brand> get brands => _filteredBrands;

  List<VariantType> _allVariantTypes = [];
  List<VariantType> _filteredVariantTypes = [];
  List<VariantType> get variantTypes => _filteredVariantTypes;

  List<Variant> _allVariants = [];
  List<Variant> _filteredVariants = [];
  List<Variant> get variants => _filteredVariants;

  List<Product> _allProducts = [];
  List<Product> _filteredProducts = [];
  List<Product> get products => _filteredProducts;

  List<Coupon> _allCoupons = [];
  List<Coupon> _filteredCoupons = [];
  List<Coupon> get coupons => _filteredCoupons;

  List<Poster> _allPosters = [];
  List<Poster> _filteredPosters = [];
  List<Poster> get posters => _filteredPosters;

  List<Order> _allOrders = [];
  List<Order> _filteredOrders = [];
  List<Order> get orders => _filteredOrders;

  List<Unit> _allUnits = [];
  List<Unit> _filteredUnits = [];
  List<Unit> get units => _filteredUnits;

  List<MyNotification> _allNotifications = [];
  List<MyNotification> _filteredNotifications = [];
  List<MyNotification> get notifications => _filteredNotifications;

  DataProvider(){
    getAllCategory();
    getAllSubCategory();
    getAllBrands();
    getAllVariant();
    getAllVariantType();
  }

  //================== Categories ==================//
  getAllUnits() async {
    await _fetchList<Unit>("units", (data) {
      _allUnits = data;
      _filteredUnits = List.from(_allUnits);
    });
  }

  filterUnits(String keyword) async {
    if(keyword.isEmpty){
      _filteredUnits = List.from(_allUnits);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredUnits = _allUnits.where((ele) {
        return ele.name.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }
  //================== Categories ==================//
  getAllCategory() async {
    await _fetchList<Category>("categories", (data) {
      _allCategories = data;
      _filteredCategories = List.from(_allCategories);
    });
  }

  filterCategories(String keyword) async {
    if(keyword.isEmpty){
      _filteredCategories = List.from(_allCategories);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredCategories = _allCategories.where((categ) {
        return (categ.name ?? "").toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== SubCategories ==================//
  getAllSubCategory() async {
    await _fetchList<SubCategory>("subCategories", (data) {
      _allSubCategories = data;
      _filteredSubCategories = List.from(_allSubCategories);
    });
  }

  filterSubCategories(String keyword) async {
    if(keyword.isEmpty){
      _filteredSubCategories = List.from(_allSubCategories);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredSubCategories = _allSubCategories.where((ele) {
        return (ele.name).toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Brands ==================//
  getAllBrands() async {
    await _fetchList<Brand>("brands", (data) {
      _allBrands = data;
      _filteredBrands = List.from(_allBrands);
    });
  }

  filterBrands(String keyword) async {
    if(keyword.isEmpty){
      _filteredBrands = List.from(_allBrands);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((ele) {
        return (ele.name)!.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Variant Types ==================//
  getAllVariantType() async {
    await _fetchList<VariantType>("variantTypes", (data) {
      _allVariantTypes = data;
      _filteredVariantTypes = List.from(_allVariantTypes);
    });
  }

  filterVariantTypes(String keyword) async {
    if(keyword.isEmpty){
      _filteredVariants = List.from(_allVariants);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredVariants = _allVariants.where((ele) {
        return (ele.name)!.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Variants ==================//
  getAllVariant() async {
    await _fetchList<Variant>("variants", (data) {
      _allVariants = data;
      _filteredVariants = List.from(_allVariants);
    });
  }

  filterVariants(String keyword) async {
    if(keyword.isEmpty){
      _filteredVariants = List.from(_allVariants);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredVariants = _allVariants.where((ele) {
        return (ele.name)!.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Products ==================//
  getAllProduct() async {
    await _fetchList<Product>("products", (data) {
      _allProducts = data;
      _filteredProducts = List.from(_allProducts);
    });
  }

  filterProducts(String keyword) async {
    if(keyword.isEmpty){
      _filteredProducts = List.from(_allProducts);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredProducts = _allProducts.where((ele) {
        return (ele.name)!.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Coupons ==================//
  getAllCoupons() async {
    await _fetchList<Coupon>("coupons", (data) {
      _allCoupons = data;
      _filteredCoupons = List.from(_allCoupons);
    });
  }

  // filterCoupons(String keyword) async {
  //   if(keyword.isEmpty){
  //     _filteredCoupons = List.from(_allCoupons);
  //   }else{
  //      final lowerKeyword = keyword.toLowerCase();
  //     _filteredCoupons = _allCoupons.where((ele) {
  //       return (ele.name)!.toLowerCase().contains(lowerKeyword);
  //     }).toList();
  //   }
  //   notifyListeners();
  // }

  //================== Posters ==================//
  getAllPosters() async {
    await _fetchList<Poster>("posters", (data) {
      _allPosters = data;
      _filteredPosters = List.from(_allPosters);
    });
  }

  filterPosters(String keyword) async {
     if(keyword.isEmpty){
      _filteredBrands = List.from(_allBrands);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((ele) {
        return (ele.name)!.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Notifications ==================//
  getAllNotifications() async {
    await _fetchList<MyNotification>("notifications", (data) {
      _allNotifications = data;
      _filteredNotifications = List.from(_allNotifications);
    });
  }

  filterNotifications(String keyword) async {
    if(keyword.isEmpty){
      _filteredBrands = List.from(_allBrands);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((ele) {
        return (ele.name)!.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Orders ==================//
  getAllOrders() async {
    await _fetchList<Order>("orders", (data) {
      _allOrders = data;
      _filteredOrders = List.from(_allOrders);
    });
  }

  filterOrders(String keyword) async {
    if(keyword.isEmpty){
      _filteredBrands = List.from(_allBrands);
    }else{
       final lowerKeyword = keyword.toLowerCase();
      _filteredBrands = _allBrands.where((ele) {
        return (ele.name)!.toLowerCase().contains(lowerKeyword);
      }).toList();
    }
    notifyListeners();
  }

  //================== Utility Methods ==================//

  Future<void> _fetchList<T>(String endpoint, Function(List<T>) onSuccess) async {
    try {
      Response response = await service.getItems(endpointUrl: endpoint);

      if (response.isOk) {
        ApiResponse<List<T>> apiResponse = ApiResponse<List<T>>.fromJson(
          response.body,
          (json) => 
          (json as List).
          map((item) =>
           _fromJson<T>(item)).toList(),
        );

        if (apiResponse.success == true) {
          onSuccess(apiResponse.data ?? []);
          notifyListeners();
        } else {
          SnackBarHelper.showErrorSnackBar('Failed to fetch $endpoint: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
      }
    } catch (e) {
      SnackBarHelper.showErrorSnackBar('Error Occurred: $e');
      rethrow;
    }
  }

  T _fromJson<T>(dynamic json) {
    if (T == Category) return Category.fromJson(json) as T;
    if (T == Unit) return Unit.fromJson(json) as T;
    if (T == SubCategory) return SubCategory.fromJson(json) as T;
    if (T == Brand) return Brand.fromJson(json) as T;
    if (T == VariantType) return VariantType.fromJson(json) as T;
    if (T == Variant) return Variant.fromJson(json) as T;
    if (T == Product) return Product.fromJson(json) as T;
    if (T == Coupon) return Coupon.fromJson(json) as T;
    if (T == Poster) return Poster.fromJson(json) as T;
    if (T == Order) return Order.fromJson(json) as T;
    if (T == MyNotification) return MyNotification.fromJson(json) as T;
    throw Exception("Unknown class for parsing: $T");
  }

  //================== Additional Calculations ==================//

//   calculateOrdersWithStatus(String status) {
//     return _allOrders.where((order) => order.status == status).length;
//   }

//   filterProductsByQuantity(int quantityThreshold) {
//     _filteredProducts = _allProducts.where((product) => product.quantity <= quantityThreshold).toList();
//     notifyListeners();
//   }

//   calculateProductWithQuantity(int quantityThreshold) {
//     return _allProducts.where((product) => product.quantity <= quantityThreshold).length;
//   }
}
