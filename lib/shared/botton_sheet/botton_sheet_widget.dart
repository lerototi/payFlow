import 'package:flutter/material.dart';
import 'package:payflow/shared/themes/app_colors.dart';
import 'package:payflow/shared/themes/app_text_styles.dart';
import 'package:payflow/shared/widgets/set_label_buttons/set_label_buttons.dart';

class BottonSheetWidget extends StatelessWidget {
  
  final String title;
  final String subtitle;
  final String primaryLabel;
  final VoidCallback primaryOnPressed;
  final String secondaryLabel;
  final VoidCallback secondaryOnPressed;
  final bool enablePrimaryColor;
const BottonSheetWidget ({Key? key, 
required this.primaryLabel, 
required this.primaryOnPressed, 
required this.secondaryLabel, 
required this.secondaryOnPressed, 
required this.title, 
required this.subtitle, this.enablePrimaryColor = false}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      bottom: true,
      left: true,
      right: true,
          child: RotatedBox(
        quarterTurns: 1,
            child: Container(
          color: AppColors.shape,
          child: Column(
            children: [
              Expanded(child: Container(color: Colors.black.withOpacity(0.6))),
              Padding(
                          padding: const EdgeInsets.all(40),
                          child: Text.rich(
                  TextSpan(text: title, style: TextStyles.buttonBoldHeading ,children: [TextSpan(text: "\n$subtitle", style: TextStyles.buttonHeading)]),
                   textAlign: TextAlign.center),
              ),
              Container(height: 1, color: AppColors.stroke ),
              SetLabelButtons(
                labelPrimary: primaryLabel, 
                onTapPrimary: primaryOnPressed,
                labelSecondary: secondaryLabel, 
                onTapSecondary: secondaryOnPressed, enablePrimaryColor: true,)
            ],
          ),
          
        ),
      ),
    );
  }
}