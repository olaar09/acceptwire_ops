import 'package:acceptwire/data/podo/app_config_podo.dart';
import 'dart:io';

class MetaDataRepo {
  getMetaData() {
    print('get meta data');
  }

  saveMetaData() {
    print('save meta data');
  }

  fetchMetaData() {
    return AppConfig.fromJson(
        {'paystackPubKey': "oiejnkdml ionekmd inejopfkamsnpneofd"});
  }

  getIsConnected() async {
    try {
      final result = await InternetAddress.lookup('google.com');
      if (result.isNotEmpty && result[0].rawAddress.isNotEmpty) {
        return true;
      }
    } on SocketException catch (_) {
      return false;
    }
  }
}
