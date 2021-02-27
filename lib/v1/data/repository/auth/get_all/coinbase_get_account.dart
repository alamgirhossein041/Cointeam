import 'dart:convert';
import 'package:coinsnap/v1/data/model/auth/get_all/coinbase_get_account_model.dart';
import 'package:crypto/crypto.dart';
import 'package:http/http.dart' as http;

import 'dart:developer';

abstract class ICoinbaseGetAccountRepository {
  Future getCoinbaseGetAccount();
}

class CoinbaseGetAccountRepositoryImpl implements ICoinbaseGetAccountRepository {
  @override
  Future<CoinbaseGetAccountModel> getCoinbaseGetAccount() async {
    
    /// ##### Start API Request #####
    
    String _coinbaseUrl = 'api.pro.coinbase.com';
    String requestUrl = 'https://' + _coinbaseUrl + '/accounts';

    /// ##### Temporary API Key load-ins ###### 
    /// ##### TODO: Add Key storage implementation ###### 
  }
}

/// CLEARLY NOT DONE YET
/// DUE TO COINBASE CONNECT OAUTH2