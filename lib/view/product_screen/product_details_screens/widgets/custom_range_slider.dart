import 'package:flutter/material.dart';
import 'package:food_go_app/view/product_screen/product_details_screens/widgets/custom_thumb_shape.dart';
import 'package:food_go_app/view/product_screen/product_details_screens/widgets/custom_track_shape.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({super.key});

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  double _value = 100;
  bool _isDragging = false;

  @override
  Widget build(BuildContext context) {
    const double sliderWidth = 115;
    const double thumbWidth = 16;
    const double labelWidth = 45;

    double effectiveWidth = sliderWidth - thumbWidth;

    double thumbCenterX = (_value / 100) * effectiveWidth + (thumbWidth / 2);

    double labelLeft = thumbCenterX - (labelWidth / 2);

    labelLeft = labelLeft.clamp(0.0, sliderWidth - labelWidth);

    return SizedBox(
      width: sliderWidth,
      height: 30,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          SliderTheme(
            data: SliderTheme.of(context).copyWith(
              activeTrackColor: Color(0xffEF2A39),
              inactiveTrackColor: Color.fromARGB(255, 246, 243, 243),
              trackHeight: 5,
              trackShape: const CustomTrackShape(),
              thumbColor: Color(0xffEF2A39),
              thumbShape: CustomThumbShape(),
              tickMarkShape: SliderTickMarkShape.noTickMark,
              overlayShape: SliderComponentShape.noOverlay,
            ),
            child: Slider(
              value: _value,
              min: 1,
              max: 100,
              divisions: 100,
              onChangeStart: (_) {
                setState(() {
                  _isDragging = true;
                });
              },
              onChanged: (val) {
                setState(() {
                  _value = val;
                });
              },
              onChangeEnd: (_) {
                setState(() {
                  _isDragging = false;
                });
              },
            ),
          ),
          if (_isDragging)
            Positioned(
              left: labelLeft,
              top: -35,
              child: Container(
                width: labelWidth,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: Color(0xffEF2A39),
                  borderRadius: BorderRadius.circular(8),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Text(
                  _value.toInt().toString(),
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: "",
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
