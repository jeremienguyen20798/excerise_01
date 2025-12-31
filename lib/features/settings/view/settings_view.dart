import 'package:easy_localization/easy_localization.dart';
import 'package:excerise_01/core/ad/load_ad.dart';
import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:excerise_01/features/settings/bloc/settings_bloc.dart';
import 'package:excerise_01/features/settings/bloc/settings_event.dart';
import 'package:excerise_01/features/settings/bloc/settings_state.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:expandable/expandable.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({super.key});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  BannerAd? _bannerAd;
  final LoadAd _loadAd = LoadAd();

  @override
  void initState() {
    _loadBannerAd();
    super.initState();
  }

  @override
  void dispose() {
    _bannerAd?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        String appVersion = '';
        Locale currentLocale = context.locale;
        if (state is LoadAppVersionState) {
          currentLocale = context.locale;
          if (kDebugMode) {
            appVersion = '${state.appVersion} (${state.buildNumber})';
          } else {
            appVersion = state.appVersion;
          }
        } else if (state is SelectedLanguageState) {
          context.setLocale(state.selectedLocaled);
          currentLocale = state.selectedLocaled;
        }
        return Scaffold(
          backgroundColor: Colors.white,
          appBar: AppBar(
            centerTitle: true,
            backgroundColor: Colors.white,
            title: Text(
              'settings'.tr(),
              style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: [
              ExpandablePanel(
                theme: ExpandableThemeData(tapHeaderToExpand: true),
                header: ListTile(
                  title: Text('changeLanguage'.tr()),
                  leading: Icon(Icons.language, color: Colors.black),
                ),
                collapsed: SizedBox(),
                expanded: Column(
                  children: [
                    ListTile(
                      minLeadingWidth: 24.0,
                      leading: SvgPicture.asset(
                        'assets/images/flag_of_vietnam.svg',
                        width: 20.0,
                        height: 20.0,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        'Tiếng Việt',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: currentLocale == Locale('vi', 'VN')
                          ? Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        BlocProvider.of<SettingsBloc>(
                          context,
                        ).add(SelectedLanguageEvent(Locale('vi', 'VN')));
                      },
                    ),
                    ListTile(
                      minLeadingWidth: 24.0,
                      leading: SvgPicture.asset(
                        'assets/images/flag_of_the_united_states.svg',
                        width: 16.0,
                        height: 16.0,
                        fit: BoxFit.cover,
                      ),
                      title: Text(
                        'English',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      trailing: currentLocale == Locale('en', 'US')
                          ? Icon(Icons.check, color: Colors.blue)
                          : null,
                      onTap: () {
                        BlocProvider.of<SettingsBloc>(
                          context,
                        ).add(SelectedLanguageEvent(Locale('en', 'US')));
                      },
                    ),
                  ],
                ),
              ),
              ListTile(
                onTap: () async {
                  if (!await launchUrl(Uri.parse(privacyPolicy))) {
                    throw Exception('Could not launch $privacyPolicy');
                  }
                },
                title: Text('privacyPolicy'.tr()),
                leading: Icon(Icons.security_outlined, color: Colors.black),
              ),
              ListTile(
                onTap: () async {
                  if (!await launchUrl(Uri.parse(buyMeACoffee))) {
                    throw Exception('Could not launch $buyMeACoffee');
                  }
                },
                title: Text(
                  'Buy Me a Coffee',
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                leading: Image.asset(
                  'assets/images/buy_me_a_coffee_icon.png',
                  width: 28.0,
                  height: 28.0,
                  fit: BoxFit.contain,
                ),
              ),
              ListTile(
                title: Text(
                  '${'appVersion'.tr()}: $appVersion',
                  style: TextStyle(fontSize: 15.0, color: Colors.black),
                ),
              ),
              Spacer(),
              _bannerAd != null
                  ? Container(
                      alignment: Alignment.center,
                      width: double.infinity,
                      height: _bannerAd!.size.height.toDouble(),
                      child: AdWidget(ad: _bannerAd!),
                    )
                  : SizedBox(),
            ],
          ),
        );
      },
    );
  }

  void _loadBannerAd() async {
    _loadAd.loadBannerAd((bannerAd) {
      setState(() {
        _bannerAd = bannerAd;
      });
    });
  }
}
