import 'dart:io';

class Envaironment {
  static String apiUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http//localhost:3000';
  static String socketUrl =
      Platform.isAndroid ? 'http://10.0.2.2:3000' : 'http://localhost:3000';
}
