import 'package:flutter/material.dart';

import 'package:plaid_flutter/plaid_flutter.dart';
import 'package:plaid_page/helpers/loading_dialog.dart';
import 'package:plaid_page/services/plaid_services.dart';

class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  String buttonText = "Click to Link Bank Account";
  bool isLinked = false;

  @override
  void initState() {
    super.initState();

    PlaidLink.onSuccess(_onSuccessCallback);
    PlaidLink.onEvent(_onEventCallback);
    PlaidLink.onExit(_onExitCallback);
  }

  // Called on a successful event
  void _onSuccessCallback(String publicToken, LinkSuccessMetadata metadata) {
    setState(() {
      buttonText =
          "YAY! YOUR LINKED BANK IS ${metadata.institution.name.toUpperCase()}";
      isLinked = true;
    });
    debugPrint("onSuccess: $publicToken, metadata: ${metadata.description()}");
  }

  // Called during each event that happens in the webview
  void _onEventCallback(String event, LinkEventMetadata metadata) {
    debugPrint("onEvent: $event, metadata: ${metadata.description()}");
  }

  // Callback invoked when the authentication process ends without completion
  void _onExitCallback(LinkError? error, LinkExitMetadata metadata) {
    debugPrint("onExit metadata: ${metadata.description()}");

    if (error != null) {
      debugPrint("onExit error: ${error.description()}");
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error processing request, try again later')));
    }
  }

  //Initiates a loding screen, fetches the temporary token and initiates plaid webview
  void _onClickRequestToLink() async {
    final token = PlaidServices.createPlaidToken();
    showDialog(
      context: context,
      builder: (context) => const LoadingDialog(),
    );

    token.then((value) {
      Navigator.pop(context);
      final _linkTokenConfiguration = LinkTokenConfiguration(token: value);
      PlaidLink.open(configuration: _linkTokenConfiguration);
    }, onError: (error, stackTrace) {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Error processing request, try again later')));
    });
  }

  // Called during onPressed event of the button and the account has been already linked
  void _onClickAlreadyLinked() {
    ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Account has been already linked')));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(32.0),
            child: TextButton(
              onPressed:
                  isLinked ? _onClickAlreadyLinked : _onClickRequestToLink,
              child: Text(
                buttonText,
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
