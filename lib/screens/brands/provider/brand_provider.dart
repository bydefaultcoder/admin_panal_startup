import 'dart:developer';
import '../../../models/brand.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';

import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';

class BrandProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addBrandFormKey = GlobalKey<FormState>();
  TextEditingController brandNameCtrl = TextEditingController();
  SubCategory? selectedSubCategory;
  Brand? brandForUpdate;




  BrandProvider(this._dataProvider);

  void submitBrand(){
    if(brandForUpdate==null){
       addBrand();
    }else{
       brandForUpdate;
       updateBrand();
    }
  }


  addBrand() async {
    try{

      Map<String,dynamic> data = {
        'name':brandNameCtrl.text,
        "subcategoryId":selectedSubCategory?.sId
      };
  //     final FormData form = await createFormData(imgXFile: imgXFile, formData: subCategory);
      final response = await service.addItem(endpointUrl: "brands", itemData: data);

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          _dataProvider.getAllBrands();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("Brand added");
        }else{
          SnackBarHelper.showErrorSnackBar('Failed to add Brand: ${apiResponse.message}');
        }
      }else{
        SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
      }
    }catch(e){
      print(e);
      SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
      rethrow;
    }

  }
  
  updateBrand() async {
    try{
      if(brandForUpdate?.subcategoryId ==null || brandForUpdate?.name ==null ){
        SnackBarHelper.showErrorSnackBar("Please fill all fields.");
        return;
      }
      Map<String,dynamic> subCategory = {
        'name': brandNameCtrl.text,
        "subcategoryId":selectedSubCategory?.sId ?? "",
      };
      // final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.updateItem(endpointUrl: "brands", itemData: subCategory, itemId: brandForUpdate?.sId ?? "");

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          _dataProvider.getAllBrands();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("Brand Updated");

        }
      return;
      }
        SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
    }catch(e){
      print(e);
      SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
      rethrow;
    }
  }
  
  
  void deleteBrand(Brand brand) async{
     try{

      final response = await service.deleteItem(endpointUrl: "brands", itemId: brand.sId ?? "");

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("Brand deleted");
          _dataProvider.getAllBrands();
        }
      return;
      }
        SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
    }catch(e){
      print(e);
      SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
      rethrow;
    }
  }


  //? set data for update on editing
  setDataForUpdateBrand(Brand? brand) {
    if (brand != null) {
      brandForUpdate = brand;
      brandNameCtrl.text = brand.name ?? '';
      selectedSubCategory = _dataProvider.subCategories.firstWhereOrNull((element) => element.sId == brand.subcategoryId?.sId);
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update brand
  clearFields() {
    brandNameCtrl.clear();
    selectedSubCategory = null;
    brandForUpdate = null;
  }

  updateUI(){
    notifyListeners();
  }



}
