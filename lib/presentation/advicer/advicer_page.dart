import 'package:advice_app/presentation/advicer/widgets/custom_button.dart';
import 'package:advice_app/presentation/advicer/widgets/error_message.dart';
import 'package:flutter/material.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final ThemeData themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          "Advicer",
          style: themeData.textTheme.displayMedium,
        ),
      ),
      body: Center(
          child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Column(
          children: [
            const Expanded(
                child: Center(
              child: /* Text(
                "Your Advice is waiting for you...",
                style: themeData.textTheme.displayMedium,
              ), */
                  //     AdviceField(
                  //   advice:
                  //       "Testing!djsoahdoiashdioashdioashd asijdoashduoh duoas hdudh8 zhasui dhzas8od sahoida soipdasoidsa h8osa hd8aso hjd oihd oidhasuoid aoia soiadh coiad a sa hoi asiod ij",
                  // ),
                  ErrorMessage(),
            )),
            SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(
                  onPressed: () {},
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
