import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/modules/business/business_screen.dart';
import 'package:newsapp/modules/science/science_screen.dart';
import 'package:newsapp/modules/settings/settings_screen.dart';
import 'package:newsapp/modules/sports/sports_screen.dart';
import 'package:newsapp/shared/cubit/states.dart';
import 'package:newsapp/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates> {
  NewsCubit() : super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex = 0;

  List<BottomNavigationBarItem> bottomItems = [
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    const BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),
  ];

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen(),
  ];

  void changeBottomNavBar(int index) {
    if (index == 1) {
      getSportsNews();
    }
    if (index == 2) {
      getScienceNews();
    }
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> businessNews = [];
  List<dynamic> sportsNews = [];
  List<dynamic> scienceNews = [];

  void getBusinessNews() {
    emit(NewsGetBusinessLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'business',
        'apiKey': 'c18a2c6490ff4cb8a4f8b4c100321c52',
      },
    ).then((value) {
      businessNews = value.data['articles'];
      // print('length is: ${businessNews.length}');
      emit(NewsGetBusinessSuccessState());
    }).catchError((error) {
      emit(NewsGetBusinessErrorState(error.toString()));
      print(error.toString());
    });

    emit(NewsGetBusinessSuccessState());
  }

  void getSportsNews() {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'sports',
        'apiKey': 'c18a2c6490ff4cb8a4f8b4c100321c52',
      },
    ).then((value) {
      sportsNews = value.data['articles'];
      // print('length is: ${businessNews.length}');
      emit(NewsGetSportsSuccessState());
    }).catchError((error) {
      emit(NewsGetSportsErrorState(error.toString()));
      print(error.toString());
    });
    emit(NewsGetSportsSuccessState());
  }

  void getScienceNews() {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query: {
        'country': 'eg',
        'category': 'science',
        'apiKey': 'c18a2c6490ff4cb8a4f8b4c100321c52',
      },
    ).then((value) {
      scienceNews = value.data['articles'];
      print('length is: ${businessNews.length}');
      emit(NewsGetScienceSuccessState());
    }).catchError((error) {
      emit(NewsGetScienceErrorState(error.toString()));
      print(error.toString());
    });
    emit(NewsGetScienceSuccessState());
  }

  List<dynamic> search = [];

  void getSearch(String value)
  {
    emit(NewsGetSearchLoadingState());
    search = [];
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q': '$value',
        'apiKey': 'c18a2c6490ff4cb8a4f8b4c100321c52',
      },
    ).then((value) {
      search = value.data['articles'];
      print(search[0]['title']);
      emit(NewsGetSearchSuccessState());
    }).catchError((error) {
      emit(NewsGetSearchErrorState(error.toString()));
      print(error.toString());
    });
    emit(NewsGetSearchSuccessState());
  }

}
