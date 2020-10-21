import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:intl/intl.dart' show DateFormat;

import '../../generated/l10n.dart';
import '../helpers/helper.dart';
import '../models/order.dart';
import '../models/route_argument.dart';
import 'FoodOrderItemWidget.dart';

class OrderItemWidget extends StatefulWidget {
  final bool expanded;
  final Order order;
  final ValueChanged<void> onCanceled;
  final int status_code;
  //String btn_text="";

  OrderItemWidget({
    Key key,
    this.expanded,
    this.order,
    this.onCanceled,
    this.status_code,
  }) : super(key: key);

  @override
  _OrderItemWidgetState createState() => _OrderItemWidgetState();
}

class _OrderItemWidgetState extends State<OrderItemWidget> {
  @override
  Widget build(BuildContext context) {
    var chipColors;
    String chipStatus;
    String btn_text;
    if (widget.status_code == 0) {
      chipColors = Colors.yellow;
      chipStatus = "Accepted";
      btn_text = "Assign Rider";
    } else if (widget.status_code == 1) {
      chipColors = Colors.red;
      chipStatus = "Rejected";
      btn_text = "Assign Rider";
    } else if (widget.status_code == 2) {
      chipColors = Colors.green;
      chipStatus = "Deliverd";
      btn_text = "Assign Rider";
    } else {
      chipColors = Colors.transparent;
      chipStatus = "";
      //widget.btn_text="View";
      btn_text = "View";
    }

    final theme = Theme.of(context).copyWith(dividerColor: Colors.transparent);
    return Stack(
      children: <Widget>[
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            Container(
              margin: const EdgeInsets.only(left: 10, right: 10),
              padding: const EdgeInsets.all(3.0),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.green),
                borderRadius: BorderRadius.circular(10),
                color: Theme.of(context).primaryColor.withOpacity(0.9),
                boxShadow: [
                  BoxShadow(
                      color: Theme.of(context).focusColor.withOpacity(0.1),
                      blurRadius: 5,
                      offset: Offset(0, 2)),
                ],
              ),
              child: Theme(
                data: theme,
                child: Column(
                  // initiallyExpanded: widget.expanded,
                  // title: Column(
                  //   children: <Widget>[
                  //     Text('${S.of(context).order_id}: #${widget.order.id}'),
                  //     Text(
                  //       DateFormat('dd-MM-yyyy | HH:mm').format(widget.order.dateTime),
                  //       style: Theme.of(context).textTheme.caption,
                  //     ),
                  //   ],
                  //   crossAxisAlignment: CrossAxisAlignment.start,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  // ),
                  // trailing: Column(
                  //   crossAxisAlignment: CrossAxisAlignment.end,
                  //   mainAxisAlignment: MainAxisAlignment.center,
                  //   children: <Widget>[
                  //     Helper.getPrice(Helper.getTotalOrdersPrice(widget.order), context, style: Theme.of(context).textTheme.headline4),
                  //     Text(
                  //       '${widget.order.payment.method}',
                  //       style: Theme.of(context).textTheme.caption,
                  //     )
                  //   ],
                  // ),
                  children: <Widget>[
                    Container(
                      alignment: Alignment.topRight,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        width: 80,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            color: chipColors,
                            borderRadius: BorderRadius.circular(20)),
                        child: Text(chipStatus),
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            S.of(context).order_id + "-F24224GDJS",
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontSize: 12),
                          ),
                          Text(
                            "Order Date-" +
                                widget.order.dateTime.toIso8601String(),
                            style: Theme.of(context)
                                .textTheme
                                .subtitle1
                                .copyWith(fontSize: 12),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: EdgeInsets.only(left: 5, right: 5),
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
                            itemCount: widget.order.foodOrders.length,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext ctx, index) {
                              return FoodOrderItemWidget(
                                heroTag: 'myWidget.orders',
                                order: widget.order,
                                foodOrder:
                                    widget.order.foodOrders.elementAt(index),
                              );
                            })
                      ],
                      //     children: List.generate(
                      //   widget.order.foodOrders.length,
                      //   (indexFood) {
                      //     return FoodOrderItemWidget(
                      //         heroTag: 'mywidget.orders',
                      //         order: widget.order,
                      //         foodOrder:
                      //             widget.order.foodOrders.elementAt(indexFood));
                      //   },
                      // )
                    ),
                    Padding(
                      padding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                      child: Column(
                        children: <Widget>[
                          Container(
                            child: Table(
                              border: TableBorder.all(
                                color: Colors.green,
                                width: 1.0,
                              ),
                              children: [
                                TableRow(children: [
                                  TableCell(
                                    child: Center(
                                      child: Text('Product'),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: Text(
                                        'Quantity',
                                      ),
                                    ),
                                  ),
                                  TableCell(
                                    child: Center(
                                      child: Text(
                                        'Price',
                                      ),
                                    ),
                                  ),
                                ]),
                              ],
                            ),
                          ),
                          Container(
                            child: ListView.builder(
                              shrinkWrap: true,
                              itemBuilder: (BuildContext context, index) {
                                return Table(
                                  border: TableBorder.all(
                                    color: Colors.green,
                                    width: 1.0,
                                  ),
                                  children: [
                                    TableRow(children: [
                                      TableCell(
                                        child: Center(
                                          child: Text(
                                            'Mango',
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text(
                                            '1232',
                                          ),
                                        ),
                                      ),
                                      TableCell(
                                        child: Center(
                                          child: Text(
                                            'Rs.3123',
                                          ),
                                        ),
                                      ),
                                    ])
                                  ],
                                );
                              },
                              itemCount: 1,
                            ),
                          ),

                          // Row(
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: Text(
                          //         S.of(context).delivery_fee,
                          //         style: Theme.of(context).textTheme.bodyText1,
                          //       ),
                          //     ),
                          //     Helper.getPrice(widget.order.deliveryFee, context,
                          //         style: Theme.of(context).textTheme.subtitle1)
                          //   ],
                          // ),
                          // Row(
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: Text(
                          //         '${S.of(context).tax} (${widget.order.tax}%)',
                          //         style: Theme.of(context).textTheme.bodyText1,
                          //       ),
                          //     ),
                          //     Helper.getPrice(
                          //         Helper.getTaxOrder(widget.order), context,
                          //         style: Theme.of(context).textTheme.subtitle1)
                          //   ],
                          // ),
                          // Row(
                          //   children: <Widget>[
                          //     Expanded(
                          //       child: Text(
                          //         S.of(context).total,
                          //         style: Theme.of(context).textTheme.bodyText1,
                          //       ),
                          //     ),
                          //     Helper.getPrice(
                          //         Helper.getTotalOrdersPrice(widget.order),
                          //         context,
                          //         style: Theme.of(context).textTheme.headline4)
                          //   ],
                          // ),
                          Container(
                              margin: EdgeInsets.only(top: 15),
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  color: Colors.green,
                                  borderRadius: BorderRadius.circular(10)),
                              child: FlatButton(
                                onPressed: () {
                                  Navigator.of(context).pushNamed(
                                      '/OrderDetails',
                                      arguments:
                                          RouteArgument(id: widget.order.id));
                                },
                                textColor: Colors.white,
                                child: Text(
                                  btn_text,
                                ),
                                padding: EdgeInsets.symmetric(horizontal: 0),
                              ))
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
            // Container(
            //   color: Colors.green,
            //   child: Wrap(
            //     alignment: WrapAlignment.end,
            //     children: <Widget>[
            //       FlatButton(
            //         onPressed: () {
            //           Navigator.of(context).pushNamed('/OrderDetails',
            //               arguments: RouteArgument(id: widget.order.id));
            //         },
            //         textColor: Theme.of(context).hintColor,
            //         child: Text(S.of(context).view),
            //         padding: EdgeInsets.symmetric(horizontal: 0),
            //       ),
            //       // if (widget.order.canEditOrder())
            //       //   FlatButton(
            //       //     onPressed: () {
            //       //       Navigator.of(context).pushNamed('/OrderEdit',
            //       //           arguments: RouteArgument(id: widget.order.id));
            //       //     },
            //       //     textColor: Theme.of(context).hintColor,
            //       //     child: Text(S.of(context).edit),
            //       //     padding: EdgeInsets.symmetric(horizontal: 0),
            //       //   ),
            //       // if (widget.order.canCancelOrder())
            //       //   FlatButton(
            //       //     onPressed: () {
            //       //       showDialog(
            //       //         context: context,
            //       //         builder: (BuildContext context) {
            //       //           // return object of type Dialog
            //       //           return AlertDialog(
            //       //             title: Wrap(
            //       //               spacing: 10,
            //       //               children: <Widget>[
            //       //                 Icon(Icons.report, color: Colors.orange),
            //       //                 Text(
            //       //                   S.of(context).confirmation,
            //       //                   style: TextStyle(color: Colors.orange),
            //       //                 ),
            //       //               ],
            //       //             ),
            //       //             content: Text(S
            //       //                 .of(context)
            //       //                 .areYouSureYouWantToCancelThisOrderOf),
            //       //             contentPadding: EdgeInsets.symmetric(
            //       //                 horizontal: 30, vertical: 25),
            //       //             actions: <Widget>[
            //       //               FlatButton(
            //       //                 child: new Text(
            //       //                   S.of(context).yes,
            //       //                   style: TextStyle(
            //       //                       color: Theme.of(context).hintColor),
            //       //                 ),
            //       //                 onPressed: () {
            //       //                   widget.onCanceled(widget.order);
            //       //                   Navigator.of(context).pop();
            //       //                 },
            //       //               ),
            //       //               FlatButton(
            //       //                 child: new Text(
            //       //                   S.of(context).close,
            //       //                   style: TextStyle(color: Colors.orange),
            //       //                 ),
            //       //                 onPressed: () {
            //       //                   Navigator.of(context).pop();
            //       //                 },
            //       //               ),
            //       //             ],
            //       //           );
            //       //         },
            //       //       );
            //       //     },
            //       //     textColor: Theme.of(context).hintColor,
            //       //     child: Wrap(
            //       //       children: <Widget>[Text(S.of(context).cancel + " ")],
            //       //     ),
            //       //     padding: EdgeInsets.symmetric(horizontal: 10),
            //       //   ),
            //     ],
            //   ),
            // ),
          ],
        ),
        // Container(
        //   margin: EdgeInsetsDirectional.only(start: 20),
        //   padding: EdgeInsets.symmetric(horizontal: 10),
        //   height: 28,
        //   width: 140,
        //   decoration: BoxDecoration(
        //       borderRadius: BorderRadius.all(Radius.circular(100)),
        //       color: widget.order.active
        //           ? Theme.of(context).accentColor
        //           : Colors.redAccent),
        //   alignment: AlignmentDirectional.center,
        //   child: Text(
        //     widget.order.active
        //         ? '${widget.order.orderStatus.status}'
        //         : S.of(context).canceled,
        //     maxLines: 1,
        //     overflow: TextOverflow.fade,
        //     softWrap: false,
        //     style: Theme.of(context).textTheme.caption.merge(
        //         TextStyle(height: 1, color: Theme.of(context).primaryColor)),
        //   ),
        // ),
      ],
    );
  }
}
