import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/category.dart';
import '../../../models/sub_category.dart';
import '../../../services/http_services.dart';


class SubCategoryProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addSubCategoryFormKey = GlobalKey<FormState>();
  TextEditingController subCategoryNameCtrl = TextEditingController();
  Category? selectedCategory;
  SubCategory? subCategoryForUpdate;




  SubCategoryProvider(this._dataProvider);


  // addSubCategory() async {
  //   try{

  //     Map<String,dynamic> formDataMap = {
  //       'name':subCategoryNameCtrl.text,
  //       "img":
  //     };
  //     final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
  //     final response = await service.addItem(endpointUrl: "categories", itemData: form);

  //     if(response.isOk){
  //       ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
  //       if(apiResponse.success==true){
  //         clearFields();
  //         _dataProvider.getAllCategory();
  //         SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
  //         log("category added");
  //       }else{
  //         SnackBarHelper.showErrorSnackBar('Failed to add category: ${apiResponse.message}');
  //       }
  //     }else{
  //       SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
  //     }
  //   }catch(e){
  //     print(e);
  //     SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
  //     rethrow;
  //   }

  // }
  
  // updateCategory() async {
  //   try{
  //     if(categoryForUpdate?.image ==null){
  //       SnackBarHelper.showErrorSnackBar("Please choose Image");
  //       return;
  //     }
  //     Map<String,dynamic> formDataMap = {
  //       'name':categoryNameCtrl.text,
  //       "image":categoryForUpdate?.image ?? "",
  //     };
  //     final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
  //     final response = await service.updateItem(endpointUrl: "categories", itemData: form, itemId: categoryForUpdate?.sId ?? "");

  //     if(response.isOk){
  //       ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
  //       if(apiResponse.success==true){
  //         clearFields();
  //         _dataProvider.getAllCategory();
  //         SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
  //         log("category Updated");

  //       }
  //     return;
  //     }
  //       SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
  //   }catch(e){
  //     print(e);
  //     SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
  //     rethrow;
  //   }
  // }

  // deleteCategory(Category categ) async{
  //    try{

  //     final response = await service.deleteItem(endpointUrl: "categories", itemId: categ.sId ?? "");

  //     if(response.isOk){
  //       ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
  //       if(apiResponse.success==true){
  //         clearFields();
  //         SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
  //         log("category deleted");
  //         _dataProvider.getAllCategory();
  //       }
  //     return;
  //     }
  //       SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
  //   }catch(e){
  //     print(e);
  //     SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
  //     rethrow;
  //   }
  // }



  // //TODO: should complete submitSubCategory


  setDataForUpdateCategory(SubCategory? subCategory) {
    if (subCategory != null) {
      subCategoryForUpdate = subCategory;
      subCategoryNameCtrl.text = subCategory.name ?? '';
      selectedCategory = _dataProvider.categories.firstWhereOrNull((element) => element.sId == subCategory.categoryId?.sId);
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
