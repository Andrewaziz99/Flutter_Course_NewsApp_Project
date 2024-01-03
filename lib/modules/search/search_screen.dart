import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:newsapp/shared/components/components.dart';
import 'package:newsapp/shared/cubit/cubit.dart';
import 'package:newsapp/shared/cubit/states.dart';
class SearchScreen extends StatelessWidget {

  var searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit, NewsStates>(
      listener: (BuildContext context, state) {},
      builder: (BuildContext context, state)
      {
        var list = NewsCubit.get(context).search;
        return Scaffold(
          appBar: AppBar(),
          body: Column(
            children:
            [
              Padding(
                padding: const EdgeInsets.all(20.0),
                child: defaultFormField(
                  controller: searchController,
                  type: TextInputType.text,
                  label: 'Search',
                  prefix: Icons.search,
                  validate: (String? value) {
                    if(value!.isEmpty)
                    {
                      return 'Search must not be empty';
                    }
                    return null;
                  },
                  onChange: (value)
                  {
                    NewsCubit.get(context).getSearch(value);
                  },
                ),
              ),
              Expanded(
                child: newsBuilder(list, context, isSearch: true),
              ),
            ],
          ),
        );
      },
    );
  }
}
