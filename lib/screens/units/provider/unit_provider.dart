import 'dart:developer';
import 'dart:io';
import 'package:admin/core/data/data_provider.dart';
import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';

import '../../../services/http_services.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart' hide Category;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
// import '../../../core/data/data_provider.dart';
import '../../../models/unit.dart';

class UnitProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final addUnitFormKey = GlobalKey<FormState>();
  TextEditingController unitNameCtrl = TextEditingController();
  Unit? unitForUpdate;
  DataProvider _dataProvider;


  File? selectedImage;
  XFile? imgXFile;


  UnitProvider(this._dataProvider);
      // {required this.name,
      // required this.intoBase,
      // this.baseUnit,
      // required this.type,
      // required this.symbol,
      // this.isActive,
      // this.description,}
  addUnit() async {
    try{

      Map<String,dynamic> formDataMap = {
        'name':unitNameCtrl.text,
        "intoBase":'no_data',
        "baseUnit":'no_data',
        "type":'no_data',
        "symbol":'no_data',
        "description":'no_data',
      };
    //   final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.addItem(endpointUrl: "units", itemData: formDataMap);

      if(response.isOk){
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if(apiResponse.success==true){
          clearFields();
          _dataProvider.getAllUnits();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("unit added");
        }else{
          SnackBarHelper.showErrorSnackBar('Failed to add unit: ${apiResponse.message}');
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
  
  updateUnit() async {
    // try{
    //   if(categoryForUpdate?.image ==null){
    //     SnackBarHelper.showErrorSnackBar("Please choose Image");
    //     return;
    //   }
    //   Map<String,dynamic> formDataMap = {
    //     'name':categoryNameCtrl.text,
    //     "image":categoryForUpdate?.image ?? "",
    //   };
    //   final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
    //   final response = await service.updateItem(endpointUrl: "categories", itemData: form, itemId: categoryForUpdate?.sId ?? "");

    //   if(response.isOk){
    //     ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
    //     if(apiResponse.success==true){
    //       clearFields();
    //       _dataProvider.getAllCategory();
    //       SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
    //       log("category Updated");

    //     }
    //   return;
    //   }
    //     SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
    // }catch(e){
    //   print(e);
    //   SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
    //   rethrow;
    // }
  }

  deleteCategory(Unit unit) async{
    //  try{

    //   final response = await service.deleteItem(endpointUrl: "categories", itemId: categ.sId ?? "");

    //   if(response.isOk){
    //     ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
    //     if(apiResponse.success==true){
    //       clearFields();
    //       SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
    //       log("category deleted");
    //       _dataProvider.getAllCategory();
    //     }
    //   return;
    //   }
    //     SnackBarHelper.showErrorSnackBar('Error ${response.body['message'] ?? response.statusText}');
    // }catch(e){
    //   print(e);
    //   SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
    //   rethrow;
    // }
  }

  //submitCategory


  void pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);
    if (image != null) {
      selectedImage = File(image.path);
      imgXFile = image;
      notifyListeners();
    }
  }



  //not setDataForUpdateCategory


  //? to create form data for sending image with body
  Future<FormData> createFormData({required XFile? imgXFile, required Map<String, dynamic> formData}) async {
    if (imgXFile != null) {
      MultipartFile multipartFile;
      if (kIsWeb) {
        String fileName = imgXFile.name;
        Uint8List byteImg = await imgXFile.readAsBytes();
        multipartFile = MultipartFile(byteImg, filename: fileName);
      } else {
        String fileName = imgXFile.path.split('/').last;
        multipartFile = MultipartFile(imgXFile.path, filename: fileName);
      }
      formData['img'] = multipartFile;
    }
    final FormData form = FormData(formData);
    return form;
  }

  //? set data for update on editing
  setDataForUpdateUnit(Unit? unit) {
    if (unit != null) {
      clearFields();
      unitForUpdate = unit;
      unitNameCtrl.text = unit.name ?? '';
    } else {
      clearFields();
    }
  }

  //? to clear text field and images after adding or update category
  clearFields() {
    unitNameCtrl.clear();
    selectedImage = null;
    imgXFile = null;
    unitForUpdate = null;
  }
}
