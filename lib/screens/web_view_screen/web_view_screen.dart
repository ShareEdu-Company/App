import 'dart:collection';
import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:almaraqischool/data/web_services/auth_services.dart';
import 'package:almaraqischool/screens/login/login_provider.dart';
import 'package:almaraqischool/screens/starting/starting_screen.dart';
import 'package:almaraqischool/shared/app_bar_widget.dart';
import 'package:almaraqischool/shared/dialogs.dart';
import 'package:almaraqischool/utils/constants/syles.dart';
import 'package:almaraqischool/utils/translations/locale_keys.g.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../utils/helper/language_code.dart';

class WebViewScreen extends StatefulWidget {
  static const String routeName = "/web-view";
  final String pageUrl;
  final String title;
  final bool isGuestPage;
  const WebViewScreen({
    super.key,
    required this.pageUrl,
    required this.title,
    this.isGuestPage = false,
  });

  @override
  WebViewScreenState createState() => WebViewScreenState();
}

class WebViewScreenState extends State<WebViewScreen> {
  late PullToRefreshController pullToRefreshController;
  InAppWebViewController? webViewController;
  bool loading = true;

  InAppWebViewGroupOptions options = InAppWebViewGroupOptions(
    crossPlatform: InAppWebViewOptions(
      useShouldOverrideUrlLoading: true,
      mediaPlaybackRequiresUserGesture: false,
    ),
    android: AndroidInAppWebViewOptions(useHybridComposition: true),
    ios: IOSInAppWebViewOptions(allowsInlineMediaPlayback: true),
  );
  @override
  void initState() {
    super.initState();
    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: AppStyles.primaryColor,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
            urlRequest: URLRequest(
              url: await webViewController?.getUrl(),
            ),
          );
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        if (webViewController != null) {
          if (await webViewController!.canGoBack()) {
            await webViewController!.goBack();
          } else {
            if (widget.isGuestPage) {
              Navigator.of(context).pop();
            } else {
              showConfirmationDialog(
                context,
                title: LocaleKeys.exitHint.tr(),
                subtitle1: "",
                onYesPressed: () {
                  Navigator.of(context).pop();
                  if (Platform.isAndroid) {
                    SystemNavigator.pop();
                  } else {
                    exit(0);
                  }
                },
              );
            }
          }
        }
        return false;
      },
      child: Scaffold(
        appBar: AppBarWidget(
          title: widget.title,
          hasBackButton: widget.isGuestPage,
          hasTrackingButton: !widget.isGuestPage,
          hasLang: !widget.isGuestPage,
        ),
        body: SafeArea(
          child: InAppWebView(
            initialUrlRequest: URLRequest(
              url: Uri.parse(
                "${widget.pageUrl}&UserLang=${LanguageHelper.getLanguageCode(context)}",
              ),
            ),
            initialUserScripts: UnmodifiableListView<UserScript>([]),
            initialOptions: options,
            pullToRefreshController: pullToRefreshController,
            onWebViewCreated: (controller) {
              webViewController = controller;
            },
            androidOnPermissionRequest: (controller, origin, resources) async {
              return PermissionRequestResponse(
                resources: resources,
                action: PermissionRequestResponseAction.GRANT,
              );
            },
            shouldOverrideUrlLoading: (controller, navigationAction) async {
              var uri = navigationAction.request.url!;
              // if ([
              //   'us05web.zoom.us',
              //   'chat.whatsapp.com',
              //   'www.youtube.com',
              //   'docs.google.com',
              //   'drive.google.com',
              //   't.me',
              //   'www.instagram.com',
              //   'twitter.com',
              //   'www.facebook.com',
              // ].contains(uri.host))
              if (uri.pathSegments.first == "DownloadFiles") {
                openLink(navigationAction.request.url!);
                return NavigationActionPolicy.CANCEL;
              } else if (uri.host == "almaraqi-schools.com") {
                return NavigationActionPolicy.ALLOW;
              } else {
                openLink(navigationAction.request.url!);
                return NavigationActionPolicy.CANCEL;
              }
            },
          ),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.all(6),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: () => _doAction(0, null),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/images/back.svg",
                    ),
                    const SizedBox(height: 3),
                    Text(
                      LocaleKeys.back.tr(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              InkWell(
                onTap: () => _doAction(1, null),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SvgPicture.asset(
                      "assets/images/home.svg",
                    ),
                    const SizedBox(height: 3),
                    Text(
                      LocaleKeys.main.tr(),
                      style: const TextStyle(fontSize: 12),
                    ),
                  ],
                ),
              ),
              Consumer(builder: (context, ref, _) {
                return InkWell(
                  onTap: () => _doAction(2, ref),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      widget.isGuestPage
                          ? const Icon(
                              Icons.login_rounded,
                              color: Color.fromARGB(255, 120, 120, 120),
                              size: 28,
                            )
                          : const Icon(
                              Icons.logout_rounded,
                              color: Color.fromARGB(255, 120, 120, 120),
                              size: 28,
                            ),
                      const SizedBox(height: 3),
                      Text(
                        widget.isGuestPage
                            ? LocaleKeys.login.tr()
                            : LocaleKeys.logout.tr(),
                        style: const TextStyle(fontSize: 12),
                      ),
                    ],
                  ),
                );
              }),
            ],
          ),
        ),
      ),
    );
  }

  void _doAction(int index, WidgetRef? ref) async {
    switch (index) {
      case 2:
        if (widget.isGuestPage) {
          Navigator.of(context).pushNamedAndRemoveUntil(
            StartingScreen.routeName,
            (route) => false,
          );
        } else {
          ref!.invalidate(userTypeProvider);
          showConfirmationDialog(
            context,
            title: LocaleKeys.logout.tr(),
            subtitle1: LocaleKeys.logoutHint.tr(),
            onYesPressed: () => AuthServices.logout(context),
          );
        }
        break;
      case 1:
        if (widget.isGuestPage) {
          Navigator.of(context).pop();
        } else {
          webViewController!.loadUrl(
            urlRequest: URLRequest(url: Uri.parse(widget.pageUrl)),
          );
        }
        break;
      case 0:
        if (await webViewController!.canGoBack()) {
          webViewController!.goBack();
        } else {
          if (widget.isGuestPage) {
            Navigator.of(context).pop();
          } else {
            showConfirmationDialog(
              context,
              title: LocaleKeys.exitHint.tr(),
              subtitle1: "",
              onYesPressed: () {
                Navigator.of(context).pop();
                if (Platform.isAndroid) {
                  SystemNavigator.pop();
                } else {
                  exit(0);
                }
              },
            );
          }
        }
        break;
    }
  }

  Future<void> openLink(Uri link) async {
    if (!await launchUrl(
      link,
      mode: LaunchMode.externalNonBrowserApplication,
    )) {
      await launchUrl(link);
    }
  }
}
