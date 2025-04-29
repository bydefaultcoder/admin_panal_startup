import '../../../models/variant_type.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/variant.dart';
import '../../../services/http_services.dart';
import 'dart:developer';
import 'package:admin/models/api_response.dart';
import 'package:admin/utility/snack_bar_helper.dart';

class VariantsProvider extends ChangeNotifier {
  HttpService service = HttpService();
  final DataProvider _dataProvider;
  final addVariantsFormKey = GlobalKey<FormState>();
  TextEditingController variantCtrl = TextEditingController();
  VariantType? selectedVariantType;
  Variant? variantForUpdate;

  VariantsProvider(this._dataProvider);

  void submitSubCategory() {
    if (variantForUpdate == null) {
      addVariant();
    } else {
      updateVariant();
    }
  }

  addVariant() async {
    try {
      Map<String, dynamic> data = {
        'name': variantCtrl.text,
        "variantTypeId": selectedVariantType?.sId
      };
      //     final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response =
          await service.addItem(endpointUrl: "variants", itemData: data);

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          _dataProvider.getAllVariant();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("Varient added");
        } else {
          SnackBarHelper.showErrorSnackBar(
              'Failed to add Variant: ${apiResponse.message}');
        }
      } else {
        SnackBarHelper.showErrorSnackBar(
            'Error ${response.body['message'] ?? response.statusText}');
      }
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
      rethrow;
    }
  }

  updateVariant() async {
    try {
      if (variantForUpdate?.variantTypeId == null ||
          variantForUpdate?.name == null) {
        SnackBarHelper.showErrorSnackBar("Please fill all fields.");
        return;
      }
      Map<String, dynamic> subCategory = {
        'name': variantCtrl.text,
        "variantTypeId": selectedVariantType?.sId ?? "",
      };
      // final FormData form = await createFormData(imgXFile: imgXFile, formData: formDataMap);
      final response = await service.updateItem(
          endpointUrl: "variants",
          itemData: subCategory,
          itemId: variantForUpdate?.sId ?? "");

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          _dataProvider.getAllCategory();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("variant Updated");
        }
        return;
      }
      SnackBarHelper.showErrorSnackBar(
          'Error ${response.body['message'] ?? response.statusText}');
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
      rethrow;
    }
  }

  void deleteVariant(Variant variant) async {
    try {
      final response = await service.deleteItem(
          endpointUrl: "variants", itemId: variant.sId ?? "");

      if (response.isOk) {
        ApiResponse apiResponse = ApiResponse.fromJson(response.body, null);
        if (apiResponse.success == true) {
          clearFields();
          SnackBarHelper.showSuccessSnackBar('${apiResponse.message}');
          log("Variant deleted");
          _dataProvider.getAllBrands();
        }
        return;
      }
      SnackBarHelper.showErrorSnackBar(
          'Error ${response.body['message'] ?? response.statusText}');
    } catch (e) {
      print(e);
      SnackBarHelper.showErrorSnackBar('Error Occurred : $e');
      rethrow;
    }
  }

  setDataForUpdateVariant(Variant? variant) {
    if (variant != null) {
      variantForUpdate = variant;
      variantCtrl.text = variant.name ?? '';
      selectedVariantType = _dataProvider.variantTypes.firstWhereOrNull(
          (element) => element.sId == variant.variantTypeId?.sId);
    } else {
      clearFields();
    }
  }

  clearFields() {
    variantCtrl.clear();
    selectedVariantType = null;
    variantForUpdate = null;
  }

  void updateUI() {
    notifyListeners();
  }
}
