import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import '../../facilities/adding_space.dart';
import '../../facilities/size_configuration.dart';
import 'loader_effect_part.dart';

Widget loading() {
  Color color = Colors.grey;
  return Shimmer(
    color: Colors.white,
    colorOpacity: 0.5,
    enabled: true,
    direction: const ShimmerDirection.fromLTRB(),
    child: SizedBox(
      height: SizeConfigure.heightConfig! * 60, // card height
      child: PageView.builder(
        itemCount: 2,
        controller: PageController(viewportFraction: 0.6),
        itemBuilder: (_, i) {
          return Transform.scale(
              scale: (0 == i) ? 1.0 : .9,
              child: Card(
                  elevation: 10,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  child: Center(
                      child: Padding(
                    padding: EdgeInsets.all(SizeConfigure.widthConfig! * 2),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        addVerticalSpace(SizeConfigure.heightConfig! * 2),
                        loaderPart(50, 30, color),
                        addVerticalSpace(SizeConfigure.heightConfig! * 2),
                        loaderPart(16, 30, color),
                        addVerticalSpace(SizeConfigure.heightConfig! * 1),
                      ],
                    ),
                  ))));
        },
      ),
    ),
  );
}
