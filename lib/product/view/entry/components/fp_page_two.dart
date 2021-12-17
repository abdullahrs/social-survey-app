import 'package:anket/core/extensions/buildcontext_extension.dart';
import 'package:anket/product/components/custom_button.dart';
import 'package:anket/product/constants/style/colors.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FPPageTwo extends StatefulWidget {
  final TextEditingController _codeController;
  final PageController _pageController;
  const FPPageTwo(
      {Key? key,
      required TextEditingController codeController,
      required PageController pageController})
      : _codeController = codeController,
        _pageController = pageController,
        super(key: key);

  @override
  State<FPPageTwo> createState() => _FPPageTwoState();
}

class _FPPageTwoState extends State<FPPageTwo> {
  final FocusNode inputNode = FocusNode();

  String codeString = "";
  @override
  void initState() {
    super.initState();
    widget._codeController.addListener(() {
      if (widget._codeController.text != codeString) {
        setState(() {
          codeString = widget._codeController.text;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          SizedBox(height: context.dynamicHeight(0.1)),
          Text('forgot_pass'.tr(),
              style: context.appTextTheme.headline4!
                  .copyWith(fontWeight: FontWeight.bold)),
          SizedBox(height: context.dynamicHeight(0.1)),
          codeField(),
          // TODO: ERROR
          SizedBox(height: context.dynamicHeight(0.05)),
          CustomButton(
              voidCallback: () {
                if (widget._codeController.text.length == 4) {
                  widget._pageController.nextPage(
                      duration: const Duration(milliseconds: 300),
                      curve: Curves.bounceOut);
                }
              },
              text: "next"),
        ],
      ),
    );
  }

  SizedBox codeField() {
    return SizedBox(
      height: context.dynamicWidth(0.2),
      child: Stack(
        alignment: AlignmentDirectional.center,
        children: [
          SizedBox(
            height: context.dynamicWidth(0.2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List<Widget>.generate(
                  4,
                  (index) => SizedBox(
                        width: context.dynamicWidth(0.2),
                        height: context.dynamicWidth(0.2),
                        child: Card(
                          color: AppStyle.codeFieldBackgroundColor,
                          child: Center(child: Text(getCode(index))),
                        ),
                      )),
            ),
          ),
          SizedBox(
            height: context.dynamicWidth(0.2),
            child: TextField(
              controller: widget._codeController,
              focusNode: inputNode,
              autofocus: true,
              showCursor: false,
              maxLength: 4,
              keyboardType: TextInputType.number,
              maxLengthEnforcement: MaxLengthEnforcement.none,
              enableInteractiveSelection: false,
              style: const TextStyle(color: Colors.transparent),
              decoration: const InputDecoration(
                  filled: true, fillColor: Colors.transparent, counterText: ""),
            ),
          ),
        ],
      ),
    );
  }

  String getCode(int index) {
    String code;
    try {
      code = codeString[index];
    } catch (e) {
      return "";
    }
    return code;
  }
}
