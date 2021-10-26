import 'dart:async';

import 'package:js/js.dart';
import 'package:js/js_util.dart';
import 'package:myalgo_example/interop/convert_interop.dart';
import 'package:myalgo_example/myalgo_exception.dart';

import 'interop/myalgo_interop.dart';

/// MyAlgo is an Algorand Wallet allowing you to freely interact with the
/// Algorand blockchain.
///
/// MyAlgo provides the simplest and most secure way to send and receive Algos
/// and tokens, organize and track all your Algorand wallets, manage your
/// assets and much more.
///
/// MyAlgo Connect allows WebApp users to review and sign Algorand transactions
/// using accounts secured within their MyAlgo Wallet.
/// This enables Algorand applications to use MyAlgo Wallet to interact with
/// the Algorand blockchain and users to access the applications in a private
/// and secure manner.
///
/// The integration with MyAlgo Wallet allows users secure access to
/// Algorand DApps. Users only need to share their public addresses with the
/// WebApp and this in turn allows them to review and sign all types of
/// transactions without exposing their private keys.
///
/// The main novelty of MyAlgo Connect lies in the fact that all the process is
/// managed in the user’s browser without the need for any backend service nor
/// downloads, extensions or browser plugins.
class MyAlgoPlugin {
  final MyAlgoConnect myAlgo;

  MyAlgoPlugin({required this.myAlgo});

  /// Requests access to the Wallet for the dApp, may be rejected or approved.
  /// Every access to the extension begins with a connect request, which if
  /// approved by the user, allows the dApp to follow-up with other requests.
  Future<List<String>> connect() async {
    var c = Completer<List<String>>();
    promiseToFuture(myAlgo.connect()).then(allowInterop((value) {
      if (value is! List) {
        return c.complete([]);
      }

      final addresses = value.map((address) {
        return getProperty(address, 'address') as String;
      }).toList();

      return c.complete(addresses);
    })).onError((error, stackTrace) => c.completeError(_handleError(error)));

    return c.future;
  }

  MyAlgoException _handleError(dynamic error) {
    print(error.runtimeType);
    print(convert(error));
    final message = error is String ? error : convert(error)['message'] ?? '';
    return MyAlgoException(message, error);
  }
}
