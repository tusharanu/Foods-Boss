import 'package:flutter/material.dart';
import '../../custom/custom_widget.dart';
import '../../custom/custom_text.dart';

class MyProducts extends StatefulWidget {
  @override
  _MyProductsState createState() => _MyProductsState();
}

class _MyProductsState extends State<MyProducts> {
  double _selectedIndex = 0;
  bool isColor = true;

  List<Widget> body = [Placeholder(), Placeholder()];

  bool selected;
  @override
  void initState() {
    super.initState();
    selected = false;
  }

  // final PageController _pageController = PageController();
  final ScrollController _scrollController = ScrollController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(
          CustomText().my_products,
          style: TextStyle(
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
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
      body: Row(
        children: <Widget>[
          Container(
            width: 96,
            child: ListView(
              padding: EdgeInsets.zero,
              children: CustomWidget.navRail.map((e) {
                int index = CustomWidget.navRail.indexOf(e);
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedIndex = index.toDouble();
                      // _pageController.jumpToPage(_selectedIndex);
                      _scrollController.jumpTo(_selectedIndex);
                    });
                  },
                  child: Container(
                    padding: EdgeInsets.symmetric(horizontal: 16),
                    color: _selectedIndex == index.toDouble()
                        ? Colors.grey.shade200
                        : Colors.transparent,
                    height: 96,
                    width: 96,
                    child: Flexible(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/icons/${e.icon}.png',
                            color: _selectedIndex == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                          SizedBox(
                            height: 8,
                          ),
                          Text(
                            e.title,
                            textAlign: TextAlign.center,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: 12,
                              color: _selectedIndex == index.toDouble()
                                  ? Colors.black
                                  : Colors.grey,
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: CustomWidget.listproductitem.length,
              itemBuilder: (BuildContext context, int index) {
                bool str = true;

                if (CustomWidget.listproductitem[index].inStock ==
                    'No Stocks') {
                  isColor = false;
                }
                if (CustomWidget.listproductitem[index].inStock.isEmpty) {
                  str = !str;
                }

                return Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Text(CustomWidget.listproductitem[index].title),
                        str
                            ? Container(
                                padding: const EdgeInsets.all(5),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30),
                                  color: isColor ? Colors.green : Colors.red,
                                ),
                                child: Text(CustomWidget
                                    .listproductitem[index].inStock),
                              )
                            : Container(),
                        IconButton(
                            icon: Icon(Icons.arrow_forward_ios),
                            onPressed: () {
                              Navigator.of(context).pushReplacementNamed(
                                '/AddProduct',
                                arguments: [
                                  CustomWidget.listproductitem[index].title
                                ],
                              );
                            })
                      ],
                    ),
                    Divider(
                      color: Colors.grey,
                      thickness: 2.0,
                    ),
                  ],
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
