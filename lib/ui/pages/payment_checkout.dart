import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';
import 'package:windfall/ui/pages/order_confirmation.dart';
import '../../core/constants/named_routes.dart';
import '../../core/data/view_models/payment_vms/payment_vm.dart';
import '../../core/utilities/navigator.dart';
import '../widgets/app_loader.dart';
import '../widgets/custom_appbar.dart';

class PaymentCheckout extends ConsumerStatefulWidget {
  const PaymentCheckout({super.key});

  @override
  ConsumerState<PaymentCheckout> createState() =>
      _PaymentCheckoutState();
}

class _PaymentCheckoutState extends ConsumerState<PaymentCheckout> {
  late final WebViewController _controller;
  bool isLoading = false;

  @override
  void initState() {
    initControllerDynamics(vm: ref.read(paymentViewModel));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: customAppBar(
          context: context,
          title: 'Payment',
          // actions: [
          //   const HomeIcon()
          // ]
      ),
      body: isLoading ? const Center(
        child: AppLoader(),
      ):WebViewWidget(
        controller: _controller,
      ),
    );
  }

  initControllerDynamics({required PaymentVm vm}) {
    // #docregion platform_features
    late final PlatformWebViewControllerCreationParams params;
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
    } else {
      params = const PlatformWebViewControllerCreationParams();
    }

    final WebViewController controller =
    WebViewController.fromPlatformCreationParams(params);
    // #enddocregion platform_features

    controller
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setBackgroundColor(Colors.white)
      ..setNavigationDelegate(
        NavigationDelegate(
          onProgress: (int progress) {},
          onPageStarted: (String url) {},
          onPageFinished: (String url) {
          },
          onWebResourceError: (WebResourceError error) {},
          onNavigationRequest: (NavigationRequest request) {
            debugPrint('allowing navigation to ${request.url}');
            return NavigationDecision.navigate;
          },
          onUrlChange: (UrlChange change) {
            if(change.url != null){
              if(change.url!.contains(vm.callbackUrl)){
                setState(() {
                  isLoading = true;
                });
                return;
              }
              if(change.url!.contains(vm.successRedirectUrl)){
                if(mounted){
                  setState(() {
                    isLoading = false;
                  });
                  //nav user to order confirmed screen
                  pushAndClearNavigation(context: context, widget: const OrderConfirmation(paymentSuccessful: true), clearRoute: NamedRoutes.bottomNav, routeName: NamedRoutes.orderConfirmation);
                }
                return;
              }

              if(change.url!.contains(vm.failureRedirectUrl)){
                if(mounted){
                  setState(() {
                    isLoading = false;
                  });
                  //nav user to order/payment failed screen
                  replaceNavigation(context: context, widget: const OrderConfirmation(paymentSuccessful: false), routeName: NamedRoutes.orderConfirmation);

                }
                return;
              }
            }
          },
        ),
      )
      // ..addJavaScriptChannel('',
      //     onMessageReceived: (JavaScriptMessage message) {
      //
      //     })
      ..loadRequest(
          Uri.parse(vm.authUrl));

    // #docregion platform_features
    if (controller.platform is AndroidWebViewController) {
      AndroidWebViewController.enableDebugging(true);
      (controller.platform as AndroidWebViewController)
          .setMediaPlaybackRequiresUserGesture(false);
    }
    // #enddocregion platform_features

    _controller = controller;
  }

}
