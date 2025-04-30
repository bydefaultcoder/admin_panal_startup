import 'package:admin/utility/extensions.dart';

import '../../../core/data/data_provider.dart';
import '../../../models/variant.dart';
import 'add_variant_form.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/color_list.dart';
import '../../../utility/constants.dart';


// class VariantsListSection extends StatelessWidget {
//   const VariantsListSection({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     final isMobile = MediaQuery.of(context).size.width < 600;

//     return Container(
//       padding: EdgeInsets.all(defaultPadding),
//       decoration: BoxDecoration(
//         color: secondaryColor,
//         borderRadius: const BorderRadius.all(Radius.circular(10)),
//       ),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             "All Variants",
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: defaultPadding),
//           Consumer<DataProvider>(
//             builder: (context, dataProvider, child) {
//               if (isMobile) {
//                 // For mobile: Use a ListView of Cards
//                 return Column(
//                   children: dataProvider.variants.map((variant) {
//                     int index = dataProvider.variants.indexOf(variant);
//                     return Card(
//                       margin: const EdgeInsets.only(bottom: defaultPadding),
//                       child: Padding(
//                         padding: const EdgeInsets.all(defaultPadding),
//                         child: Column(
//                           crossAxisAlignment: CrossAxisAlignment.start,
//                           children: [
//                             Row(
//                               children: [
//                                 CircleAvatar(
//                                   backgroundColor: colors[index % colors.length],
//                                   child: Text('${index + 1}'),
//                                   radius: 12,
//                                 ),
//                                 SizedBox(width: 8),
//                                 Expanded(child: Text(variant.name ?? '')),
//                               ],
//                             ),
//                             const SizedBox(height: 8),
//                             Text("Type: ${variant.variantTypeId?.name ?? ''}"),
//                             Text("Date: ${variant.createdAt ?? ''}"),
//                             const SizedBox(height: 8),
//                             Row(
//                               children: [
//                                 IconButton(
//                                   icon: Icon(Icons.edit, color: Colors.white),
//                                   onPressed: () {
//                                     showAddVariantForm(context, variant);
//                                   },
//                                 ),
//                                 IconButton(
//                                   icon: Icon(Icons.delete, color: Colors.red),
//                                   onPressed: () {
//                                     // TODO: call deleteVariant
//                                   },
//                                 ),
//                               ],
//                             )
//                           ],
//                         ),
//                       ),
//                     );
//                   }).toList(),
//                 );
//               } else {
//                 // For tablet/desktop: Use DataTable
//                 return SingleChildScrollView(
//                   scrollDirection: Axis.horizontal,
//                   child: DataTable(
//                     columnSpacing: defaultPadding,
//                     columns: const [
//                       DataColumn(label: Text("Variant")),
//                       DataColumn(label: Text("Variant Type")),
//                       DataColumn(label: Text("Added Date")),
//                       DataColumn(label: Text("Edit")),
//                       DataColumn(label: Text("Delete")),
//                     ],
//                     rows: List.generate(
//                       dataProvider.variants.length,
//                       (index) => variantDataRow(
//                         dataProvider.variants[index],
//                         index + 1,
//                         edit: () {
//                           showAddVariantForm(context, dataProvider.variants[index]);
//                         },
//                         delete: () {
//                           // TODO: call deleteVariant
//                         },
//                       ),
//                     ),
//                   ),
//                 );
//               }
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }



class VariantsListSection extends StatelessWidget {
  const VariantsListSection({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
            "All Variants",
            style: Theme
                .of(context)
                .textTheme
                .titleMedium,
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
                      label: Text("Variant"),
                    ),
                    DataColumn(
                      label: Text("Variant Type"),
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
                    dataProvider.variants.length,
                        (index) =>
                        variantDataRow(dataProvider.variants[index], index + 1, edit: () {
                          print("getting event");
                          showAddVariantForm(context, dataProvider.variants[index]);
                        }, delete: () {
                          context.variantProvider.deleteVariant(dataProvider.variants[index]);
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

DataRow variantDataRow(Variant VariantInfo, int index, {Function? edit, Function? delete}) {
  return DataRow(
    cells: [
      DataCell(
        Row(
          children: [
            Container(
              height: 24,
              width: 24,
              decoration: BoxDecoration(
                color: colors[index % colors.length],
                shape: BoxShape.circle,
              ),
              child: Text(index.toString(), textAlign: TextAlign.center),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: defaultPadding),
              child: Text(VariantInfo.name ?? ''),
            ),
          ],
        ),
      ),
      DataCell(Text(VariantInfo.variantTypeId?.name ?? '')),
      DataCell(Text(VariantInfo.createdAt ?? '')),
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
