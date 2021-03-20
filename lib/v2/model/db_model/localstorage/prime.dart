class Prime {
  String _symbol;
  double _quantity;

  Prime.fromJson(json) {
    
  }

Map<String, dynamic> toJson() =>
{
  'symbol': _symbol,
  'quantity': _quantity,
};
}