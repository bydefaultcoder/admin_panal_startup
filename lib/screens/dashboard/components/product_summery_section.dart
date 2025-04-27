import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../core/data/data_provider.dart';
import '../../../models/product_summery_info.dart';
import '../../../utility/constants.dart';
import 'product_summery_card.dart';

class ProductSummerySection extends StatelessWidget {
  const ProductSummerySection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Consumer<DataProvider>(
      builder: (context, dataProvider, _) {
        int totalProduct = 1;
        // TODO: Complete - fetch product count dynamically
        totalProduct = 0;
        int outOfStockProduct = 0;
        int limitedStockProduct = 0;
        int otherStockProduct = totalProduct - outOfStockProduct - limitedStockProduct;

        List<ProductSummeryInfo> productSummeryItems = [
          ProductSummeryInfo(
            title: "All Product",
            productsCount: totalProduct,
            svgSrc: "assets/icons/Product.svg",
            color: primaryColor,
            percentage: 100,
          ),
          ProductSummeryInfo(
            title: "Out of Stock",
            productsCount: outOfStockProduct,
            svgSrc: "assets/icons/Product2.svg",
            color: Color(0xFFEA3829),
            percentage: totalProduct != 0 ? (outOfStockProduct / totalProduct) * 100 : 0,
          ),
          ProductSummeryInfo(
            title: "Limited Stock",
            productsCount: limitedStockProduct,
            svgSrc: "assets/icons/Product3.svg",
            color: Color(0xFFECBE23),
            percentage: totalProduct != 0 ? (limitedStockProduct / totalProduct) * 100 : 0,
          ),
          ProductSummeryInfo(
            title: "Other Stock",
            productsCount: otherStockProduct,
            svgSrc: "assets/icons/Product4.svg",
            color: Color(0xFF47e228),
            percentage: totalProduct != 0 ? (otherStockProduct / totalProduct) * 100 : 0,
          ),
        ];

        // 🧠 Responsive logic for columns
        int crossAxisCount;
        if (_size.width >= 1200) {
          crossAxisCount = 4;
        } else if (_size.width >= 800) {
          crossAxisCount = 2;
        } else {
          crossAxisCount = 1;
        }

        return GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: productSummeryItems.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: defaultPadding,
            mainAxisSpacing: defaultPadding,
            childAspectRatio: _size.width < 1400 ? 1.1 : 1.4,
          ),
          itemBuilder: (context, index) => ProductSummeryCard(
            info: productSummeryItems[index],
            onTap: (productType) {
              // TODO: Complete - call filterProductsByQuantity
            },
          ),
        );
      },
    );
  }
}
