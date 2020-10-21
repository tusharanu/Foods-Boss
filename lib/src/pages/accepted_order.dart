// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/rendering.dart';
// import 'package:food_delivery_owner/src/elements/EmptyOrdersWidget.dart';
// import 'package:food_delivery_owner/src/elements/OrderItemWidget.dart';
// import 'package:mvc_pattern/mvc_pattern.dart';

// import '../controllers/order_controller.dart';
// import '../models/route_argument.dart';

// class AcceptedOrder extends StatefulWidget {
//   final RouteArgument routeArgument;

//   AcceptedOrder({Key key, this.routeArgument}) : super(key: key);

//   @override
//   _AcceptedOrder createState() {
//     return _AcceptedOrder();
//   }
// }

// class _AcceptedOrder extends StateMVC<AcceptedOrder>
//     with SingleTickerProviderStateMixin {
//   //TabController _tabController;
//   //int _tabIndex = 0;
//   OrderController _con;

//   _AcceptedOrder() : super(OrderController()) {
//     _con = controller;
//   }

//   @override
//   void initState() {
//     _con.listenForOrder(id: widget.routeArgument.id);
//     super.initState();
//   }

//   void dispose() {
//     //_tabController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         key: _con.scaffoldKey,
//         appBar: AppBar(
//           backgroundColor: Colors.green,
//           title: Text("Accepted Order", textAlign: TextAlign.center),
//           leading: IconButton(icon: Icon(Icons.arrow_back), onPressed: (){
//                 Navigator.pop(context,true);

//           })

//         ),
//         body: ListView(
//           children: [
//             if (_con.orders.isEmpty)
//                   EmptyOrdersWidget()
//                 else
//                   Padding(
//                     padding: const EdgeInsets.only(top: 10),
//                     child: ListView.separated(
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       primary: false,
//                       itemCount: _con.orders.length,
//                       itemBuilder: (context, index) {
//                         var _order = _con.orders.elementAt(index);
//                         return OrderItemWidget(
//                           //expanded: index == 0 ? true : false,
//                           order: _order,
//                           onCanceled: (e) {
//                             _con.doCancelOrder(_order);
//                           },
//                         );
//                       },
//                       separatorBuilder: (context, index) {
//                         return SizedBox(height: 20);
//                       },
//                     ),
//                   ),
//           ],
//         ),

//         );
//   }
// }
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/EmptyOrdersWidget.dart';
import '../elements/OrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../repository/settings_repository.dart' as settingsRepo;

class AcceptedOrder extends StatefulWidget {
  //final GlobalKey<ScaffoldState> parentScaffoldKey;

  int statusCode;
  AcceptedOrder({Key key}) : super(key: key);

  @override
  _AcceptedOrderState createState() => _AcceptedOrderState();
}

class _AcceptedOrderState extends StateMVC<AcceptedOrder> {
  OrderController _con;

  _AcceptedOrderState() : super(OrderController()) {
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
        title: Text("Accepted Order", style: TextStyle(color: Colors.white)),
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
                          status_code: 0,
                          //btn_text:"Assign Rider",
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
