class PurchaseModel {
  PurchaseModel(this.uId,this._productId, this._purchaseToken);

  String uId;
  String _productId;
  String _purchaseToken;

  Map<String, dynamic> toJson() =>
      {
        'uId': uId,
        'productId': _productId,
        'purchaseToken' : _purchaseToken
      };
}