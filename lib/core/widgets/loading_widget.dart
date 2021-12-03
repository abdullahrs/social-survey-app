import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget kLoadingWidget = Platform.isAndroid
    ? const CircularProgressIndicator()
    : const CupertinoActivityIndicator();
