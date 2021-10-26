@JS()
library myalgo;

import 'package:js/js.dart';

/// MyAlgo instance.
@JS('MyAlgoConnect')
class MyAlgoConnect {
  @JS('connect')
  external List connect();
}
