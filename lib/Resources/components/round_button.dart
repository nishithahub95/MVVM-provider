import 'package:flutter/material.dart';
import 'package:provider_mvvm/Resources/colors.dart';

class RoundButton extends StatelessWidget {
  final String title;
  final bool loading;
  final VoidCallback onPress;
  RoundButton({Key? key,required this.title,this.loading=false,required this.onPress}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPress,
      child: Container(
        height: 40,
        width: 160,
        decoration: BoxDecoration(
          color: AppColors.buttonColor,
          borderRadius: BorderRadius.circular(20)
        ),
        child: Center(
            child: loading ? CircularProgressIndicator(color: Colors.white,) :
            Text(title,style: TextStyle(color: AppColors.whiteColor),)),

      ),
    );
  }
}
