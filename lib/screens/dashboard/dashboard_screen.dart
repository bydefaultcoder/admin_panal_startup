import 'components/dash_board_header.dart';
import 'package:flutter/material.dart';
import 'package:gap/gap.dart';
import '../../utility/constants.dart';
import 'components/add_product_form.dart';
import 'components/order_details_section.dart';
import 'components/product_list_section.dart';
import 'components/product_summery_section.dart';

class DashboardScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isMobile = screenWidth < 800;

    return SafeArea(
      child: SingleChildScrollView(
        padding: EdgeInsets.all(defaultPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DashBoardHeader(),
            Gap(defaultPadding),
            // Top Section: My Products Header
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Text(
                    "My Products",
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                ElevatedButton.icon(
                  style: TextButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      horizontal: defaultPadding * 1.5,
                      vertical: defaultPadding,
                    ),
                  ),
                  onPressed: () {
                    showAddProductForm(context, null);
                  },
                  icon: Icon(Icons.add),
                  label: Text("Add New"),
                ),
                Gap(20),
                IconButton(
                  onPressed: () {
                    // TODO: Call getAllProduct
                  },
                  icon: Icon(Icons.refresh),
                ),
              ],
            ),
            Gap(defaultPadding),
            // Main content area
            isMobile
                ? Column(
                    children: [
                      ProductSummerySection(),
                      Gap(defaultPadding),
                      ProductListSection(),
                      Gap(defaultPadding),
                      OrderDetailsSection(),
                    ],
                  )
                : Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 5,
                        child: Column(
                          children: [
                            ProductSummerySection(),
                            Gap(defaultPadding),
                            ProductListSection(),
                          ],
                        ),
                      ),
                      SizedBox(width: defaultPadding),
                      Expanded(
                        flex: 2,
                        child: OrderDetailsSection(),
                      ),
                    ],
                  ),
          ],
        ),
      ),
    );
  }
}
