import 'package:flutter/material.dart';

import '../../../../core/widgets/loading_widget.dart';
import '../../../models/category.dart';
import '../../../services/data_service.dart';
import '../../../utils/survey_cache_manager.dart';
import '../components/categories_grid.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SurveyCacheManager.instance.categories.isEmpty
        ? futureBuilder()
        : CategoriyGrid(data: SurveyCacheManager.instance.categories);
  }

  FutureBuilder<List<Category>> futureBuilder() {
    return FutureBuilder<List<Category>>(
        future: DataService.instance.getCategories(),
        builder: (context, snapshot) {
          if (snapshot.hasData &&
              snapshot.connectionState == ConnectionState.done) {
            return CategoriyGrid(data: snapshot.data!);
          }
          return kLoadingWidget;
        });
  }
}
