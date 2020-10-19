import 'package:flutter/material.dart';
import '../models/list_product-item.dart';
import '../models/nav-item.dart';

class CustomWidget {
  static Widget buildDropDown({
    BuildContext context,
    String inputValue,
    List<String> list,
    String text,
    Function fn,
    Function fn1,
    ValueKey key,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0.0, horizontal: 10.0),
      // margin: const EdgeInsets.only(top: 20, left: 20, right: 20),
      width: MediaQuery.of(context).size.width,
      // padding: EdgeInsets.only(left: 3, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(
          color: Colors.green,
        ),
        borderRadius: BorderRadius.all(Radius.circular(6.0)),
      ),
      // border: Border.all(color: Colors.blue, width: 1)),
      child: DropdownButtonHideUnderline(
        // key: key,
        child: DropdownButton<String>(
          key: key,
          // style: kheadingStyle.apply(
          //   fontWeightDelta: 3,
          //   fontSizeFactor: 1.0,
          // ),
          // isDense: true,
          value: inputValue,
          autofocus: true,
          isExpanded: true,
          hint: new Container(
              padding: EdgeInsets.only(left: 5),
              child: FittedBox(
                child: Text(
                  text == null ? 'Value' : text,
                  // style: kheadingStyle.apply(
                  //   fontWeightDelta: 3,
                  //   fontSizeFactor: 1.2,
                  // ),
                ),
              )),
          icon: Icon(Icons.arrow_drop_down_sharp),
          iconSize: 40,
          onChanged: fn,
          items: list.map<DropdownMenuItem<String>>((String value) {
            return DropdownMenuItem<String>(
              onTap: fn1,
              value: value,
              child: Container(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    value,
                    // style: kheadingStyle.apply(
                    //   fontWeightDelta: 3,
                    //   fontSizeFactor: 1.2,
                    //   color: Color(0xff2d1f76),
                    // ),
                  )),
            );
          }).toList(),
        ),
      ),
    );
  }

  static Widget ContainerWidget({
    @required String text,
    @required Widget numberText,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: 10,
        right: 10,
      ),
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          color: Colors.green,
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(text),
          numberText,
        ],
      ),
    );
  }

  static List<NavItem> navRail = [
    NavItem("Fruits", 'Fruits', color: Colors.black),
    NavItem("Vegetables", 'vegetable', color: Colors.black),
    NavItem("food Grains Oils & Masala", 'Food', color: Colors.black),
    NavItem("Dairy Products", 'Dairy', color: Colors.black),
    NavItem("Snacks & Brand Foods", 'Snacks', color: Colors.black),
    NavItem("Beauty & Hygenic Items", 'Beauty', color: Colors.black),
    NavItem("Cleaning & Households", 'Cleaning', color: Colors.black),
    NavItem("Baby Care", 'Baby', color: Colors.black),
    NavItem("Beverages", 'Beverages', color: Colors.black),
  ];

  static List<ListProductItem> listproductitem = [
    ListProductItem('Apple', '25 KG in stocks'),
    ListProductItem('Orange', 'No Stocks'),
    ListProductItem('banana', '25 KG in stocks'),
    ListProductItem('Grapes', '25 KG in stocks'),
    ListProductItem('Mango', '25 KG in stocks'),
    ListProductItem('Papaya', ''),
  ];

  static List numberofitem = [
    "5 Pcs",
    "10 Pcs",
    "15 Pcs",
    "20 Pcs",
    "25 Pcs",
    "30 Pcs",
    "35 Pcs",
    "40 Pcs",
  ];
}
