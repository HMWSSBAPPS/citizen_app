library;

import 'package:flutter_dotenv/flutter_dotenv.dart';

class BuildConfig {
  static String baseUrl = "";
  static String pgUrl = "";
  static String pgTxnUrl = "";
  static String filePath = "";
  static String pgUrlAlt = "";

  static loadConfig({bool? isUATEnv}) async {
    if (isUATEnv == false) {
      await dotenv.load(fileName: "assets/.env_uat");
      baseUrl = dotenv.get('baseUrl');
      pgUrl = dotenv.get('pgUrl');
      pgTxnUrl = dotenv.get('pgTxnUrl');
      filePath = 'files/indexUat.html';
      pgUrlAlt = dotenv.get('pgUrl_alt');
    } else {
      await dotenv.load(fileName: "assets/.env_prod");
      baseUrl = dotenv.get('baseUrl');
      pgUrl = dotenv.get('pgUrl');
      pgTxnUrl = dotenv.get('pgTxnUrl');
      filePath = 'files/indexProd.html';
    }
  }
}
