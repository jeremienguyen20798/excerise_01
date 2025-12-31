import 'package:excerise_01/core/constant/app_constant.dart';
import 'package:flutter/foundation.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';

class LoadAd {
  void loadBannerAd(Function(BannerAd) onAdLoaded) {
    BannerAd(
      adUnitId: kDebugMode ? admobBannerTest : admobBanner,
      request: const AdRequest(),
      size: AdSize.banner,
      listener: BannerAdListener(
        onAdLoaded: (ad) {
          // Called when an ad is successfully received.
          debugPrint("Ad was loaded.");
          onAdLoaded(ad as BannerAd);
        },
        onAdFailedToLoad: (ad, err) {
          // Called when an ad request failed.
          debugPrint("Ad failed to load with error: $err");
          ad.dispose();
        },
      ),
    ).load();
  }
}
