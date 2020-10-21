import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:food_delivery_owner/src/helpers/dotted_divider.dart';
import 'package:food_delivery_owner/src/pages/accepted_order.dart';
import 'package:food_delivery_owner/src/pages/rejected_order.dart';
import 'package:intl/intl.dart' show DateFormat;
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../generated/l10n.dart';
import '../controllers/order_controller.dart';
import '../elements/CircularLoadingWidget.dart';
import '../elements/DrawerWidget.dart';
import '../elements/FoodOrderItemWidget.dart';
import '../elements/ShoppingCartButtonWidget.dart';
import '../helpers/helper.dart';
import '../models/route_argument.dart';

class OrderWidget extends StatefulWidget {
  final RouteArgument routeArgument;

  OrderWidget({Key key, this.routeArgument}) : super(key: key);

  @override
  _OrderWidgetState createState() {
    return _OrderWidgetState();
  }
}

class _OrderWidgetState extends StateMVC<OrderWidget>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  int _tabIndex = 0;
  OrderController _con;

  _OrderWidgetState() : super(OrderController()) {
    _con = controller;
  }

  @override
  void initState() {
    _con.listenForOrder(id: widget.routeArgument.id);
    _tabController =
        TabController(length: 2, initialIndex: _tabIndex, vsync: this);
    _tabController.addListener(_handleTabSelection);
    super.initState();
  }

  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  _handleTabSelection() {
    if (_tabController.indexIsChanging) {
      setState(() {
        _tabIndex = _tabController.index;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: _con.scaffoldKey,
        appBar: AppBar(
          backgroundColor: Colors.green,
          title: Text(
            "Order Details",
            style: TextStyle(color: Colors.white),
          ),
          leading: IconButton(
              icon: Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () {
                Navigator.pop(context, true);
              }),
          actions: <Widget>[
            new ShoppingCartButtonWidget(
                iconColor: Colors.white,
                labelColor: Theme.of(context).accentColor),
          ],
          // bottomNavigationBar: _con.order == null
          //     ? Container(
          //         // height: 193,
          //         // padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //         // decoration: BoxDecoration(
          //         //     color: Theme.of(context).primaryColor,
          //         //     borderRadius: BorderRadius.only(
          //         //         topRight: Radius.circular(20),
          //         //         topLeft: Radius.circular(20)),
          //         //     boxShadow: [
          //         //       BoxShadow(
          //         //           color: Theme.of(context).focusColor.withOpacity(0.15),
          //         //           offset: Offset(0, -2),
          //         //           blurRadius: 5.0)
          //         //     ]),
          //         // child: SizedBox(
          //         //   width: MediaQuery.of(context).size.width - 40,
          //         // ),
          //       )
          //     : Container(
          //         height: _con.order.orderStatus.id == '5' ? 190 : 240,
          //         padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
          //         decoration: BoxDecoration(
          //             color: Theme.of(context).primaryColor,
          //             borderRadius: BorderRadius.only(
          //                 topRight: Radius.circular(20),
          //                 topLeft: Radius.circular(20)),
          //             boxShadow: [
          //               BoxShadow(
          //                   color: Theme.of(context).focusColor.withOpacity(0.15),
          //                   offset: Offset(0, -2),
          //                   blurRadius: 5.0)
          //             ]),
          //         child: SizedBox(
          //           width: MediaQuery.of(context).size.width - 40,
          //           child: Column(
          //             crossAxisAlignment: CrossAxisAlignment.center,
          //             mainAxisSize: MainAxisSize.max,
          //             children: <Widget>[
          //               Row(
          //                 children: <Widget>[
          //                   Expanded(
          //                     child: Text(
          //                       S.of(context).subtotal,
          //                       style: Theme.of(context).textTheme.bodyText1,
          //                     ),
          //                   ),
          //                   Helper.getPrice(
          //                       Helper.getSubTotalOrdersPrice(_con.order), context,
          //                       style: Theme.of(context).textTheme.subtitle1)
          //                 ],
          //               ),
          //               SizedBox(height: 5),
          //               Row(
          //                 children: <Widget>[
          //                   Expanded(
          //                     child: Text(
          //                       S.of(context).delivery_fee,
          //                       style: Theme.of(context).textTheme.bodyText1,
          //                     ),
          //                   ),
          //                   Helper.getPrice(_con.order.deliveryFee, context,
          //                       style: Theme.of(context).textTheme.subtitle1)
          //                 ],
          //               ),
          //               Row(
          //                 children: <Widget>[
          //                   Expanded(
          //                     child: Text(
          //                       '${S.of(context).tax} (${_con.order.tax}%)',
          //                       style: Theme.of(context).textTheme.bodyText1,
          //                     ),
          //                   ),
          //                   Helper.getPrice(Helper.getTaxOrder(_con.order), context,
          //                       style: Theme.of(context).textTheme.subtitle1)
          //                 ],
          //               ),
          //               Divider(height: 20),
          //               Row(
          //                 children: <Widget>[
          //                   Expanded(
          //                     child: Text(
          //                       S.of(context).total,
          //                       style: Theme.of(context).textTheme.headline6,
          //                     ),
          //                   ),
          //                   Helper.getPrice(
          //                       Helper.getTotalOrdersPrice(_con.order), context,
          //                       style: Theme.of(context).textTheme.headline6)
          //                 ],
          //               ),
          //               _con.order.orderStatus.id != '5'
          //                   ? Divider(height: 25)
          //                   : SizedBox(height: 0),
          //               Container(
          //                 width: MediaQuery.of(context).size.width,
          //                 child: Wrap(
          //                   alignment: WrapAlignment.end,
          //                   children: <Widget>[
          //                     if (_con.order.canEditOrder())
          //                       OutlineButton(
          //                         onPressed: () {
          //                           Navigator.of(context).pushNamed('/OrderEdit',
          //                               arguments:
          //                                   RouteArgument(id: _con.order.id));
          //                         },
          //                         padding: EdgeInsets.symmetric(vertical: 10),
          //                         textColor: Theme.of(context).accentColor,
          //                         disabledTextColor:
          //                             Theme.of(context).focusColor.withOpacity(0.5),
          //                         highlightedBorderColor:
          //                             Theme.of(context).accentColor,
          //                         shape: StadiumBorder(),
          //                         borderSide: BorderSide(
          //                             color: Theme.of(context).accentColor),
          //                         child: Text(
          //                           S.of(context).edit,
          //                         ),
          //                       ),
          //                     SizedBox(width: 10),
          //                     OutlineButton(
          //                       onPressed: !_con.order.canCancelOrder()
          //                           ? null
          //                           : () {
          //                               showDialog(
          //                                 context: context,
          //                                 builder: (BuildContext context) {
          //                                   // return object of type Dialog
          //                                   return AlertDialog(
          //                                     title: Wrap(
          //                                       spacing: 10,
          //                                       children: <Widget>[
          //                                         Icon(Icons.report,
          //                                             color: Colors.orange),
          //                                         Text(
          //                                           S.of(context).confirmation,
          //                                           style: TextStyle(
          //                                               color: Colors.orange),
          //                                         ),
          //                                       ],
          //                                     ),
          //                                     content: Text(S
          //                                         .of(context)
          //                                         .areYouSureYouWantToCancelThisOrderOf),
          //                                     contentPadding: EdgeInsets.symmetric(
          //                                         horizontal: 30, vertical: 25),
          //                                     actions: <Widget>[
          //                                       FlatButton(
          //                                         child: new Text(
          //                                           S.of(context).yes,
          //                                           style: TextStyle(
          //                                               color: Theme.of(context)
          //                                                   .hintColor),
          //                                         ),
          //                                         onPressed: () {
          //                                           _con.doCancelOrder(_con.order);
          //                                           Navigator.of(context).pop();
          //                                         },
          //                                       ),
          //                                       FlatButton(
          //                                         child: new Text(
          //                                           S.of(context).close,
          //                                           style: TextStyle(
          //                                               color: Colors.orange),
          //                                         ),
          //                                         onPressed: () {
          //                                           Navigator.of(context).pop();
          //                                         },
          //                                       ),
          //                                     ],
          //                                   );
          //                                 },
          //                               );
          //                             },
          //                       padding: EdgeInsets.symmetric(vertical: 10),
          //                       textColor: Theme.of(context).accentColor,
          //                       disabledTextColor:
          //                           Theme.of(context).focusColor.withOpacity(0.5),
          //                       highlightedBorderColor:
          //                           Theme.of(context).accentColor,
          //                       shape: StadiumBorder(),
          //                       borderSide: BorderSide(
          //                           color: Theme.of(context).accentColor),
          //                       child: Text(
          //                         S.of(context).cancel,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //               SizedBox(height: 10),
          //             ],
          //           ),
          //         ),
        ),
        body: _con.order == null
            ? CircularLoadingWidget(height: 400)
            : SingleChildScrollView(
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        margin: EdgeInsets.all(5),
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.green),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Wrap(children: [
                          Column(
                            children: [
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      S.of(context).order_id + "-F24224GDJS",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(fontSize: 14),
                                    ),
                                    Text(
                                      "Order Date-" + "Aug 16,2020",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(fontSize: 12),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.only(left: 15, right: 15),
                                alignment: Alignment.centerRight,
                                child: Text(
                                  "Order Time-" + "3:23pm",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 12),
                                ),
                              ),
                              Column(
                                children: [
                                  ListView.builder(
                                      itemCount: _con.order.foodOrders.length,
                                      shrinkWrap: true,
                                      itemBuilder: (BuildContext ctx, index) {
                                        return FoodOrderItemWidget(
                                          heroTag: 'myWidget.orders',
                                          order: _con.order,
                                          foodOrder: _con.order.foodOrders
                                              .elementAt(index),
                                        );
                                      })
                                ],
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 15),
                                padding: EdgeInsets.only(left: 15, right: 15),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Order Summary",
                                      style: Theme.of(context)
                                          .textTheme
                                          .subtitle1
                                          .copyWith(fontSize: 12),
                                    ),
                                    Container(
                                      padding: EdgeInsets.only(bottom: 5),
                                      child: Row(
                                        children: [
                                          Text(
                                            "Time Slot-",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                    fontSize: 11,
                                                    fontWeight:
                                                        FontWeight.bold),
                                          ),
                                          Text(
                                            "01 sep 2020,10:00-11:00",
                                            style: Theme.of(context)
                                                .textTheme
                                                .subtitle1
                                                .copyWith(
                                                    fontSize: 11,
                                                    color: Colors.green),
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ]),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: 20, left: 20, top: 5),
                        alignment: Alignment.center,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Text(
                              "2 Items",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontSize: 11),
                            ),
                            Text(
                              "Amount:Rs 1200",
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  .copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      Divider(
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        child: Column(
                          children: [
                            ListView.builder(
                                itemCount: _con.order.foodOrders.length,
                                shrinkWrap: true,
                                itemBuilder: (BuildContext ctx, index) {
                                  return Container(
                                    child: Column(
                                      children: [
                                        Row(
                                          children: [
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 20, top: 10),
                                              child: CachedNetworkImage(
                                                height: 70,
                                                width: 50,
                                                fit: BoxFit.cover,
                                                imageUrl:
                                                    "https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcSolmPOUqzlDd4hiX9oKSXUvkQvBkHiosC0MQ&usqp=CAU",
                                                placeholder: (context, url) =>
                                                    Image.asset(
                                                  'assets/img/loading.gif',
                                                  fit: BoxFit.cover,
                                                  height: 70,
                                                  width: 50,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              ),
                                            ),
                                            Container(
                                              margin: EdgeInsets.only(
                                                  left: 10, top: 5),
                                              child: Column(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    "Tate Lyle + White Sugar",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                  Text(
                                                    "1 kg",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        .copyWith(
                                                            fontSize: 14,
                                                            color: Colors.grey),
                                                  ),
                                                  Text(
                                                    "Rs 65X2",
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline4
                                                        .copyWith(fontSize: 14),
                                                  ),
                                                ],
                                              ),
                                            )
                                          ],
                                        ),
                                        Divider(
                                          color: Colors.grey,
                                        )
                                      ],
                                    ),
                                  );
                                  // return FoodOrderItemWidget(
                                  //   heroTag: 'myWidget.orders',
                                  //   order: _con.order,
                                  //   foodOrder:
                                  //       _con.order.foodOrders.elementAt(index),
                                  // );
                                })
                          ],
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 2, bottom: 2),
                        child: Text(
                          "Payment Summary",
                          style: Theme.of(context)
                              .textTheme
                              .subtitle1
                              .copyWith(fontSize: 11, color: Colors.grey),
                        ),
                      ),
                      Divider(
                        height: 5,
                        thickness: 1,
                        color: Colors.grey,
                      ),
                      Container(
                        margin: EdgeInsets.all(15),
                        padding: EdgeInsets.only(top: 5),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Sub Total",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 13),
                                ),
                                Text(
                                  "Rs 400",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(fontSize: 13),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Coupan Applied",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                          fontSize: 13, color: Colors.green),
                                ),
                                Text(
                                  "- Rs400",
                                  style: Theme.of(context)
                                      .textTheme
                                      .subtitle1
                                      .copyWith(
                                          fontSize: 13, color: Colors.green),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            const MySeparator(
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "Final Paid Amount",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 13, color: Colors.grey),
                                ),
                                Text(
                                  "Rs 600",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      .copyWith(
                                          fontSize: 13, color: Colors.grey),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              margin: EdgeInsets.only(left: 20),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.location_on,
                                      ),
                                      SizedBox(
                                        width: 5,
                                      ),
                                      Text(
                                        "Delivery Address",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6
                                            .copyWith(
                                                fontSize: 13,
                                                color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: EdgeInsets.only(top: 10, left: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "HOME",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 13,
                                                  color: Colors.green),
                                        ),
                                        Text(
                                          "Gunjan Singh",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6
                                              .copyWith(
                                                  fontSize: 13,
                                                  color: Colors.black),
                                        ),
                                        Text(
                                          "7/34,third floor,front side",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize: 13,
                                              ),
                                        ),
                                        Text(
                                          "Kakariya Lake,Ahemdabad",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(
                                                fontSize: 13,
                                              ),
                                        ),
                                        Text(
                                          "Pin Code- 231223",
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5
                                              .copyWith(fontSize: 13),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Divider(
                              height: 5,
                              thickness: 1,
                              color: Colors.grey,
                            ),
                            SizedBox(
                              height: 15,
                            ),
                            Container(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  new FlatButton(
                                    minWidth: 150,
                                    color: Colors.white,
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.red,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    textColor: Colors.red,
                                    child: const Text("Reject"),
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  RejectedOrder()));
                                    },
                                  ),
                                  SizedBox(
                                    width: 40,
                                  ),
                                  new FlatButton(
                                    color: Colors.green,
                                    minWidth: 150,
                                    padding: const EdgeInsets.all(15),
                                    shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                          color: Colors.green,
                                        ),
                                        borderRadius: BorderRadius.circular(5)),
                                    child: const Text("Accept"),
                                    textColor: Colors.white,
                                    onPressed: () {
                                      Navigator.of(context).push(
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  AcceptedOrder()));
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              )

//           : CustomScrollView(slivers: <Widget>[
//               // SliverAppBar(
//               //   snap: true,
//               //   floating: true,
//               //   automaticallyImplyLeading: false,
//               //   leading: new IconButton(
//               //     icon:
//               //         new Icon(Icons.sort, color: Theme.of(context).hintColor),
//               //     onPressed: () => _con.scaffoldKey?.currentState?.openDrawer(),
//               //   ),
//               //   centerTitle: true,
//               //   title: Text(
//               //     S.of(context).order_details,
//               //     style: Theme.of(context)
//               //         .textTheme
//               //         .headline6
//               //         .merge(TextStyle(letterSpacing: 1.3)),
//               //   ),
//               //   actions: <Widget>[
//               //     new ShoppingCartButtonWidget(
//               //         iconColor: Theme.of(context).hintColor,
//               //         labelColor: Theme.of(context).accentColor),
//               //   ],
//               //   backgroundColor: Theme.of(context).scaffoldBackgroundColor,
//               //   expandedHeight: 238,
//               //   elevation: 0,
//               //   flexibleSpace: FlexibleSpaceBar(
//               //     background: Container(
//               //       margin: EdgeInsets.only(top: 95, bottom: 65),
//               //       padding: EdgeInsets.symmetric(horizontal: 20, vertical: 15),
//               //       decoration: BoxDecoration(
//               //         color: Theme.of(context).primaryColor.withOpacity(0.9),
//               //         boxShadow: [
//               //           BoxShadow(
//               //               color:
//               //                   Theme.of(context).focusColor.withOpacity(0.1),
//               //               blurRadius: 5,
//               //               offset: Offset(0, 2)),
//               //         ],
//               //       ),
//               //       child: Row(
//               //         mainAxisAlignment: MainAxisAlignment.center,
//               //         crossAxisAlignment: CrossAxisAlignment.center,
//               //         children: <Widget>[
//               //           Flexible(
//               //             child: Row(
//               //               crossAxisAlignment: CrossAxisAlignment.center,
//               //               children: <Widget>[
//               //                 Expanded(
//               //                   child: Column(
//               //                     crossAxisAlignment: CrossAxisAlignment.start,
//               //                     children: <Widget>[
//               //                       Text(
//               //                         S.of(context).order_id +
//               //                             ": #${_con.order.id}",
//               //                         overflow: TextOverflow.ellipsis,
//               //                         maxLines: 2,
//               //                         style:
//               //                             Theme.of(context).textTheme.headline4,
//               //                       ),
//               //                       Text(
//               //                         _con.order.orderStatus.status,
//               //                         overflow: TextOverflow.ellipsis,
//               //                         maxLines: 2,
//               //                         style:
//               //                             Theme.of(context).textTheme.caption,
//               //                       ),
//               //                       Text(
//               //                         DateFormat('yyyy-MM-dd HH:mm', 'en')
//               //                             .format(_con.order.dateTime),
//               //                         style:
//               //                             Theme.of(context).textTheme.caption,
//               //                       ),
//               //                     ],
//               //                   ),
//               //                 ),
//               //                 SizedBox(width: 8),
//               //                 Column(
//               //                   mainAxisAlignment: MainAxisAlignment.start,
//               //                   crossAxisAlignment: CrossAxisAlignment.end,
//               //                   children: <Widget>[
//               //                     Helper.getPrice(
//               //                         Helper.getTotalOrdersPrice(_con.order),
//               //                         context,
//               //                         style: Theme.of(context)
//               //                             .textTheme
//               //                             .headline4),
//               //                     Text(
//               //                       _con.order.payment?.method ??
//               //                           S.of(context).cash_on_delivery,
//               //                       overflow: TextOverflow.ellipsis,
//               //                       maxLines: 2,
//               //                       style: Theme.of(context).textTheme.caption,
//               //                     ),
//               //                     Text(
//               //                       S.of(context).items +
//               //                               ':' +
//               //                               _con.order.foodOrders?.length
//               //                                   ?.toString() ??
//               //                           0,
//               //                       style: Theme.of(context).textTheme.caption,
//               //                     ),
//               //                   ],
//               //                 ),
//               //               ],
//               //             ),
//               //           )
//               //         ],
//               //       ),
//               //     ),
//               //     collapseMode: CollapseMode.pin,
//               //   ),
//               //   bottom: TabBar(
//               //       controller: _tabController,
//               //       indicatorSize: TabBarIndicatorSize.label,
//               //       labelPadding: EdgeInsets.symmetric(horizontal: 10),
//               //       unselectedLabelColor: Theme.of(context).accentColor,
//               //       labelColor: Theme.of(context).primaryColor,
//               //       indicator: BoxDecoration(
//               //           borderRadius: BorderRadius.circular(50),
//               //           color: Theme.of(context).accentColor),
//               //       tabs: [
//               //         Tab(
//               //           child: Container(
//               //             padding: EdgeInsets.symmetric(horizontal: 5),
//               //             decoration: BoxDecoration(
//               //                 borderRadius: BorderRadius.circular(50),
//               //                 border: Border.all(
//               //                     color: Theme.of(context)
//               //                         .accentColor
//               //                         .withOpacity(0.2),
//               //                     width: 1)),
//               //             child: Align(
//               //               alignment: Alignment.center,
//               //               child: Text(S.of(context).ordered_foods),
//               //             ),
//               //           ),
//               //         ),
//               //         Tab(
//               //           child: Container(
//               //             padding: EdgeInsets.symmetric(horizontal: 5),
//               //             decoration: BoxDecoration(
//               //                 borderRadius: BorderRadius.circular(50),
//               //                 border: Border.all(
//               //                     color: Theme.of(context)
//               //                         .accentColor
//               //                         .withOpacity(0.2),
//               //                     width: 1)),
//               //             child: Align(
//               //               alignment: Alignment.center,
//               //               child: Text(S.of(context).customer),
//               //             ),
//               //           ),
//               //         ),
//               //       ]),
//               // ),
//               SliverList(
//                 delegate: SliverChildListDelegate([
//                   Container(
//                       padding: EdgeInsets.only(left: 5, right: 5),
//                       child: Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         children: [
//                           Text(
//                             S.of(context).order_id + "-F24224GDJS",
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle1
//                                 .copyWith(fontSize: 12),
//                           ),
//                           Text(
//                             "Order Date-" +
//                                 _con.order.dateTime.toIso8601String(),
//                             style: Theme.of(context)
//                                 .textTheme
//                                 .subtitle1
//                                 .copyWith(fontSize: 12),
//                           ),
//                         ],
//                       ),
//                     ),
//                     Container(
//                       padding: EdgeInsets.only(left: 5, right: 5),
//                       alignment: Alignment.centerRight,
//                       child: Text(
//                         "Order Time-" + "3:23pm",
//                         style: Theme.of(context)
//                             .textTheme
//                             .subtitle1
//                             .copyWith(fontSize: 12),
//                       ),
//                     ),
//                   Offstage(
//                     offstage: 0 != _tabIndex,
//                     child: ListView.separated(
//                       padding: EdgeInsets.only(top: 20, bottom: 50),
//                       scrollDirection: Axis.vertical,
//                       shrinkWrap: true,
//                       primary: false,
//                       itemCount: _con.order.foodOrders?.length ?? 0,
//                       separatorBuilder: (context, index) {
//                         return SizedBox(height: 15);
//                       },
//                       itemBuilder: (context, index) {
//                         return FoodOrderItemWidget(
//                             heroTag: 'my_orders',
//                             order: _con.order,
//                             foodOrder: _con.order.foodOrders.elementAt(index));
//                       },
//                     ),
//                   ),
//                   Offstage(
//                     offstage: 1 != _tabIndex,
//                     child: Column(
//                       children: <Widget>[
//                         SizedBox(height: 20),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 7),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       S.of(context).fullName,
//                                       overflow: TextOverflow.ellipsis,
//                                       style:
//                                           Theme.of(context).textTheme.caption,
//                                     ),
//                                     Text(
//                                       _con.order.user.name,
//                                       style:
//                                           Theme.of(context).textTheme.bodyText1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 20),
//                               SizedBox(
//                                 width: 42,
//                                 height: 42,
//                                 child: FlatButton(
//                                   padding: EdgeInsets.all(0),
//                                   disabledColor: Theme.of(context)
//                                       .focusColor
//                                       .withOpacity(0.4),
//                                   onPressed: () {},
//                                   //onPressed: () {
// //                                    Navigator.of(context).pushNamed('/Profile',
// //                                        arguments: new RouteArgument(param: _con.order.deliveryAddress));
//                                   //},
//                                   child: Icon(
//                                     Icons.person,
//                                     color: Theme.of(context).primaryColor,
//                                     size: 24,
//                                   ),
//                                   color: Theme.of(context)
//                                       .accentColor
//                                       .withOpacity(0.9),
//                                   shape: StadiumBorder(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 7),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       S.of(context).deliveryAddress,
//                                       overflow: TextOverflow.ellipsis,
//                                       style:
//                                           Theme.of(context).textTheme.caption,
//                                     ),
//                                     Text(
//                                       _con.order.deliveryAddress?.address ??
//                                           S
//                                               .of(context)
//                                               .address_not_provided_please_call_the_client,
//                                       style:
//                                           Theme.of(context).textTheme.bodyText1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 20),
//                               SizedBox(
//                                 width: 42,
//                                 height: 42,
// //                                child: FlatButton(
// //                                  padding: EdgeInsets.all(0),
// //                                  disabledColor: Theme.of(context).focusColor.withOpacity(0.4),
// //                                  onPressed: () {
// //                                    Navigator.of(context).pushNamed('/Pages', arguments: new RouteArgument(id: '3', param: _con.order));
// //                                  },
// //                                  child: Icon(
// //                                    Icons.directions,
// //                                    color: Theme.of(context).primaryColor,
// //                                    size: 24,
// //                                  ),
// //                                  color: Theme.of(context).accentColor.withOpacity(0.9),
// //                                  shape: StadiumBorder(),
// //                                ),
//                               ),
//                             ],
//                           ),
//                         ),
//                         Container(
//                           padding: const EdgeInsets.symmetric(
//                               horizontal: 20, vertical: 7),
//                           child: Row(
//                             crossAxisAlignment: CrossAxisAlignment.center,
//                             children: <Widget>[
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: <Widget>[
//                                     Text(
//                                       S.of(context).phoneNumber,
//                                       overflow: TextOverflow.ellipsis,
//                                       style:
//                                           Theme.of(context).textTheme.caption,
//                                     ),
//                                     Text(
//                                       _con.order.user.phone,
//                                       overflow: TextOverflow.ellipsis,
//                                       style:
//                                           Theme.of(context).textTheme.bodyText1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               SizedBox(width: 10),
//                               SizedBox(
//                                 width: 42,
//                                 height: 42,
//                                 child: FlatButton(
//                                   padding: EdgeInsets.all(0),
//                                   onPressed: () {
//                                     launch("tel:${_con.order.user.phone}");
//                                   },
//                                   child: Icon(
//                                     Icons.call,
//                                     color: Theme.of(context).primaryColor,
//                                     size: 24,
//                                   ),
//                                   color: Theme.of(context)
//                                       .accentColor
//                                       .withOpacity(0.9),
//                                   shape: StadiumBorder(),
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ]),
//               )
//             ]),
        );
  }
}
