import 'dart:developer';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';

import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';


class SubCategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameCtrl = TextEditingController();
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;




  SubCategoryProvider(this._dataProvider);


  void submitSubCategory(){
    if(subCategoryForUpdate==null){
       addSubCategory();
    }else{
       subCategoryForUpdate;
       updateCategory();
    }

  }


  addSubCategory() async {
    try{

      Map<String,dynamic> subCategory = {
        'name':subCategoryNameCtrl.text,
        "categoryId":selectedCategory?.sId
      };
  //     final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.addItem(endpointUrl: "subCategories", itemData: subCategory);

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          _dataProvider.getAllCategory();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("subCategory added");
        }else{
          SnackBarHelper.showErrorSnackBar('Failed to add Subcategory: ${apiResponse.message}');
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
  
  updateCategory() async {
    try{
      if(subCategoryForUpdate?.categoryId ==null || subCategoryForUpdate?.name ==null ){
        SnackBarHelper.showErrorSnackBar("Please fill all fields.");
        return;
      }
      Map<String,dynamic> subCategory = {
        'name': subCategoryNameCtrl.text,
        "categoryId":selectedCategory?.sId ?? "",
      };
      // final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.updateItem(endpointUrl: "subCategories", itemData: subCategory, itemId: subCategoryForUpdate?.sId ?? "");

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          _dataProvider.getAllCategory();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("category Updated");

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
  
  
  void deleteSubCategory(SubCategory subcateg) async{
     try{

      final response = await service.deleteItem(endpointUrl: "subCategories", itemId: subcateg.sId ?? "");

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("SubCategory deleted");
          _dataProvider.getAllSubCategory();
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





  setDataForUpdateCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameCtrl.text = subCategory.name;
      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == subCategory.categoryId.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    subCategoryNameCtrl.clear();
    selectedCategory = null;
    subCategoryForUpdate = null;
  }

  updateUi(){
    notifyListeners();
  }

}
