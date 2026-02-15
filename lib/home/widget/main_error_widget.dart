import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/app_styles.dart';

class MainErrorWidget extends StatelessWidget {
  final String errorMessage;
  final VoidCallback onPressed;
   MainErrorWidget({super.key, required this.errorMessage , required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 10,
      children: [
        Text(errorMessage,style: Theme.of(context).textTheme.labelLarge,),
        ElevatedButton(onPressed:  onPressed,
          child:  Text('Try Again',style: AppStyles.medium14Black,), )
      ],
    );
  }
}
