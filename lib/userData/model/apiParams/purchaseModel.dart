class PurchaseModel {
  PurchaseModel(this._accessToken,this._productId, this._purchaseToken);

  String _accessToken;
  String _productId;
  String _purchaseToken;

  Map<String, dynamic> toJson() =>
      {
        'accessToken': _accessToken,
        'productId': _productId,
        'purchaseToken' : _purchaseToken
      };
}