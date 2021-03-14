import 'package:coinsnap/v2/model/db_model/dummy/dummy_model.dart';

abstract class IDummyRepository {
  DummyPortfolioModel dummyGetPortfolio();
}

class DummyRepositoryImpl implements IDummyRepository {
  @override
  DummyPortfolioModel dummyGetPortfolio() {
    return DummyPortfolioModel.fromJson(DummyData.getData);
  }
}

class DummyData {

 static final getData = [
    {
      'coinName': 'Bitcoin',
      'coinTicker': 'BTC',
      //  'icon': CryptoFontIcons.BTC,
      //  'iconColor': Colors.orange,
      //  'change': '+3.67%',
      //  'changeValue': '+202.835',
      //  'changeColor': Colors.green,
      'quantity': '0.29314423',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Ethereum',
      'coinTicker': 'ETH',
      'quantity': '1.23092233',
      'isFavourite': 'True',
    },
    {
      'coinName': 'Stellar',
      'coinTicker': 'XLM',
      'quantity': '4231.12398821',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Ripple',
      'coinTicker': 'XRP',
      'quantity': '22154',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Terra',
      'coinTicker': 'LUNA',
      'quantity': '12.13248821',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Chiliz',
      'coinTicker': 'CHZ',
      'quantity': '0.89314423',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Kusama',
      'coinTicker': 'KSM',
      'quantity': '0.89123428',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Reef Finance',
      'coinTicker': 'REEF',
      'quantity': '14.99331234',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Bonded Finance',
      'coinTicker': 'BOND',
      'quantity': '32000',
      'isFavourite': 'False',
    },
    {
      'coinName': 'PIVX',
      'coinTicker': 'PIVX',
      'quantity': '42.12378888',
      'isFavourite': 'False',
    },
    {
      'coinName': 'HEX',
      'coinTicker': 'HEX',
      'quantity': '89.12341234',
      'isFavourite': 'False',
    },
    {
      'coinName': 'Basic Attention Token',
      'coinTicker': 'BAT',
      'quantity': '41635.21341541',
      'isFavourite': 'False',
    },
  ];
}