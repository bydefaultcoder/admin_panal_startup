import 'package:admin/screens/units/provider/unit_provider.dart';
import 'package:admin/widgets/custom_dropdown.dart';
import 'package:provider/provider.dart';

import '../../../models/unit.dart';
import 'package:admin/utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../../utility/constants.dart';
import '../../../widgets/custom_text_field.dart';

class UnitSubmitForm extends StatelessWidget {
  final Unit? unit;

  const UnitSubmitForm({super.key, this.unit});

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    // context.
    context.unitProvider.setDataForUpdateUnit(unit);
    return SingleChildScrollView(
      child: Form(
        key: context.unitProvider.addUnitFormKey,
        child: Container(
          padding: EdgeInsets.all(defaultPadding),
          width: size.width * 0.3,
          decoration: BoxDecoration(
            color: bgColor,
            borderRadius: BorderRadius.circular(12.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Gap(defaultPadding),
              CustomTextField(
                controller: context.unitProvider.unitNameCtrl,
                labelText: 'Unit Name',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a Unit name';
                  }
                  return null;
                },
              ),
              Consumer<UnitProvider>(
                builder: (BuildContext context, UnitProvider unitProvider, Widget? child) {
                  return CustomDropdown(
                          key: ValueKey(unitProvider.selectedTypeOFUnit),
                          initialValue: unitProvider.selectedTypeOFUnit,
                          items: ['weight', 'volume', 'count'],
                          displayItem: (String unitType) =>  unitType,
                          onChanged: (newValue) {
                            if (newValue != null) {
                              unitProvider.selectedTypeOFUnit = newValue;
                              unitProvider.filterUnitByType(newValue);
                              unitProvider.updateUi();
                            }
                          },
                          hintText: 'Select Unit type',
                        );
                  },

              ),
              Consumer<UnitProvider>(
                builder: (BuildContext context, UnitProvider unitProvider, Widget? child) {
                  return CustomDropdown(
                          key: ValueKey(unitProvider.selectedBaseUnit?.sId),
                          initialValue: unitProvider.selectedBaseUnit,
                          items: unitProvider.unitsBaseByUnitType,
                          displayItem: (Unit? unit) =>  unit?.name?? "",
                          onChanged: (newValue) {
                            if (newValue != null) {
                              // dashProvider.filterVariant(newValue);\
                              // change baseUnit
                            }
                          },
                          hintText: 'Select Unit Base',
                        );
                  },

              ),
              CustomTextField(
                controller: context.unitProvider.unitIntoBaseCtrl,
                labelText: 'Multiple Of Base',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a multiple of base';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.unitProvider.unitSymbolCtrl,
                labelText: 'Symbol',
                onSave: (val) {},
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a multiple of base';
                  }
                  return null;
                },
              ),
              CustomTextField(
                controller: context.unitProvider.descriptionCtrl,
                labelText: 'Unit Description',
                lineNumber: 3,
                onSave: (val) {},
              ),
              Gap(defaultPadding * 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: secondaryColor,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the popup
                    },
                    child: Text('Cancel'),
                  ),
                  Gap(defaultPadding),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: primaryColor,
                    ),
                    onPressed: () {
                      // Validate and save the form
                      if (context.unitProvider.addUnitFormKey.currentState!
                          .validate()) {
                        context.unitProvider.addUnitFormKey.currentState!
                            .save();
                        if (unit == null) {
                          context.unitProvider.addUnit();
                        } else {
                          context.unitProvider.updateUnit();
                        }
                        Navigator.of(context).pop();
                      }
                    },
                    child: Text('Submit'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// How to show the category popup
void showAddUnitForm(BuildContext context, Unit? unit) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        backgroundColor: bgColor,
        title: Center(
            child: Text('Add Unit'.toUpperCase(),
                style: TextStyle(color: primaryColor))),
        content: UnitSubmitForm(unit: unit),
      );
    },
  );
}
