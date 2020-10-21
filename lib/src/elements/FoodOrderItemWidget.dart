import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../helpers/helper.dart';
import '../models/food_order.dart';
import '../models/order.dart';
import '../models/route_argument.dart';

class FoodOrderItemWidget extends StatelessWidget {
  final String heroTag;
  final FoodOrder foodOrder;
  final Order order;

  const FoodOrderItemWidget({Key key, this.foodOrder, this.order, this.heroTag})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Theme.of(context).accentColor,
      focusColor: Theme.of(context).accentColor,
      highlightColor: Theme.of(context).primaryColor,
      onTap: () {
        Navigator.of(context)
            .pushNamed('/OrderDetails', arguments: RouteArgument(id: order.id));
      },
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 8),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor.withOpacity(0.9),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            Hero(
              tag: heroTag + foodOrder?.id.toString(),
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(50)),
                child: CachedNetworkImage(
                  height: 60,
                  width: 60,
                  fit: BoxFit.cover,
                  imageUrl:
                      "https://img.etimg.com/thumb/width-640,height-480,imgsize-144736,resizemode-1,msid-69037337/small-biz/startups/newsbuzz/fraud-is-only-possible-if-user-grants-access-oldrich-mller-coo-anydesk/oldrich-muller.jpg",
                  placeholder: (context, url) => Image.asset(
                    'assets/img/loading.gif',
                    fit: BoxFit.cover,
                    height: 60,
                    width: 60,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ),
            SizedBox(width: 15),
            Flexible(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "Jaideep Kumar",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.subtitle1,
                        ),
                        // Wrap(
                        //   children: List.generate(foodOrder.extras.length, (index) {
                        //     return Text(
                        //       foodOrder.extras.elementAt(index).name + ', ',
                        //       style: Theme.of(context).textTheme.caption,
                        //     );
                        //   }),
                        // ),
                        Text(
                          "+91-9232123321",
                          overflow: TextOverflow.ellipsis,
                          maxLines: 1,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        Text("Hno-1221, Ahmedabad - Gujrat",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 12,
                                    )),
                        Text("3 km away from your location",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 12,
                                    )),
                      ],
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(right: 10, top: 10),
                    padding: EdgeInsets.all(5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.green)),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Text("Total Amount",
                            style:
                                Theme.of(context).textTheme.bodyText1.copyWith(
                                      fontSize: 12,
                                    )),
                                    SizedBox(height: 2,),
                        Text(
                          Helper.getTotalOrderPrice(foodOrder).toString(),
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                              fontSize: 15),
                        )
                        // Text(

                        //     Helper.getTotalOrderPrice(foodOrder).toString(), context,
                        //     style: Theme.of(context).textTheme.subtitle1),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
