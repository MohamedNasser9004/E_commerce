import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../core/controllers/profile_cubit/profile_cubit.dart';
import '../../core/controllers/profile_cubit/profile_state.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProfileCubit,ProfileStates>(
        listener:(context,state){},
        builder:(context,state){
          var cubit = ProfileCubit.get(context);
          return Scaffold(
            appBar:  AppBar(
              title:const Text('User Profile'),
            ),
            body: Column(
              children: [
                Container(
                  color: Colors.yellow,
                  height: 50,
                  width: double.infinity,
                  child:Row(
                    children: [
                      Text('Name'),
                      Spacer(),
                      Text(cubit.profileModel!.user!.name!)
                    ],
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  width: double.infinity,
                  child:CircleAvatar(
                    radius: 40,
                    backgroundImage: NetworkImage(cubit.profileModel!.user!.profileImage!,),
                  ),
                ),
                Container(
                  color: Colors.yellow,
                  height: 50,
                  width: double.infinity,
                  child:Row(
                    children: [
                      Text('Email'),
                      Spacer(),
                      Text(cubit.profileModel!.user!.email!)
                    ],
                  ),
                )
              ],
            ),
          );
        });
  }
}