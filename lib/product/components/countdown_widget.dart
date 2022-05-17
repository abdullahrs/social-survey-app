import 'dart:async';

import '../../core/extensions/buildcontext_extension.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';

class CountdownWidget extends StatefulWidget {
  final DateTime expireDate;
  const CountdownWidget({Key? key, required this.expireDate}) : super(key: key);

  @override
  State<CountdownWidget> createState() => _CountdownWidgetState();
}

class _CountdownWidgetState extends State<CountdownWidget> {
  Timer? _timer;
  late bool expired;
  DateTime? _expireDate;
  @override
  void initState() {
    super.initState();
    if (widget.expireDate.isBefore(DateTime.now())) {
      expired = true;
    } else {
      expired = false;
      _expireDate = widget.expireDate;
      _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
        setState(() {
          _expireDate = _expireDate?.subtract(const Duration(seconds: 1));
          if (_expireDate?.isBefore(DateTime.now()) == true) {
            expired = true;
            _timer?.cancel();
          }
        });
      });
    }
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Card(
        elevation: 10,
        margin: const EdgeInsets.all(10),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            expired
                ? "expired".tr()
                : "${_expireDate?.day} ${'days'.tr()} ${_expireDate?.hour} ${'hours'.tr()} ${_expireDate?.minute} ${'minutes'.tr()} ${_expireDate?.second} ${'seconds'.tr()}",
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
            style: context.appTextTheme.subtitle1,
          ),
        ),
      ),
    );
  }
}
