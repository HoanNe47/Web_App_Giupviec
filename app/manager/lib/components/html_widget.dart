import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:nb_utils/nb_utils.dart';

class HtmlWidget extends StatelessWidget {
  final String? postContent;
  final Color? color;
  final String? title;

  HtmlWidget({this.postContent, this.color, this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget(title.validate(), elevation: 0, backWidget: BackWidget(), color: context.primaryColor, textColor: Colors.white),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0),
        child: Html(
          data: postContent!,
          onLinkTap: (s, _, __, ___) {
            //
          },
          onImageTap: (s, _, __, ___) {
            // ZoomImageScreen(mProductImage: Image.network(s!, width: context.width()).image);
          },
        ),
      ),
    );
  }
}
