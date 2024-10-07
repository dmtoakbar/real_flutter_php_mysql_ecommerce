import 'package:ecom/app/user/authentication/redirect_screen.dart';
import 'package:ecom/share/constants/image_string.dart';
import 'package:ecom/share/constants/sizes.dart';
import 'package:ecom/share/constants/text_string.dart';
import 'package:ecom/share/intro/widget/intro_page_view_item.dart';
import 'package:ecom/share/intro/widget/intro_page_view_pointer_indicator.dart';
import 'package:ecom/share/route/route_names.dart';
import 'package:ecom/share/route/routes.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({super.key});

  @override
  State<IntroScreen> createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  PageController controller = PageController();
  int pageIndex = 0;

  Future<void> _sharedPreferencesStore () async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool("isIntroShown", true);
  }


  @override
  void initState() {
    RedirectScreen.nativeSplashRemove();
    RedirectScreen.checkUserStatus();
    super.initState();
  }


  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: SingleChildScrollView(
        child: SizedBox(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: Stack(
              children: <Widget>[
                PageView(
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  controller: controller,
                  children: const [
                    IntroPageViewItem(
                      image: TImages.intro1,
                      title: TText.introTitle1,
                      subTitle: TText.introSubTitle1,
                    ),
                    IntroPageViewItem(
                      image: TImages.intro2,
                      title: TText.introTitle2,
                      subTitle: TText.introSubTitle2,
                    ),
                    IntroPageViewItem(
                      image: TImages.intro3,
                      title: TText.introTitle3,
                      subTitle: TText.introSubTitle3,
                    ),
                  ],
                ),
                Positioned(
                    bottom: 16.0,
                    left: 0,
                    right: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              PageViewPointIndicator(
                                pageIndex: pageIndex,
                                pageNo: 0,
                              ),
                              PageViewPointIndicator(
                                pageIndex: pageIndex,
                                pageNo: 1,
                              ),
                              PageViewPointIndicator(
                                pageIndex: pageIndex,
                                pageNo: 2,
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: TSizes.spaceBtwSections,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Opacity(
                                opacity: pageIndex != 2 ? 1 : 0,
                                child: MaterialButton(
                                  splashColor: Colors.transparent,
                                  child: Text(
                                    'Skip',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .apply(
                                          color: Colors.black,
                                        ),
                                  ),
                                  onPressed: ()  {
                                    _sharedPreferencesStore();
                                   CustomRoute.launchReplace(context, TRouteNames.login);
                                  },
                                ),
                              ),
                              pageIndex != 2
                                  ? MaterialButton(
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        'Next',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .apply(
                                              color: Colors.black,
                                            ),
                                      ),
                                      onPressed: () {
                                        if(!(controller.page==2.0)) {
                                          controller.nextPage(
                                              duration: const Duration(milliseconds: 200),
                                              curve: Curves.linear
                                          );
                                        }
                                      },
                                    )
                                  : MaterialButton(
                                      splashColor: Colors.transparent,
                                      child: Text(
                                        'Finish',
                                        style: Theme.of(context)
                                            .textTheme
                                            .titleMedium!
                                            .apply(
                                              color: Colors.black,
                                            ),
                                      ),
                                      onPressed: () {
                                        _sharedPreferencesStore();
                                        CustomRoute.replace(context, TRouteNames.login);
                                      },
                                    ),
                            ],
                          )
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
