import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../global/global.dart';
import '../splash.dart';

class SplashView extends StatelessWidget {
  const SplashView({super.key});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: Center(
        child: BlocBuilder<SplashBloc, SplashState>(
          builder: (context, state) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.ac_unit,
                  size: height * 0.1,
                  color: Theme.of(context).colorScheme.primary,
                ),
                Padding(padding: EdgeInsets.only(top: height * 0.05)),
                CustomLoading(
                  key: const Key('splash_loading'),
                  onTimeout: () {
                    context.read<SplashBloc>().add(const SplashFinished());
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
