import '../brands/components/brand_header.dart';
import 'provider/main_screen_provider.dart';
import '../../utility/extensions.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'components/side_menu.dart';

class MainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.dataProvider;
    return Consumer<MainScreenProvider>(builder: (context, provider, child) {  //MainScreenProvider instance to => provider
      return Scaffold(
        appBar: AppBar(
          actions: [ ProfileCard()],
          title: Text(
            provider.HeaderText,
            style: Theme.of(context).textTheme.titleLarge,
          ),
          leading: Builder(
            builder: (context) {
              return IconButton(
                icon: const Icon(Icons.menu),
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              );
            },
          ),
        ),
        drawer: SideMenu(),
        body: SafeArea(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                flex: 5,
                child: provider.selectedScreen,
              )
              // },
              // ),
            ],
          ),
        ),
      );
    });
  }
}
