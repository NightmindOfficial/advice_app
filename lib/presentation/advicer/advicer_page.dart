import 'package:advice_app/application/advicer/advicer_bloc.dart';
import 'package:advice_app/presentation/advicer/widgets/advice_field.dart';
import 'package:advice_app/presentation/advicer/widgets/custom_button.dart';
import 'package:advice_app/presentation/advicer/widgets/error_message.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AdvicerPage extends StatelessWidget {
  const AdvicerPage({super.key});

  @override
  Widget build(BuildContext context) {
    final AdvicerBloc advicerBloc = AdvicerBloc();
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
            Expanded(
                child: Center(
              child: BlocBuilder<AdvicerBloc, AdvicerState>(
                bloc: advicerBloc,
                builder: (context, adviceState) {
                  if (adviceState is AdvicerInitial) {
                    return Text(
                      "Your Advice is waiting for you...",
                      style: themeData.textTheme.displayMedium,
                    );
                  } else if (adviceState is AdvicerLoading) {
                    return CircularProgressIndicator(
                      color: themeData.colorScheme.secondary,
                    );
                  } else if (adviceState is AdvicerLoaded) {
                    return AdviceField(
                      advice: adviceState.advice,
                    );
                  } else if (adviceState is AdvicerError) {
                    return const ErrorMessage();
                  }
                  return const ErrorMessage();
                },
              ),
            )),
            SizedBox(
              height: 200,
              child: Center(
                child: CustomButton(
                  onPressed: () {
                    advicerBloc.add(AdviceRequestedEvent());
                  },
                ),
              ),
            )
          ],
        ),
      )),
    );
  }
}
