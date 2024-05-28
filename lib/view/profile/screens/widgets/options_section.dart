import 'package:flutter/material.dart';
import 'package:time_status/core/app_export.dart';

class OptionsSection extends StatelessWidget {
  const OptionsSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(
          height: 70,
          child: Row(
            children: [
              Container(
                width: 150,
                height: 35,
                decoration: const ShapeDecoration(
                  gradient:
                      LinearGradient(colors: [AppColor.appgreen, Colors.white]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: TextButton(
                  onPressed: () async {},
                  child: const Text(
                    'logout',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
              const SizedBox(
                width: 30,
              ),
              Container(
                height: 35,
                decoration: const ShapeDecoration(
                  gradient:
                      LinearGradient(colors: [AppColor.appgreen, Colors.white]),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                ),
                child: TextButton(
                  onPressed: () {},
                  child: const Text(
                    'Edit Profile',
                    style: TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 14.0),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
