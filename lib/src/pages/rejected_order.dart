import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class RejectedOrder extends StatefulWidget {
  //final GlobalKey<ScaffoldState> parentScaffoldKey;

  int statusCode;
  RejectedOrder({Key key}) : super(key: key);

  @override
  _RejectedOrderState createState() => _RejectedOrderState();
}

class _RejectedOrderState extends StateMVC<RejectedOrder> {
  OrderController _con;

  _RejectedOrderState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrders();
    _con.listenForStatistics();
    _con.listenForOrderStatus(insertAll: true);
    _con.selectedStatuses = ['0'];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _con.scaffoldKey,
      appBar: AppBar(
        iconTheme: IconThemeData(
          color: Colors.white, //change your color here
        ),
        title: Text(
          "Rejected Order",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
        actions: <Widget>[
          new ShoppingCartButtonWidget(iconColor: Colors.white, labelColor: Theme.of(context).accentColor),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: _con.refreshOrders,
        child: ListView(
          children: [
            //StatisticsCarouselWidget(statisticsList: _con.statistics),
            Stack(
              children: [
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
                          status_code: 1,
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
