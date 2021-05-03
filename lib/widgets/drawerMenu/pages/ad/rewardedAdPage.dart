import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:loading_animations/loading_animations.dart';
import 'package:provider/provider.dart';
import 'package:synword/admob/adState.dart';
import 'package:sizer/sizer.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:synword/googleAuth/googleAuthService.dart';
import 'package:synword/userData/currentUser.dart';
import 'package:synword/widgets/drawerMenu/pages/ad/rewardedAdPageState.dart';
import 'package:synword/monetization/purchase.dart';

class RewardedAdPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RewardedAdPageState();
}

class _RewardedAdPageState extends State<RewardedAdPage> {
  RewardedAd? _rewardedAd;
  RewardedAdPageState _pageState = RewardedAdPageState.loading;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdState>(context);
    adState.initialization.then((status) {
      createRewardedAd();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        toolbarHeight: 16.0.h,
        title: SvgPicture.asset('icons/coins.svg',
            height: 15.5.h,
            width: 15.5.w),
        backgroundColor: Colors.black,
        centerTitle: true,
      ),
      body: Container(
          margin: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(15)),
            color: Colors.white,
          ),
          child: getWidget(),
      ),
    );
  }

  @override
  void dispose() {
    _rewardedAd?.dispose();
    super.dispose();
  }

  Widget getWidget(){
    switch(_pageState){
      case RewardedAdPageState.success:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.check_circle, size: 20.0.h, color: Colors.lightGreen,),
              SizedBox(
                height: 5.0.h,
              ),
              Text('successPageRewardTitle'.tr(namedArgs: {'coin_count': '3'}), style: TextStyle(fontSize: 13.0.sp, fontFamily: 'Roboto'),),
              SizedBox(
                height: 5.0.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _pageState = RewardedAdPageState.loading;
                      createRewardedAd();
                    });
                  },
                  child: Text('tryAgain'.tr(), style: TextStyle(fontSize: 13.0.sp, fontFamily: 'Roboto'),),
              )
            ],
          ),
        );
      case RewardedAdPageState.loading:
        return Center(
          child: LoadingBouncingGrid.square(size: 70),
        );
      default:
        return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                color: Colors.red,
                size: 20.0.h,
              ),
              SizedBox(
                height: 1.0.h,
              ),
              Text(
                'alertDialogError'.tr(),
                style: TextStyle(fontSize: 15.0.sp, fontFamily: 'Roboto',),
              ),
              SizedBox(
                height: 7.0.h,
              ),
              ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _pageState = RewardedAdPageState.loading;
                      createRewardedAd();
                    });
                  },
                  child: Text('tryAgain'.tr(), style: TextStyle(fontSize: 13.0.sp, fontFamily: 'Roboto')),
              )
            ],
          ),
        );
    }
  }

  void createRewardedAd() {
    _rewardedAd = RewardedAd(
      adUnitId: RewardedAd.testAdUnitId,
      request: AdRequest(),
      listener: AdListener(
          onAdLoaded: (Ad ad) {
            print('${ad.runtimeType} loaded.');
            _rewardedAd!.show();
          },
          onAdFailedToLoad: (Ad ad, LoadAdError error) {
            print('${ad.runtimeType} failed to load: $error');
            ad.dispose();
            _rewardedAd = null;
            setState(() {
              _pageState = RewardedAdPageState.fail;
            });
          },
          onAdOpened: (Ad ad) => print('${ad.runtimeType} onAdOpened.'),
          onAdClosed: (Ad ad) {
            print('${ad.runtimeType} closed.');
            ad.dispose();
            if(_pageState != RewardedAdPageState.success){
              setState(() {
                _pageState = RewardedAdPageState.fail;
              });
            }
            CurrentUser.serverRequest.authorization();
          },
          onApplicationExit: (Ad ad) =>
              print('${ad.runtimeType} onApplicationExit.'),
          onRewardedAdUserEarnedReward: (RewardedAd ad, RewardItem reward) {
            print(
              '$RewardedAd with reward $RewardItem(${reward.amount}, ${reward.type})',
            );
            setState(() {
              _pageState = RewardedAdPageState.success;
            });
          }),
      serverSideVerificationOptions: ServerSideVerificationOptions(
        userId: GoogleAuthService.googleUser!.id
      ),
    )..load();
  }
}
