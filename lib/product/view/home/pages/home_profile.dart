import 'package:easy_localization/src/public_ext.dart';

import '../../../utils/survey_cache_manager.dart';
import '../../../utils/theme_util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../services/data_service.dart';

import '../../../../core/extensions/buildcontext_extension.dart';
import 'package:auto_route/src/router/auto_router_x.dart';
import 'package:flutter/material.dart';

import '../../../constants/app_constants/hive_model_constants.dart';
import '../../../services/auth_service.dart';
import '../../../utils/token_cache_manager.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({Key? key}) : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  bool _isEditingText = false;
  bool _isEditingGender = false;
  // bool _isEditingBirthDate = false;
  late final TextEditingController _editingController;
  late String name;
  String? gender;
  late String birthDate;

  @override
  void initState() {
    super.initState();
    _editingController = TextEditingController();
  }

  @override
  void dispose() {
    _editingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
              onPressed: () => onPressLogout(context),
              icon: const Icon(Icons.logout)),
        ],
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: SingleChildScrollView(
              child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Kişisel Bilgiler", style: context.appTextTheme.headline5),
              const Divider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Flexible(
                          child: Text('name'.tr() + ' : ',
                              style: context.appTextTheme.bodyText2!
                                  .copyWith(fontWeight: FontWeight.bold)),
                        ),
                        Expanded(
                          child: _editTitleTextField(
                              DataService.authUser?.name! ?? " -",
                              _editingController),
                        )
                      ],
                    ),
                  ),
                  IconButton(
                      onPressed: onClickNameEdit,
                      icon: Icon(_isEditingText ? Icons.edit_off : Icons.edit))
                ],
              ),
              const Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Flexible(
                    child: Text.rich(TextSpan(
                      children: [
                        TextSpan(
                            text: 'gender'.tr() + ' : ',
                            style: context.appTextTheme.bodyText2!
                                .copyWith(fontWeight: FontWeight.bold)),
                        TextSpan(text: DataService.authUser?.gender ?? " -"),
                      ],
                    )),
                  ),
                  _isEditingGender
                      ? genderDropdown()
                      : Flexible(
                          child: IconButton(
                              onPressed: onClickGenderEdit,
                              icon: const Icon(Icons.edit)),
                        )
                ],
              ),
              const Divider(thickness: 2),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Text('birth-date'.tr() + ' : ',
                          style: context.appTextTheme.bodyText2!
                              .copyWith(fontWeight: FontWeight.bold)),
                      Text(DataService.authUser?.birthdate ?? " -"),
                    ],
                  ),
                  Flexible(
                    child: IconButton(
                        onPressed: () {
                          setState(() {
                            _isEditingText = true;
                          });
                        },
                        icon: const Icon(Icons.edit)),
                  )
                ],
              ),
              const Divider(thickness: 2),
              Row(
                children: [
                  Text(
                    'dark-mode'.tr(),
                    style: context.appTextTheme.bodyText2!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                  Expanded(
                    child: SwitchListTile(
                        value: SurveyCacheManager.instance
                                .getItem(HiveModelConstants.darkMode) ??
                            ThemeMode.system == ThemeMode.dark,
                        onChanged: context.read<ThemeCubit>().changeTheme),
                  )
                ],
              ),
              const SizedBox(height: 50),
              Text('last-surveys'.tr(), style: context.appTextTheme.headline5),
              const Divider(),
            ],
          )),
        ),
      ),
    );
  }

  DropdownButton genderDropdown() {
    return DropdownButton<String>(
      value: DataService.authUser?.gender,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      underline: const SizedBox(),
      onChanged: (String? newValue) async {
        gender = newValue!;
        String? genderOnCache = DataService.authUser?.gender;
        if ((genderOnCache == null && gender != null) ||
            (genderOnCache != null && gender != null && genderOnCache != gender)) {
          DataService.authUser!.gender = gender;
          await AuthService.fromCache()
              .updateUser(userID: DataService.authUser!.id!, gender: gender!.toLowerCase());
        }
        onClickGenderEdit();
      },
      items: <String>['male'.tr(), 'female'.tr()]
          .map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
    );
  }

  void onClickNameEdit() async {
    String nameOnCache = DataService.authUser?.name! ?? " -";
    if (_editingController.text.isEmpty) {
      _editingController.text = DataService.authUser?.name! ?? " -";
    } else if (_editingController.text != nameOnCache && _isEditingText) {
      DataService.authUser?.name = _editingController.text;
      await AuthService.fromCache().updateUser(
          userID: DataService.authUser!.id!, name: _editingController.text);
    }
    _isEditingText = !_isEditingText;
    setState(() {});
  }

  void onClickGenderEdit() async {
    _isEditingGender = !_isEditingGender;
    setState(() {});
  }

  Widget _editTitleTextField(String text, TextEditingController controller) {
    if (_isEditingText) {
      return TextField(
        onSubmitted: (newValue) {
          setState(() {
            _isEditingText = false;
          });
        },
        decoration: const InputDecoration(border: InputBorder.none),
        autofocus: true,
        controller: controller,
      );
    }
    return Text(text);
  }

  Future<void> onPressLogout(BuildContext context) async {
    try {
      TokenCacheManager cacheManager = TokenCacheManager();
      AuthService authService = AuthService.fromCache();
      var token = cacheManager.getItem(HiveModelConstants.tokenKey);
      bool value = await authService.logout(refreshToken: token!.refresh.token);
      if (value) {
        await cacheManager.removeItem(HiveModelConstants.tokenKey);
        if (context.router.isRoot) {
          context.router.replaceNamed('/');
        } else {
          context.router.pop();
        }
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('[home_settings][onTap] ERROR : $e'),
      ));
      // context.router.pop();
    }
  }
}
