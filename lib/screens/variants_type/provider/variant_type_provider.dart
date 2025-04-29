import 'package:flutter/cupertino.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/variant_type.dart';
import '../../../services/http_services.dart';

import 'dart:developer';
import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';
class VariantsTypeProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;

  final addVariantsTypeFormKey = GlobalKey<FormState>();
  TextEditingController variantNameCtrl = TextEditingController();
  TextEditingController variantTypeCtrl = TextEditingController();

  VariantType? variantTypeForUpdate;

  VariantsTypeProvider(this._dataProvider);

  void addVariantType() async{
    try{

      Map<String,dynamic> data = {
        'name':variantNameCtrl.text,
        "type":variantTypeCtrl.text
      };
  //     final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.addItem(endpointUrl: "variantTypes", itemData: data);

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          _dataProvider.getAllCategory();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("Varient type added");
        }else{
          SnackBarHelper.showErrorSnackBar('Failed to add Varient type: ${apiResponse.message}');
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

  void updateVariantType() async{
      try{
      if(variantTypeForUpdate?.type ==null || variantTypeForUpdate?.name ==null ){
        SnackBarHelper.showErrorSnackBar("Please fill all fields.");
        return;
      }
      Map<String,dynamic> data = {
        'name':variantNameCtrl.text,
        "type":variantTypeCtrl.text
      };
      // final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.updateItem(endpointUrl: "variantTypes", itemData: data, itemId: variantTypeForUpdate?.sId ?? "");

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          _dataProvider.getAllCategory();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("VariantType Updated");
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

  void submitVariantType(){
    if(variantTypeForUpdate==null){
       addVariantType();
    }else{
       updateVariantType();
    }
  }

  void deleteVariantType(VariantType varantType) async{
    try{

      final response = await service.deleteItem(endpointUrl: "variantTypes", itemId: varantType.sId ?? "");

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("VarantType deleted");
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


  setDataForUpdateVariantTYpe(VariantType? variantType) {
    if (variantType != null) {
      variantTypeForUpdate = variantType;
      variantNameCtrl.text = variantType.name ?? '';
      variantTypeCtrl.text = variantType.type ?? '';
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantNameCtrl.clear();
    variantTypeCtrl.clear();
    variantTypeForUpdate = null;
  }
}
