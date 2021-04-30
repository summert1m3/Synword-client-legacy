import 'dart:async';
import 'package:dio/dio.dart';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:synword/constants/googleProductId.dart';
import 'package:synword/constants/mainServerData.dart';
import 'package:synword/exceptions/serverUnavailableException.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/userData/model/apiParams/purchaseModel.dart';

class Purchase {
  Purchase._internal();

  static final Purchase _instance = Purchase._internal();

  factory Purchase() {
    return _instance;
  }

  static Purchase get instance => _instance;

  Dio _dio = new Dio(
    BaseOptions(contentType: Headers.formUrlEncodedContentType),
  );

  /// Is the API available on the device
  bool _available = true;

  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Products for sale
  List<ProductDetails> _products = [];

  /// Past purchases
  List<PurchaseDetails> _purchases = [];

  late StreamSubscription<List<PurchaseDetails>> _subscription;

  /// Initialize data
  Future<void> initialize() async {
    _available = await _iap.isAvailable();

    if (_available) {
      if(GoogleAuthService.googleUser != null) {
        await _getPastPurchases();
      }

      await _loadProductsForSale();

      // Verify and deliver a purchase with your own business logic
      if (_purchases.isNotEmpty) {
        for (PurchaseDetails purchase in _purchases) {
          await verifyAndDeliverPurchase(purchase);
        }
      }
    }
    _subscription = _iap.purchaseUpdatedStream.listen((purchases) async {
      for (PurchaseDetails purchase in purchases) {
        if (purchase.status == PurchaseStatus.purchased && GoogleAuthService.googleUser != null) {
          print('NEW PURCHASE: ${purchase.productID}');
          await this.verifyAndDeliverPurchase(purchase);
          await CurrentUser.serverRequest.authorization();
          if (purchase.pendingCompletePurchase) {
            _iap.completePurchase(purchase);
          }
          print('PURCHASE COMPLETED');
        }
      }
    }, onDone: () {
      _subscription.cancel();
    });
    print('IAP initialized successfully');
  }

  Future<void> _loadProductsForSale() async {
    final ProductDetailsResponse response =
        await InAppPurchaseConnection.instance.queryProductDetails(GoogleProductId.productIds.toSet());
    if (response.notFoundIDs.isNotEmpty) {
      // Handle the error.
    }
    _products = response.productDetails;
  }

  /// Gets past purchases
  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response = await _iap.queryPastPurchases();

    for (PurchaseDetails purchase in response.pastPurchases) {
      await verifyAndDeliverPurchase(
          purchase); // Verify the purchase following the best practices for each storefront.
      await CurrentUser.serverRequest.authorization();
      if (purchase.pendingCompletePurchase) {
        _iap.completePurchase(purchase);
      }
    }
    _purchases = response.pastPurchases;
  }

  ProductDetails getProduct(String productId){
    if(_products.isNotEmpty){
      return _products.firstWhere((element) => element.id == productId);
    }
    throw Exception('_products is empty');
  }

  Future<void> verifyAndDeliverPurchase(PurchaseDetails purchase) async {
    try {
      PurchaseModel purchaseModel = PurchaseModel(
          GoogleAuthService.googleUser!.id,
          purchase.productID,
          purchase.verificationData.serverVerificationData);

      await _dio.post(MainServerData.authUserApi.purchaseVerification,
          data: purchaseModel.toJson());

    } on DioError catch (ex) {
      throw ServerUnavailableException();
    }
  }

  Future<void> buyNonConsumableProduct(String productId) async {
    if (await _iap.isAvailable()) {
      Set<String> id = Set.from([productId]);
      ProductDetailsResponse response = await _iap.queryProductDetails(id);
      PurchaseParam purchaseParam =
          PurchaseParam(productDetails: response.productDetails.first);

      await InAppPurchaseConnection.instance
          .buyNonConsumable(purchaseParam: purchaseParam);
    } else {
      throw Exception('iap is not Available');
    }
  }

  Future<void> buyConsumableProduct(String productId) async {
    if (await _iap.isAvailable()) {
      Set<String> id = Set.from([productId]);
      ProductDetailsResponse response = await _iap.queryProductDetails(id);
      PurchaseParam purchaseParam =
          PurchaseParam(productDetails: response.productDetails.first);

      await InAppPurchaseConnection.instance
          .buyConsumable(purchaseParam: purchaseParam);
    } else {
      throw Exception('iap is not Available');
    }
  }
}