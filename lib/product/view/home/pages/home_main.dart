import '../../../../core/extensions/buildcontext_extension.dart';
import '../../../../core/extensions/color_extension.dart';
import '../../../constants/app_constants/app_categories.dart';
import '../../../models/category.dart';
import '../../../models/survey.dart';
import '../../../services/data_service.dart';
import '../../../utils/token_cache_manager.dart';
import '../components/survey_list_item.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeMainPage extends StatelessWidget {
  const HomeMainPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
            child: Text(
              'categories'.tr(),
              style: context.appTextTheme.headline5!
                  .copyWith(fontWeight: FontWeight.bold),
            ),
          ),
          Container(
            height: context.dynamicHeight(0.125),
            width: context.screenWidth,
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: FutureBuilder(
                future: DataService.instance.getCategories(
                  control: TokenCacheManager.instance.checkUserIsLogin(),
                  token: TokenCacheManager.instance.getToken()!,
                ),
                builder: (BuildContext context,
                    AsyncSnapshot<List<Category>> snapshot) {
                  if (snapshot.hasData &&
                      snapshot.connectionState == ConnectionState.done) {
                    return ListView.builder(
                      itemCount: snapshot.data!.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (BuildContext context, int index) {
                        String categoryName = snapshot.data![index].name;
                        return InkWell(
                          onTap: () {},
                          child: Container(
                            height: context.dynamicHeight(0.125),
                            width: context.dynamicHeight(0.125),
                            padding: const EdgeInsets.all(10),
                            child: Card(
                              color:
                                  HexColor.fromHex(snapshot.data![index].color),
                              child: Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: SvgPicture.asset(
                                  kCategoryIcons.containsKey(categoryName)
                                      ? kCategoryIcons[categoryName]!
                                      : kDefaultIconPath,
                                ),
                              ),
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(child: CircularProgressIndicator());
                }),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'surveys'.tr(),
                  style: context.appTextTheme.headline5!
                      .copyWith(fontWeight: FontWeight.bold),
                ),
                InkWell(
                  onTap: () {},
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'all'.tr(),
                        style: context.appTextTheme.headline6!
                            .copyWith(color: Colors.blue),
                      ),
                      const Icon(Icons.keyboard_arrow_right_outlined,
                          color: Colors.blue)
                    ],
                  ),
                )
              ],
            ),
          ),
          FutureBuilder(
              future: DataService.instance.getSurveys(
                control: TokenCacheManager.instance.checkUserIsLogin(),
                token: TokenCacheManager.instance.getToken()!,
              ),
              builder: (BuildContext context,
                  AsyncSnapshot<List<Survey>> snapshot) {
                if (snapshot.hasData &&
                    snapshot.connectionState == ConnectionState.done) {}
                return const Center(child: CircularProgressIndicator());
              }),
        ],
      ),
    );
  }
}
