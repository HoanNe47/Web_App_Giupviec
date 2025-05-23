import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:spa_manager_flutter/components/gallery_component.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:nb_utils/nb_utils.dart';

class GalleryListScreen extends StatelessWidget {
  final List<String> galleryImages;
  final String? serviceName;

  GalleryListScreen({required this.galleryImages, required this.serviceName});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBarWidget("${context.translate.lblGallery} ${'- ${serviceName.validate()}'}", textColor: Colors.white, color: context.primaryColor, backWidget: BackWidget()),
      body: AnimatedWrap(
        spacing: 16,
        runSpacing: 16,
        itemCount: galleryImages.length,
        listAnimationType: ListAnimationType.Scale,
        scaleConfiguration: ScaleConfiguration(duration: 400.milliseconds, delay: 50.milliseconds),
        itemBuilder: (context, i) {
          return GalleryComponent(images: galleryImages, index: i);
        },
      ).paddingSymmetric(horizontal: 16, vertical: 16),
    );
  }
}
