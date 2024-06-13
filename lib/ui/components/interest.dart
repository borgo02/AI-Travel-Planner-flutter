import 'package:ai_travel_planner/assets/CustomColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as slider;
import 'package:flutter_svg/flutter_svg.dart';
import '../../assets/CustomColors.dart';

class InterestComponent extends StatelessWidget {
  final String imageSrc;
  final String labelText;
  final double sliderValue;
  final ValueChanged<double>? onSliderChanged;

  const InterestComponent({super.key,
    required this.imageSrc,
    required this.labelText,
    required this.sliderValue,
    this.onSliderChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.white,
      margin: const EdgeInsets.all(8),
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SvgPicture.asset(
                    imageSrc,
                    height: 30,
                    width: 30,
                  ),
                ),
                Text(
                  labelText,
                  style: const TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            slider.Slider(
              value: sliderValue,
              min: 0.0,
              max: 10.0,
              divisions: 20,
              onChanged: onSliderChanged,
              label: sliderValue.toString(),
              activeColor: CustomColors.darkBlue,
              inactiveColor: CustomColors.lightBlue,
            ),
          ],
        ),
      ),
    );
  }
}