// flutter imports
import 'package:flutter/material.dart';

// third party imports
import 'package:equatable/equatable.dart';
import 'package:e_commerce/domain/models/shipping_address_model.dart';

@immutable
abstract class CheckoutState extends Equatable {
  final int selectedTabIndex;
  final ShippingAddressModel shippingAddress;

  CheckoutState({@required this.selectedTabIndex, this.shippingAddress});

  @override
  List<Object> get props => [selectedTabIndex, shippingAddress];
}

@immutable
class CheckoutInitialState extends CheckoutState {
  CheckoutInitialState(
      {@required int selectedTabIndex, ShippingAddressModel shippingAddress})
      : super(
            selectedTabIndex: selectedTabIndex,
            shippingAddress: shippingAddress);
}

@immutable
class TabSelectedState extends CheckoutState {
  TabSelectedState(
      {@required int selectedTabIndex, ShippingAddressModel shippingAddress})
      : super(
            selectedTabIndex: selectedTabIndex,
            shippingAddress: shippingAddress);
}

@immutable
class ShippingAddressLoadedState extends CheckoutState {
  ShippingAddressLoadedState(
      {@required int selectedTabIndex, ShippingAddressModel shippingAddress})
      : super(
            selectedTabIndex: selectedTabIndex,
            shippingAddress: shippingAddress);
}
