import 'package:equatable/equatable.dart';

import 'package:Eliverd/models/models.dart';
import 'package:meta/meta.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class FetchOrder extends OrderEvent {
  final Store store;

  const FetchOrder({@required this.store});

  @override
  List<Object> get props => [store];

  @override
  String toString() {
    return 'FetchOrder{ store: $store }';
  }
}

class ProceedOrder extends OrderEvent {
  final List<Stock> items;
  final List<int> amounts;
  final Coordinate shippingDestination;

  const ProceedOrder({@required this.items, @required this.amounts, this.shippingDestination});

  @override
  List<Object> get props => [items, amounts, shippingDestination];

  @override
  String toString() {
    return 'ProceedOrder{ items: $items, amounts: $amounts, shippingDestination: $shippingDestination }';
  }
}

class ApproveOrder extends OrderEvent {
  final String url;

  const ApproveOrder(this.url);

  @override
  List<Object> get props => [url];

  @override
  String toString() {
    return 'ApproveOrder{ orderId: $url }';
  }
}

class CancelOrder extends OrderEvent {
  final String url;

  const CancelOrder(this.url);

  @override
  List<Object> get props => [url];

  @override
  String toString() {
    return 'CancelOrder{ orderId: $url }';
  }
}

class FailOrder extends OrderEvent {
  final String url;

  const FailOrder(this.url);

  @override
  List<Object> get props => [url];

  @override
  String toString() {
    return 'FailOrder{ orderId: $url }';
  }
}


class ContinueOrder extends OrderEvent {
  final int orderId;

  const ContinueOrder(this.orderId);

  @override
  List<Object> get props => [orderId];

  @override
  String toString() {
    return 'ContinueOrder{ orderId: $orderId }';
  }
}
