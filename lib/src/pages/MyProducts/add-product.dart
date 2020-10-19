import 'package:flutter/material.dart';
import '../../custom/custom_text.dart';
import '../../custom/custom_widget.dart';

class AddProduct extends StatefulWidget {
  @override
  _AddProductState createState() => _AddProductState();
}

class _AddProductState extends State<AddProduct> {
  List<String> qtyList = List();
  List<String> weightList = List();
  List<String> gramList = List();
  String qty;
  String weight;
  String grams;
  bool isChange = true;
  int _radioValue1 = -1;
  void _handleRadioValueChange1(int value) {
    setState(() {
      _radioValue1 = value;
    });
  }

  @override
  void initState() {
    super.initState();
    qtyList = <String>['100 Pcs', '120 Pcs'];
    weightList = <String>['KG', 'Gms'];
  }

  @override
  Widget build(BuildContext context) {
    // String title = ModalRoute.of(context).settings.arguments;
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
      body: ListView(
        scrollDirection: Axis.vertical,
        padding: const EdgeInsets.all(10),
        shrinkWrap: true,
        children: [
          Container(child: Text('Title')),
          SizedBox(
            height: 10,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  child: Image.asset('assets/img/apple.png'),
                ),
                SizedBox(
                  width: 10,
                ),
                Container(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.add_circle_outline),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Container(
                        padding: const EdgeInsets.all(40),
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.black,
                          ),
                        ),
                        child: Icon(Icons.add_circle_outline),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  CustomText().availability,
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
          Container(
            child: Text(
              CustomText().quick_selection,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: GridView.builder(
                // physics: ScrollPhysics,
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: CustomWidget.numberofitem.length,
                gridDelegate: new SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 1 / 0.3, crossAxisCount: 2),
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    margin: EdgeInsets.all(10),
                    width: MediaQuery.of(context).size.width / 6,
                    height: 20,
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.green,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      children: [
                        Radio(
                          activeColor: Colors.green,
                          groupValue: _radioValue1,
                          onChanged: _handleRadioValueChange1,
                          value: index,
                        ),
                        Text(CustomWidget.numberofitem[index]),
                      ],
                    ),
                  );
                }),
          ),
          Container(
            child: Text(
              CustomText().manual__selection,
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Container(
            child: Text(
              CustomText().quantity,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            child: CustomWidget.buildDropDown(
                context: context,
                fn: (input) {
                  setState(() {
                    weight = input;
                  });
                },
                inputValue: weight,
                list: weightList,
                text: 'Select Weight'),
          ),
          Container(
            child: Text(
              CustomText().grams,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            child: CustomWidget.buildDropDown(
                context: context,
                fn: (input) {
                  setState(() {
                    qty = input;
                  });
                },
                inputValue: qty,
                list: qtyList,
                text: 'Select Quantity'),
          ),
          Container(
            child: Text(
              CustomText().pricing,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w300,
              ),
            ),
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  width: 200,
                  child: TextFormField(
                    keyboardType: TextInputType.text,
                    // onSaved: (input) => _con.user.password = input,
                    // validator: (input) => input.length < 3
                    //     ? S.of(context).should_be_more_than_3_characters
                    //     : null,
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      // labelText: S.of(context).password,
                      labelStyle: TextStyle(
                          color:
                              Theme.of(context).shadowColor.withOpacity(0.4)),
                      contentPadding: EdgeInsets.all(12),
                      hintText: 'Pricing per kg',
                      hintStyle: TextStyle(
                          color: Theme.of(context).focusColor.withOpacity(0.7)),

                      // prefixIcon: Icon(Icons.alternate_email,
                      //     color: Theme.of(context).accentColor),
                      border: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.2))),
                      focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                              color: Theme.of(context)
                                  .focusColor
                                  .withOpacity(0.5))),
                      enabledBorder: OutlineInputBorder(
                          borderSide: BorderSide(color: Colors.green)),
                    ),
                  ),
                ),
                Container(
                  width: 100,
                  decoration:
                      BoxDecoration(border: Border.all(color: Colors.green)),
                  // color: Colors.green,
                  child: DropdownButtonHideUnderline(
                    // key: key,
                    child: DropdownButton<String>(
                      value: grams,
                      autofocus: true,
                      isExpanded: true,
                      hint: new Container(
                          padding: EdgeInsets.only(left: 5),
                          child: FittedBox(
                            child: Text('weight'),
                          )),
                      icon: Icon(Icons.arrow_drop_down_sharp),
                      iconSize: 40,
                      onChanged: (fn) {},
                      items: gramList
                          .map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          onTap: () {},
                          value: value,
                          child: Container(
                              padding: EdgeInsets.only(left: 15),
                              child: Text(
                                value,
                              )),
                        );
                      }).toList(),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            child: Text(
              CustomText().product_desc,
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          SizedBox(
            width: 200,
            // height: 300,
            child: TextFormField(
              // maxLength: 300,
              // minLines: 1,

              expands: false,
              keyboardType: TextInputType.text,
              // onSaved: (input) => _con.user.password = input,
              // validator: (input) => input.length < 3
              //     ? S.of(context).should_be_more_than_3_characters
              //     : null,
              decoration: InputDecoration(
                enabled: true,
                fillColor: Colors.white,
                filled: true,
                // labelText: S.of(context).password,
                labelStyle: TextStyle(
                    color: Theme.of(context).shadowColor.withOpacity(0.4)),
                contentPadding: EdgeInsets.all(12),
                hintText: '',
                hintStyle: TextStyle(
                    color: Theme.of(context).focusColor.withOpacity(0.7)),

                // prefixIcon: Icon(Icons.alternate_email,
                //     color: Theme.of(context).accentColor),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: Colors.green),
                ),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                        color: Theme.of(context).focusColor.withOpacity(0.5))),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green)),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          FlatButton(
            height: 50,
            child: Text(
              'Submit',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
            color: Color(0xff60A735),
            onPressed: () {
              // _con.resetPassword();
              Navigator.of(context).pushReplacementNamed('/ChooseLanguage');
            },
          ),
        ],
      ),
    );
  }
}
