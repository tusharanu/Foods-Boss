import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../elements/StatisticsCarouselWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class OrdersWidget extends StatefulWidget {
  final GlobalKey<ScaffoldState> parentScaffoldKey;

  OrdersWidget({Key key, this.parentScaffoldKey}) : super(key: key);

  @override
  _OrdersWidgetState createState() => _OrdersWidgetState();
}

class _OrdersWidgetState extends StateMVC<OrdersWidget>
    with SingleTickerProviderStateMixin {
  OrderController _con;

  _OrdersWidgetState() : super(OrderController()) {
    _con = controller;
  }
  TabController _tabController;
  int _selectedTabIndex = 0;

  List<Widget> list = [
    Tab(text: ""),
    Tab(icon: Icon(Icons.add_shopping_cart)),
  ];

  @override
  void initState() {
    _con.listenForOrders();
    _con.listenForStatistics();
    _con.listenForOrderStatus(insertAll: true);
    _con.selectedStatuses = ['0'];

//Tab Bar Controller
    _tabController = TabController(length: list.length, vsync: this);

    _tabController.addListener(() {
      setState(() {
        _selectedTabIndex = _tabController.index;
      });
      print("Selected Index: " + _tabController.index.toString());
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        // bottom: TabBar(
        //   onTap: (index) {
        //     // Should not used it as it only called when tab options are clicked,
        //     // not when user swapped
        //   },
        //   controller: _tabController,
        //   tabs: list,
        // ),
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        backgroundColor: Colors.green,
        title: Text(
          "Pending Order",
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          new ShoppingCartButtonWidget(
              iconColor: Colors.white,
              labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshOrders,
        child: ListView(
          children: [
            //StatisticsCarouselWidget(statisticsList: _con.statistics),
            Stack(
              children: [
                // _con.orderStatuses.isEmpty
                //     ? SizedBox(height: 90)
                //     : Container(
                //         height: 90,
                //         child: ListView(
                //           primary: false,
                //           shrinkWrap: true,
                //           scrollDirection: Axis.horizontal,
                //           children: List.generate(_con.orderStatuses.length, (index) {
                //             var _status = _con.orderStatuses.elementAt(index);
                //             var _selected = _con.selectedStatuses.contains(_status.id);
                //             return Padding(
                //               padding: const EdgeInsetsDirectional.only(start: 20),
                //               child: RawChip(
                //                 elevation: 0,
                //                 label: Text(_status.status),
                //                 labelStyle: _selected
                //                     ? Theme.of(context).textTheme.bodyText2.merge(TextStyle(color: Theme.of(context).primaryColor))
                //                     : Theme.of(context).textTheme.bodyText2,
                //                 padding: EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                //                 backgroundColor: Theme.of(context).focusColor.withOpacity(0.1),
                //                 selectedColor: Theme.of(context).accentColor,
                //                 selected: _selected,
                //                 //shape: StadiumBorder(side: BorderSide(color: Theme.of(context).focusColor.withOpacity(0.05))),
                //                 showCheckmark: false,
                //                 onSelected: (bool value) {
                //                   setState(() {
                //                     if (_status.id == '0') {
                //                       _con.selectedStatuses = ['0'];
                //                     } else {
                //                       _con.selectedStatuses.removeWhere((element) => element == '0');
                //                     }
                //                     if (value) {
                //                       _con.selectedStatuses.add(_status.id);
                //                     } else {
                //                       _con.selectedStatuses.removeWhere((element) => element == _status.id);
                //                     }
                //                     _con.selectStatus(_con.selectedStatuses);
                //                   });
                //                 },
                //               ),
                //             );
                //           }),
                //         ),
                //       ),
                if (_con.orders.isEmpty)
                  EmptyOrdersWidget()
                else
                  Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: ListView.separated(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      primary: false,
                      itemCount: _con.orders.length,
                      itemBuilder: (context, index) {
                        var _order = _con.orders.elementAt(index);
                        return OrderItemWidget(
                          //expanded: index == 0 ? true : false,
                          order: _order,
                          onCanceled: (e) {
                            _con.doCancelOrder(_order);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return SizedBox(height: 20);
                      },
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
