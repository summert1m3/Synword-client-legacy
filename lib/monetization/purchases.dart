import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:in_app_purchase/in_app_purchase.dart';
import 'package:synword/constants/googleProductId.dart';
import 'package:synword/constants/mainServerData.dart';
import 'package:synword/exceptions/serverException.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/model/apiParams/purchaseModel.dart';

class Purchase {
  /// Is the API available on the device
  bool _available = true;

  /// The In App Purchase plugin
  InAppPurchaseConnection _iap = InAppPurchaseConnection.instance;

  /// Products for sale
  List<ProductDetails> _products = [];

  /// Past purchases
  List<PurchaseDetails> _purchases = [];

  /// Initialize data
  void initialize() async {
    // Check availability of In App Purchases
    _available = await _iap.isAvailable();

    if (_available) {
      await _getProducts();
      await _getPastPurchases();

      // Verify and deliver a purchase with your own business logic
      if (_purchases.isNotEmpty) {
        for (PurchaseDetails purchase in _purchases) {
          verifyAndDeliverPurchase(purchase);
        }
      }
    }
  }

  /// Get all products available for sale
  Future<void> _getProducts() async {
    Set<String> ids = Set.from([
      GoogleProductId.premium,
      GoogleProductId.plagiarism_check_100,
      GoogleProductId.plagiarism_check_300,
      GoogleProductId.plagiarism_check_600,
      GoogleProductId.plagiarism_check_1000
    ]);
    ProductDetailsResponse response = await _iap.queryProductDetails(ids);

    _products = response.productDetails;
  }

  /// Gets past purchases
  Future<void> _getPastPurchases() async {
    QueryPurchaseDetailsResponse response =
    await _iap.queryPastPurchases();

    for (PurchaseDetails purchase in response.pastPurchases) {
      verifyAndDeliverPurchase(
          purchase); // Verify the purchase following the best practices for each storefront.
      if (Platform.isIOS) {
        // Mark that you've delivered the purchase. Only the App Store requires
        // this final confirmation.
        InAppPurchaseConnection.instance.completePurchase(purchase);
      }
    }
    _purchases = response.pastPurchases;
  }

  void verifyAndDeliverPurchase(PurchaseDetails purchase) async {
    try {
      HttpClient client = HttpClient();
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;

      HttpClientRequest request = await client.postUrl(Uri.http(
          MainServerData.IP, MainServerData.authUserApi.purchaseVerification));
      request.headers.set(
          HttpHeaders.contentTypeHeader, 'application/json; charset=utf-8');

      PurchaseModel purchaseModel = PurchaseModel(
          googleAuthService.googleAuth.accessToken, purchase.productID,
          purchase.verificationData.serverVerificationData);

      request.write(jsonEncode(purchaseModel.toJson()));

      HttpClientResponse response = await request.close().timeout(
          Duration(seconds: 10));

      if (response.statusCode == 500) {
        throw new ServerException();
      }

      if (response.statusCode == 400) {
        throw new ServerException();
      }
    } on TimeoutException {
      throw ServerException();
    }
  }

  Future<void> buyNonConsumableProduct(String productId) async {
    if (await _iap.isAvailable()) {
      Set<String> id = Set.from([productId]);
      ProductDetailsResponse response = await _iap.queryProductDetails(id);
      PurchaseParam purchaseParam = PurchaseParam(
          productDetails: response.productDetails.first);

      await InAppPurchaseConnection.instance.buyNonConsumable(
          purchaseParam: purchaseParam);
    } else {
      throw Exception();
    }
  }

  Future<void> buyConsumableProduct(String productId) async {
    if (await _iap.isAvailable()) {
      Set<String> id = Set.from([productId]);
      ProductDetailsResponse response = await _iap.queryProductDetails(id);
      PurchaseParam purchaseParam = PurchaseParam(
          productDetails: response.productDetails.first);

      await InAppPurchaseConnection.instance.buyConsumable(
          purchaseParam: purchaseParam);
    } else {
      throw Exception();
    }
  }
}

Purchase monetization = Purchase();