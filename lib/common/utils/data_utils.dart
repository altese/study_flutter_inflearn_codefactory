import 'dart:convert';

import 'package:inflearn_code_factory/common/const/data.dart';

class DataUtils {
  static String pathToUrl(String value) {
    return 'http://$ip$value';
  }

  // url을 리스트로 받았을 때
  static List<String> listPathsToUrls(List paths) {
    return paths.map((e) => pathToUrl(e)).toList();
  }

  // plain 텍스트를 Base64로 인코딩
  static String plainToBase64(String plain) {
    Codec<String, String> stringToBase64 = utf8.fuse(base64);
    String encoded = stringToBase64.encode(plain);

    return encoded;
  }
}
