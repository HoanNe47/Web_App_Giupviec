import 'package:actcms_spa_flutter/component/loader_widget.dart';
import 'package:actcms_spa_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:nb_utils/nb_utils.dart';

class Body extends StatelessWidget {
  final Widget child;

  const Body({Key? key, required this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: context.width(),
      height: context.height(),
      child: Stack(
        fit: StackFit.expand,
        children: [
          child,
          Observer(builder: (_) => LoaderWidget().center().visible(appStore.isLoading)),
        ],
      ),
    );
  }
}
