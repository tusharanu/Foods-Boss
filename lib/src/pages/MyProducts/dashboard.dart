import 'package:flutter/material.dart';
import '../../custom/custom_text.dart';
import '../../custom/custom_widget.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool isChange;
  @override
  void initState() {
    super.initState();
    isChange = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          CustomText().welcome,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.sort,
            color: Colors.white,
          ),
          onPressed: () {},
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.notifications,
              color: Colors.white,
            ),
            onPressed: () {},
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
        ),
        child: ListView(
          children: [
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    CustomText().set_your_pressence,
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Switch(
                    inactiveTrackColor: Colors.red,
                    activeColor: Colors.green,
                    value: isChange,
                    onChanged: (bool change) {
                      setState(() {
                        isChange = change;
                      });
                    },
                  )
                ],
              ),
            ),
            Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
            Container(
              child: Text(
                CustomText().today_sale,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomWidget.ContainerWidget(
              text: CustomText().pending_orders,
              numberText: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                child: Text(
                  '5',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomWidget.ContainerWidget(
              text: CustomText().ready_to_ship,
              numberText: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                child: Text(
                  '56',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomWidget.ContainerWidget(
              text: CustomText().complete_orders,
              numberText: CircleAvatar(
                radius: 20,
                backgroundColor: Colors.green,
                child: Text(
                  '45',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            Divider(
              color: Colors.grey,
              thickness: 2.0,
            ),
            SizedBox(
              height: 15,
            ),
            CustomWidget.ContainerWidget(
              text: CustomText().my_products,
              numberText: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.of(context).pushReplacementNamed('/MyProducts');
                },
              ),
            ),
            SizedBox(
              height: 15,
            ),
            CustomWidget.ContainerWidget(
              text: CustomText().revenue,
              numberText: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {},
              ),
            ),
          ],
        ),
      ),
    );
  }
}
