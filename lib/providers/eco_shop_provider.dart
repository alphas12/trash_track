import 'package:flutter/material.dart';
import '../models/eco_shop_model.dart';
import '../repositories/eco_shop_repository.dart';

class EcoShopProvider with ChangeNotifier {
  EcoShop? _shop;
  EcoShop? get shop => _shop;

  final EcoShopRepository _repository = EcoShopRepository();

  Future<void> fetchShop(String shopId) async {
    _shop = await _repository.getShopById(shopId);
    notifyListeners();
  }
}