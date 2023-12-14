import 'package:alquran/global.dart';
import 'package:alquran/helper/dotted_loading_indicator.dart';
import 'package:alquran/widgets/app_card.dart';
import 'package:flutter/material.dart';

class AppLoading extends StatelessWidget {
  const AppLoading({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppCard(
        hMargin: MediaQuery.of(context).size.width / 4,
        vPadding: 30,
        color: Theme.of(context).cardColor,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(100),
              child: DottedCircularProgressIndicatorFb(
                defaultDotColor: primary.withOpacity(0.7),
                currentDotColor: primary.withOpacity(0.3),
                numDots: 9,
                dotSize: 5,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              "menunggu..",
              style: AppTextStyle.small,
            )
          ],
        ),
      ),
    );
  }
}
