import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

import '../../../core/widgets/loading_widget.dart';
import '../../components/survey_list.dart';
import '../../models/survey.dart';
import '../../services/data_service.dart';
import '../../utils/custom_exception.dart';

class LocationDetailPage extends StatelessWidget {
  final Position position;
  final String cityName;
  const LocationDetailPage(
      {Key? key, required this.position, required this.cityName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(cityName),
        ),
        body: FutureBuilder<List<Survey>?>(
          future: DataService.fromCache()
              .getLocationSurveys(position.latitude, position.longitude),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              if (snapshot.error is FetchDataException) {
                return Center(
                    child:
                        Text((snapshot.error as FetchDataException).message));
              }
              return SingleChildScrollView(
                  child: Center(child: Text(snapshot.error.toString())));
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return kLoadingWidget;
            }
            if (snapshot.connectionState == ConnectionState.done &&
                snapshot.data == null) {
              return const Center(child: Text("no-data"));
            }
            if (snapshot.connectionState == ConnectionState.done &&
                (snapshot.data != null && snapshot.data!.isNotEmpty)) {
              return SurveyListPage(
                  surveys: snapshot.data!,
                  isSurveysAvaible: false,
                  scrollCallback: (_) {
                    return Future.value(false);
                  });
            }
            return kLoadingWidget;
          },
        ));
  }
}
