import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';

import '../../../constants/app_constants/cities.dart';
import '../../../../core/widgets/loading_widget.dart';
import '../../../components/survey_list.dart';
import '../../../models/survey.dart';
import '../../../router/routes.dart';
import '../../../utils/custom_exception.dart';
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
  Future<Position?>? initialPosition;

  Position getPositionFromCoordinates(Position? _initialPosition, Map d) {
    return Position(
        longitude: d['coordinates'][0],
        latitude: d['coordinates'][1],
        accuracy: _initialPosition?.accuracy ?? 0,
        altitude: _initialPosition?.altitude ?? 0,
        heading: _initialPosition?.heading ?? 0,
        speed: _initialPosition?.speed ?? 0,
        speedAccuracy: _initialPosition?.speedAccuracy ?? 0,
        timestamp: _initialPosition?.timestamp ?? DateTime.now());
  }

  @override
  void initState() {
    super.initState();
    initialPosition = context.read<LocationCubit>().getCurrentPosition();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LocationCategoryCubit(),
      child: BlocBuilder<LocationCategoryCubit, LocationCategoryState>(
        builder: (context, state) {
          return FutureBuilder<Position?>(
              future: initialPosition,
              builder: (context, snapshot) {
                return Scaffold(
                    appBar: AppBar(
                      title: SizedBox(
                        width: double.infinity,
                        height: kToolbarHeight,
                        child: DropdownButton(
                          isExpanded: true,
                          hint: const Text("location-category").tr(),
                          items: kCities.map((e) {
                            return DropdownMenuItem(
                              value: e,
                              child: Text(e['name']),
                            );
                          }).toList(),
                          onChanged: (data) {
                            Position position = getPositionFromCoordinates(
                                snapshot.data, data as Map);
                            context.router.push(
                              LocationDetailRoute(
                                position: position,
                                cityName: data['name'],
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    body: FutureBuilder(
                      future: context
                          .read<LocationCategoryCubit>()
                          .getLocationSurvey(snapshot.data),
                      builder: (context,
                          AsyncSnapshot<List<Survey>> surveySnapshot) {
                        if (surveySnapshot.hasError) {
                          if (surveySnapshot.error is FetchDataException) {
                            return Center(
                                child: Text(
                                    (surveySnapshot.error as FetchDataException)
                                        .message));
                          }
                          return SingleChildScrollView(
                              child: Center(
                                  child:
                                      Text(surveySnapshot.error.toString())));
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
                                ConnectionState.done &&
                            (surveySnapshot.data != null &&
                                surveySnapshot.data!.isNotEmpty)) {
                          return SurveyListPage(
                              surveys: surveySnapshot.data!,
                              scrollCallback: (_) {
                                return Future.value(false);
                              });
                        }
                        return kLoadingWidget;
                      },
                    ));
              });
        },
      ),
    );
  }
}
