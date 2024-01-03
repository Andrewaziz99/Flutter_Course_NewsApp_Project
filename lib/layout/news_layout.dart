import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/cubit/cubit.dart';
import 'package:newsapp/modules/search/search_screen.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';


class NewsLayout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => NewsCubit()..getBusinessNews()..getSportsNews()..getScienceNews(),
      child: BlocBuilder<NewsCubit, NewsStates>(
        builder: (context, state)
        {
          var cubit = NewsCubit.get(context);

          return Scaffold(
            appBar: AppBar(
              title: const Text('A5bary'),
              actions: [
                IconButton(
                  onPressed: ()
                  {
                    navigateTo(context, SearchScreen());
                  },
                  icon: const Icon(
                    Icons.search,
                  ),
                ),
                IconButton(
                  onPressed: ()
                  {
                    AppCubit.get(context).changeAppMode();
                  },
                  icon: const Icon(
                    Icons.brightness_4_outlined,
                  ),
                ),
              ],
            ),
            bottomNavigationBar: BottomNavigationBar(
              currentIndex: cubit.currentIndex,
              items: cubit.bottomItems,
              onTap: (index) {
                cubit.changeBottomNavBar(index);
              },
            ),
            body: cubit.screens[cubit.currentIndex],
          );
        },
      ),
    );
  }
}
