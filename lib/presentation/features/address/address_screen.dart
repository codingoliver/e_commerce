// dart imports
import 'dart:convert';

// flutter imports
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// my app imports
import 'package:e_commerce/config/colors.dart';
import 'package:e_commerce/presentation/widgets/app_bar_with_back_icon.dart';
import 'package:e_commerce/presentation/widgets/input_field.dart';
import 'package:e_commerce/config/dimen.dart';
import 'package:e_commerce/domain/models/shipping_address_model.dart';
import 'package:e_commerce/presentation/widgets/dropdown.dart';

class AddressScreen extends StatefulWidget {
  final String appBarTitle;

  AddressScreen({@required this.appBarTitle});

  @override
  State<StatefulWidget> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  final _formKey = GlobalKey<FormState>();

  String _region;
  String _city;

  final TextEditingController _firstName = TextEditingController();
  final TextEditingController _lastName = TextEditingController();
  final TextEditingController _address = TextEditingController();
  final TextEditingController _phoneNumber = TextEditingController();
  final TextEditingController _additionalInfo = TextEditingController();
  final TextEditingController _additionalPhoneNumber = TextEditingController();

  Map<String, dynamic> _location;

  @override
  void initState() {
    super.initState();
    loadLocationData();
  }

  void loadLocationData() async {
    String data = await DefaultAssetBundle.of(context)
        .loadString("assets/data/location.json");

    this.setState(() {
      this._location = json.decode(data);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: colorWhite,
        appBar: AppBarWithBackIcon(
          context: context,
          title: '${this.widget.appBarTitle} Address',
        ),
        body: Column(
          children: <Widget>[
            Expanded(
                child: ListView(
              children: <Widget>[
                Container(
                    padding:
                        EdgeInsets.symmetric(vertical: 10.0, horizontal: 16.0),
                    color: secondaryHighlightColor,
                    width: MediaQuery.of(context).size.width,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          'Address Details',
                          style: Theme.of(context).textTheme.title,
                        ),
                        Text(
                          '*Required',
                          style: Theme.of(context).textTheme.display3,
                        )
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 16.0, vertical: 16.0),
                  child: Form(
                      autovalidate: true,
                      key: _formKey,
                      child: Column(
                        children: <Widget>[
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: InputField(
                                    hintText: 'Firstname',
                                    controller: this._firstName,
                                    keyboardType: TextInputType.text,
                                    validator: (value) {
                                      if (value.trim().isEmpty) {
                                        return 'Please enter firstname';
                                      }
                                      return null;
                                    }),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: InputField(
                                      hintText: 'Lastname',
                                      controller: this._lastName,
                                      keyboardType: TextInputType.text,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return 'Please enter lastname';
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: InputField(
                                      hintText: 'Address',
                                      keyboardType: TextInputType.text,
                                      controller: this._address,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return 'Please enter address';
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      top: 8.0, right: 10.0),
                                  child: InputField(
                                      hintText: 'Additional Info',
                                      keyboardType: TextInputType.text,
                                      controller: this._additionalInfo,
                                      validator: (value) {
                                        return null;
                                      }),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Dropdown(
                                    isFieldRequired: false,
                                    options: this._location != null
                                        ? this._location.keys.toList()
                                        : [''],
                                    hint: 'Region',
                                    value: this._region,
                                    onChanged: (value) {
                                      this.setState(() {
                                        this._region = value;
                                        this._city = '';
                                      });
                                    }),
                              ),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                  child: Dropdown(
                                isFieldRequired: false,
                                hint: 'City',
                                options: this._location != null &&
                                        this._region != null
                                    ? [''] +
                                        this
                                            ._location[this._region]
                                            .cast<String>()
                                    : [''],
                                value: this._city,
                                onChanged: (value) {
                                  this.setState(() {
                                    this._city = value;
                                  });
                                },
                              )),
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(top: 8.0),
                                  child: InputField(
                                      hintText: 'Phone number',
                                      controller: this._phoneNumber,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        if (value.trim().isEmpty) {
                                          return 'Please enter phone number';
                                        }
                                        return null;
                                      }),
                                ),
                              ),
                              Text(
                                '*',
                                style: TextStyle(
                                    fontSize: 28,
                                    color: primaryColor,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                          Row(
                            children: <Widget>[
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      right: 10, top: smallSpacing),
                                  child: InputField(
                                      hintText: 'Additional Phone number',
                                      controller: this._additionalPhoneNumber,
                                      keyboardType: TextInputType.phone,
                                      validator: (value) {
                                        return null;
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )),
                ),
              ],
            )),
            Container(
                padding: EdgeInsets.symmetric(horizontal: defaultWidgetPadding),
                decoration: BoxDecoration(color: colorWhite, boxShadow: [
                  BoxShadow(
                      color: dividerColor,
                      offset: Offset(0, -0.5),
                      blurRadius: 0.5)
                ]),
                child: FractionallySizedBox(
                  widthFactor: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, bottom: 8.0),
                    child: CupertinoButton(
                      minSize: buttonSize,
                      color: primaryColor,
                      child: Text(
                        'SAVE',
                        style: Theme.of(context).accentTextTheme.display2,
                      ),
                      onPressed: () {
                        if (this._formKey.currentState.validate()) {
                          ShippingAddressModel shippingAddressModel =
                              ShippingAddressModel(
                                  firstName: this._firstName.text,
                                  lastName: this._lastName.text,
                                  addressLine1: this._address.text,
                                  addressLine2: this._additionalInfo.text,
                                  region: this._region,
                                  city: this._city,
                                  phoneNumber1: this._phoneNumber.text,
                                  phoneNumber2:
                                      this._additionalPhoneNumber.text);
                          Navigator.pop(context, shippingAddressModel);
                        }
                      },
                    ),
                  ),
                )),
          ],
        ));
  }
}
