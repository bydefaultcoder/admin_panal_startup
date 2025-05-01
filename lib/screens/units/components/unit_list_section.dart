import 'package:admin/utility/extensions.dart';

import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import '../../../models/unit.dart';
// import 'add_category_form.dart';

class UnitListSection extends StatelessWidget {
  const UnitListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    context.unitProvider;
    return Container(
      padding: EdgeInsets.all(defaultPadding),
      decoration: BoxDecoration(
        color: secondaryColor,
        borderRadius: const BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "All Units",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          SizedBox(
            width: double.infinity,
            child: Consumer<DataProvider>(
              builder: (context, dataProvider, child) {
                return DataTable(
                  columnSpacing: defaultPadding,
                  // minWidth: 600,
                  columns: [
                    DataColumn(
                      label: Text("Name"),
                    ),
                    DataColumn(
                      label: Text("Multiple"),
                    ),
                    DataColumn(
                      label: Text("Base"),
                    ),
                    DataColumn(
                      label: Text("Type"),
                    ),
                    DataColumn(
                      label: Text("Added Date"),
                    ),
                    DataColumn(
                      label: Text("Edit"),
                    ),
                    DataColumn(
                      label: Text("Delete"),
                    ),
                  ],
                  rows: List.generate(
                    dataProvider.units.length,
                    (index) => unitDataRow(dataProvider.units[index],
                        delete: () {
                          // context.categoryProvider
                          // context.unitProvider.de(dataProvider.categories[index]);
                    }, edit: () {
                      // showAddCategoryForm(
                      //     context, dataProvider.categories[index]);
                    }),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

DataRow unitDataRow(Unit CatInfo, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(Text(CatInfo.name +"("+ (CatInfo.symbol ?? '')+")")),
      DataCell(Text(CatInfo.intoBase.toString())),
      DataCell(Text(CatInfo.baseUnit ?? 'BASE')),
      DataCell(Text(CatInfo.type ?? '')),
      DataCell(Text(CatInfo.createdAt ?? '')),
      DataCell(IconButton(
          onPressed: () {
            if (edit != null) edit();
          },
          icon: Icon(
            Icons.edit,
            color: Colors.white,
          ))),
      DataCell(IconButton(
          onPressed: () {
            if (delete != null) delete();
          },
          icon: Icon(
            Icons.delete,
            color: Colors.red,
          ))),
    ],
  );
}
  // String? sId;
  // String? name;
  // int? intoBase;
  // String? baseUnit;
  // String? type;
  // String? symbol;
  // bool? isActive;
  // String? description;
  // String? createdAt;
  // String? updatedAt;
  // int? iV;