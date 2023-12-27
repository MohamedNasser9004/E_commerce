import 'package:ecommercr_app/screens/widgets/botton.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/controllers/onboarding_cubit/onboarding_cubit.dart';
import '../../core/controllers/onboarding_states.dart';
import '../../core/managers/lists.dart';
import '../widgets/build_onboarding_item.dart';

class OnBoardingScreen extends StatelessWidget {
  const OnBoardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<OnBoardingCubit, OnboardingStates>(
      listener: (context, state) {},
      builder: (context, state) {
        var boardingController = PageController();
        var cubit = OnBoardingCubit.get(context);
        return Scaffold(
          body: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text(
                'Pixel',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              ),
              const SizedBox(
                height: 30,
              ),
              Container(
                height: 450,
                child: PageView.builder(
                  onPageChanged: (index) {
                    if (index == onboarding.length - 1) {
                      cubit.pageLast(index);
                    } else {
                      cubit.pageNotLast(index);
                    }
                  },
                  itemBuilder: (context, index) =>
                      buildOnBoardingItem(onboarding[index]),
                  controller: boardingController,
                  physics: const BouncingScrollPhysics(),
                  itemCount: onboarding.length,
                ),
              ),
              const SizedBox(height: 10),
              cubit.isPageLast
                  ? Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DefaultButton(
                          backgroundColor: Colors.black,
                          buttonWidget: const Text('Get Started',style: TextStyle(color: Colors.white),),
                          function: () {
                            cubit.submit(context);
                          }),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: DefaultButton(
                          backgroundColor: Colors.black,
                          buttonWidget: const Text('Next',style: TextStyle(color: Colors.white)),
                          function: () {
                            boardingController.nextPage(
                                duration: const Duration(milliseconds: 750),
                                curve: Curves.fastLinearToSlowEaseIn);
                          }),
                    )
            ],
          ),
        );
      },
    );
  }
}
