import 'package:flutter/Material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class UserTile extends StatelessWidget {
  final String title;
  final void Function()? onTap;
  const UserTile({super.key, required this.title, this.onTap});

  @override
  Widget build(BuildContext context) {
    final isDarkTheme = Theme.of(context).brightness == Brightness.dark;
    final adaptiveColor = isDarkTheme ? Colors.white : Colors.black;
    final adaptiveTextColorButton = isDarkTheme ? Colors.black : Colors.white;

    return  Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          GestureDetector(
            onTap: onTap,
            child: Container(
              height: 50.h,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: adaptiveColor
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                     Icon(Icons.person,
                        color: adaptiveTextColorButton

                    ),
                    Text(
                      title,
                      style:  TextStyle(fontSize: 18.sp,
                      color: adaptiveTextColorButton
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
           SizedBox(height: 8.h,),
        ],
      ),
    );
  }
}
