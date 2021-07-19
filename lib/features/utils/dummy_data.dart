// Parsed coin data strcuture from within app
List<dynamic> dummyCoinList = [
  {
    "coins": {
      "BNB": {"quantity": 95.2, "value": 12.569256},
      "NEO": {"quantity": 95.2, "value": 12.569256},
      "TRX": {"quantity": 95.2, "value": 12.569256}
    },
    "currency": "USDT",
    "total": 45.651713,
    "timestamp": 1620738580285
  },
  {
    "coins": {
      "USDT": {"quantity": 0.000799, "value": 45.7543355}
    },
    "currency": "BTC",
    "total": 45.7543355,
    "timestamp": 1620798793883
  },
  {
    "coins": {
      "USDT": {"quantity": 0.000406, "value": 23.14507342}
    },
    "currency": "BTC",
    "total": 23.14507342,
    "timestamp": 1620805525045
  },
  {
    "coins": {
      "SHIB": {"quantity": 744937.0, "value": 21.55847678}
    },
    "currency": "USDT",
    "total": 21.55847678,
    "timestamp": 1620813201918
  },
  {
    "coins": {
      "XRP": {"quantity": 662213.0, "value": 19.22404339},
      "SHIB": {"quantity": 662213.0, "value": 19.22404339}
    },
    "currency": "USDT",
    "total": 43.18642339,
    "timestamp": 1620813331191
  },
  {
    "coins": {
      "XRP": {"quantity": 14.48, "value": 21.19872},
      "SHIB": {"quantity": 772092.0, "value": 22.44471444}
    },
    "currency": "USDT",
    "total": 43.64343444,
    "timestamp": 1620814453936
  },
  {
    "coins": {
      "BNB": {"quantity": 0.3683, "value": 136.447784}
    },
    "currency": "USDT",
    "total": 136.447784,
    "timestamp": 1623754999095
  },
  {
    "coins": {
      "BTC": {"quantity": 0.037891, "value": 1127.35841897}
    },
    "currency": "USDT",
    "total": 1127.35841897,
    "timestamp": 1624371972665
  },
  {"coins": {}, "currency": "USDT", "total": 0.0, "timestamp": 1624934928986},
  {"coins": {}, "currency": "USDT", "total": 0.0, "timestamp": 1624934928986},
  {
    "coins": {
      "ETH": {"quantity": 0.24144, "value": 505.1793984},
      "MATIC": {"quantity": 449.0, "value": 505.352027},
      "BTC": {"quantity": 0.014669, "value": 503.78523806},
      "AUD": {"quantity": 659.2, "value": 498.0256},
      "SHIB": {"quantity": 659.2, "value": 498.0256},
      "LIFEMOON": {"quantity": 659.2, "value": 498.0256},
      "DOGE": {"quantity": 659.2, "value": 498.0256},
    },
    "currency": "USDT",
    "total": 2012.34226346,
    "timestamp": 1624935141451
  },
  {
    "coins": {
      "USDT": {"quantity": 141.19140915, "value": 0.004023}
    },
    "currency": "BTC",
    "total": 141.19140915,
    "timestamp": 1624958729880
  },
  {"coins": {}, "currency": "USDT", "total": 0.0, "timestamp": 1625625851453}
];

// Raw API response from Binance when selling snapshot, each item is a sold coin record.
// This would be the result of one sold snapshot, containing multiple coins.
List<dynamic> rawBinanceSoldResp = [
  {
    "symbol": "BTCUSDT",
    "orderId": 6844163234,
    "orderListId": -1,
    "clientOrderId": "aTPWeZgsIhKbORcmIaYAoX",
    "transactTime": 1626408953867,
    "price": 0.00000000,
    "origQty": 0.00160900,
    "executedQty": 0.00160900,
    "cummulativeQuoteQty": 51.41475832,
    "status": "FILLED",
    "timeInForce": "GTC",
    "type": "MARKET",
    "side": "SELL",
    "fills": [
      {
        "price": 31954.48000000,
        "qty": 0.00160900,
        "commission": 0.00011979,
        "commissionAsset": "BNB",
        "tradeId": 957295326
      }
    ]
  },
  {
    "symbol": "ETHUSDT",
    "orderId": 5028727986,
    "orderListId": -1,
    "clientOrderId": "vMm12uPfNwhag4Dn4PwcJg",
    "transactTime": 1626408953168,
    "price": 0.00000000,
    "origQty": 0.02669000,
    "executedQty": 0.02669000,
    "cummulativeQuoteQty": 52.08206530,
    "status": "FILLED",
    "timeInForce": "GTC",
    "type": "MARKET",
    "side": "SELL",
    "fills": [
      {
        "price": 1951.37000000,
        "qty": 0.02669000,
        "commission": 0.00012134,
        "commissionAsset": "BNB",
        "tradeId": 520183962
      }
    ]
  },
  {
    "symbol": "BNBUSDT",
    "orderId": 2669150724,
    "orderListId": -1,
    "clientOrderId": "XwVvhMZAahdmXmNzyvscEJ",
    "transactTime": 1626408952727,
    "price": 0.00000000,
    "origQty": 0.03570000,
    "executedQty": 0.03570000,
    "cummulativeQuoteQty": 11.48040600,
    "status": "FILLED",
    "timeInForce": "GTC",
    "type": "MARKET",
    "side": "SELL",
    "fills": [
      {
        "price": 321.58000000,
        "qty": 0.03570000,
        "commission": 0.00002674,
        "commissionAsset": "BNB",
        "tradeId": 359546298
      }
    ]
  },
  {
    "symbol": "MATICUSDT",
    "orderId": 822158153,
    "orderListId": -1,
    "clientOrderId": "ijPu8D4SakTbYDne0iw7oH",
    "transactTime": 1626408953500,
    "price": 0.00000000,
    "origQty": 57.80000000,
    "executedQty": 57.80000000,
    "cummulativeQuoteQty": 51.57494000,
    "status": "FILLED",
    "timeInForce": "GTC",
    "type": "MARKET",
    "side": "SELL",
    "fills": [
      {
        "price": 0.89230000,
        "qty": 57.80000000,
        "commission": 0.00012016,
        "commissionAsset": "BNB",
        "tradeId": 123032431
      }
    ]
  },
];
