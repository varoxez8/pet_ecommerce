
import 'package:i18n_extension/i18n_extension.dart';

extension Localization on String {

  static var _t = Translations("ar")

      + {
        "ar":"الزوايا السابقة",
        "en": "previous corners",
      }





  ;

  String get i18n => localize(this, _t);
}
