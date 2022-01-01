import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/core/extensions/color_extension.dart';
import 'package:anket/product/constants/app_constants/app_categories.dart';
import 'package:anket/product/models/category.dart';
import 'package:anket/product/services/data_service.dart';
import 'package:anket/product/utils/token_cache_manager.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CategoryPage extends StatelessWidget {
  const CategoryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Category>>(
        future: DataService.instance.getCategories(
          control: TokenCacheManager.instance.checkUserIsLogin(),
          token: TokenCacheManager.instance.getToken()!,
        ),
        builder: (context, snapshot) {
          return GridView.builder(
            itemCount: kCategories.length,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
            ),
            itemBuilder: (BuildContext context, int index) {
              if (snapshot.hasData &&
                  snapshot.connectionState == ConnectionState.done) {
                if (snapshot.data!.isEmpty) {
                  return Container(
                    color: Colors.red,
                    child: const Text("Snapshot.data is empty"),
                  );
                }
                String categoryName = snapshot.data![index].name;
                return Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Card(
                      color: HexColor.fromHex(snapshot.data![index].color),
                      child: SizedBox(
                        height: context.dynamicWidth(0.4),
                        width: context.dynamicWidth(0.4),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            SvgPicture.asset(
                              kCategoryIcons.containsKey(categoryName)
                                  ? kCategoryIcons[categoryName]!
                                  : kDefaultIconPath,
                              height: context.dynamicWidth(0.2),
                              width: context.dynamicWidth(0.2),
                            ),
                            const SizedBox(height: 20),
                            Text(
                              kCategories[index].tr(),
                              style: context.appTextTheme.headline4,
                            )
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else {
                return const SizedBox(
                    height: 16, width: 16, child: CircularProgressIndicator());
              }
            },
          );
        });
  }
}
