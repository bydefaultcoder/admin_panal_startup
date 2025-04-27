import '../../../core/data/data_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../../utility/constants.dart';
import 'chart.dart';
import 'order_info_card.dart';

class OrderDetailsSection extends StatelessWidget {
  const OrderDetailsSection({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size _size = MediaQuery.of(context).size;

    return Consumer<DataProvider>(
      builder: (context, dataProvider, child) {
        // TODO: Replace with real values
        int totalOrder = 0;
        int pendingOrder = 0;
        int processingOrder = 0;
        int cancelledOrder = 0;
        int shippedOrder = 0;
        int deliveredOrder = 0;

        List<OrderInfoCard> orderCards = [
          OrderInfoCard(
            svgSrc: "assets/icons/delivery1.svg",
            title: "All Orders",
            totalOrder: totalOrder,
          ),
          OrderInfoCard(
            svgSrc: "assets/icons/delivery5.svg",
            title: "Pending Orders",
            totalOrder: pendingOrder,
          ),
          OrderInfoCard(
            svgSrc: "assets/icons/delivery6.svg",
            title: "Processed Orders",
            totalOrder: processingOrder,
          ),
          OrderInfoCard(
            svgSrc: "assets/icons/delivery2.svg",
            title: "Cancelled Orders",
            totalOrder: cancelledOrder,
          ),
          OrderInfoCard(
            svgSrc: "assets/icons/delivery4.svg",
            title: "Shipped Orders",
            totalOrder: shippedOrder,
          ),
          OrderInfoCard(
            svgSrc: "assets/icons/delivery3.svg",
            title: "Delivered Orders",
            totalOrder: deliveredOrder,
          ),
        ];

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
                "Orders Details",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(height: defaultPadding),
              Chart(),
              SizedBox(height: defaultPadding),
              Wrap(
                spacing: defaultPadding,
                runSpacing: defaultPadding,
                children: orderCards
                    .map((card) => SizedBox(
                          width: _size.width > 1200
                              ? (_size.width / 5)
                              : _size.width > 800
                                  ? (_size.width / 2.5)
                                  : _size.width,
                          child: card,
                        ))
                    .toList(),
              ),
            ],
          ),
        );
      },
    );
  }
}
