import 'dart:developer';

import '../../../../core/widgets/loading_widget.dart';
import '../../../components/survey_list.dart';
import '../../../models/survey.dart';
import '../../../utils/location_service/location_cubit.dart';
import '../view_model/location_category_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:geolocator/geolocator.dart';

class LocationListPage extends StatefulWidget {
  const LocationListPage({Key? key}) : super(key: key);

  @override
  State<LocationListPage> createState() => _LocationListPageState();
}

class _LocationListPageState extends State<LocationListPage> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCategoryCubit(),
      child: BlocBuilder<LocationCategoryCubit, LocationCategoryState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(),
            body: FutureBuilder(
                future: context.read<LocationCubit>().getCurrentPosition(),
                builder: (context, AsyncSnapshot<Position?> snapshot) {
                  if (snapshot.connectionState == ConnectionState.done &&
                      snapshot.data != null) {
                    return FutureBuilder(
                      future: context
                          .read<LocationCategoryCubit>()
                          .getLocationSurvey(snapshot.data!),
                      builder: (context,
                          AsyncSnapshot<List<Survey>> surveySnapshot) {
                        if (surveySnapshot.hasError) {
                          return Center(
                              child: Text(surveySnapshot.error.toString()));
                        }
                        if (surveySnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return kLoadingWidget;
                        }
                        if (surveySnapshot.connectionState ==
                                ConnectionState.done &&
                            surveySnapshot.data == null) {
                          return const Center(child: Text("no-data"));
                        }
                        if (surveySnapshot.connectionState ==
                            ConnectionState.done) {
                          return SurveyListPage(
                              surveys: surveySnapshot.data!,
                              scrollCallback: (_) {
                                return Future.value(false);
                              });
                        }
                        return Container();
                      },
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return kLoadingWidget;
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text(snapshot.error.toString()));
                  }
                  return const Center(child: Text('location not found'));
                }),
          );
        },
      ),
    );
  }
}
