import 'package:flutter/material.dart';
import 'package:spa_manager_flutter/components/back_widget.dart';
import 'package:spa_manager_flutter/components/cached_image_widget.dart';
import 'package:spa_manager_flutter/components/gallery_component.dart';
import 'package:spa_manager_flutter/components/price_widget.dart';
import 'package:spa_manager_flutter/main.dart';
import 'package:spa_manager_flutter/models/service_model.dart';
import 'package:spa_manager_flutter/networks/rest_apis.dart';
import 'package:spa_manager_flutter/provider/services/add_service_screen.dart';
import 'package:spa_manager_flutter/screens/gallery_List_Screen.dart';
import 'package:spa_manager_flutter/utils/common.dart';
import 'package:spa_manager_flutter/utils/configs.dart';
import 'package:spa_manager_flutter/utils/extensions/context_ext.dart';
import 'package:spa_manager_flutter/utils/images.dart';
import 'package:nb_utils/nb_utils.dart';

class ServiceDetailHeaderComponent extends StatefulWidget {
  final ServiceData serviceDetail;

  const ServiceDetailHeaderComponent({required this.serviceDetail, Key? key}) : super(key: key);

  @override
  State<ServiceDetailHeaderComponent> createState() => _ServiceDetailHeaderComponentState();
}

class _ServiceDetailHeaderComponentState extends State<ServiceDetailHeaderComponent> {
  @override
  void initState() {
    super.initState();
    init();
  }

  void init() async {
    setStatusBarColor(transparentColor, delayInMilliSeconds: 1000);
  }

  void removeService() {
    deleteService(widget.serviceDetail.id.validate()).then((value) {
      appStore.setLoading(true);
      finish(context, true);
    }).catchError((e) {
      appStore.setLoading(false);
      toast(e.toString(), print: true);
    });
  }

  Future<void> confirmationDialog(BuildContext context) async {
    showConfirmDialogCustom(
      context,
      title: context.translate.confirmationRequestTxt,
      primaryColor: primaryColor,
      positiveText: context.translate.lblYes,
      negativeText: context.translate.lblNo,
      onAccept: (context) async {
        ifNotTester(context, () {
          appStore.setLoading(true);
          removeService();
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 475,
      width: context.width(),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          if (widget.serviceDetail.attchments.validate().isNotEmpty)
            SizedBox(
              height: 400,
              width: context.width(),
              child: CachedImageWidget(
                url: widget.serviceDetail.attchments!.first.url.validate(),
                fit: BoxFit.cover,
                height: 400,
              ),
            ),
          Positioned(
            top: context.statusBarHeight + 8,
            left: 8,
            child: Container(
              child: BackWidget(color: context.iconColor).paddingLeft(8),
              decoration: BoxDecoration(shape: BoxShape.circle, color: context.cardColor.withOpacity(0.7)),
            ),
          ),
          Positioned(
            top: context.statusBarHeight + 8,
            child: isUserTypeProvider
                ? Container(
                    padding: EdgeInsets.all(0),
                    decoration: BoxDecoration(shape: BoxShape.circle, color: context.cardColor.withOpacity(0.7)),
                    child: PopupMenuButton(
                      icon: Icon(Icons.more_horiz, size: 24, color: context.iconColor),
                      padding: EdgeInsets.all(8),
                      onSelected: (selection) {
                        if (selection == 1) {
                          AddServiceScreen(data: widget.serviceDetail).launch(context).then((value) {
                            if (value ?? false) {
                              init();
                            }
                          });
                        } else if (selection == 2) {
                          confirmationDialog(context);
                        }
                      },
                      itemBuilder: (context) => [
                        PopupMenuItem(child: Text(context.translate.lblEdit, style: boldTextStyle()), value: 1),
                        PopupMenuItem(child: Text(context.translate.lblDelete, style: boldTextStyle()), value: 2),
                      ],
                    ),
                  )
                : Offstage(),
            right: 16,
          ),
          Positioned(
            bottom: 0,
            left: 16,
            right: 16,
            child: Column(
              children: [
                Row(
                  children: [
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: List.generate(
                        widget.serviceDetail.attchments!.take(2).length,
                        (i) => Container(
                          decoration: BoxDecoration(border: Border.all(color: white, width: 2), borderRadius: radius()),
                          child: GalleryComponent(
                            images: widget.serviceDetail.attchments.validate().map((e) => e.url.validate()).toList(),
                            index: i,
                            padding: 32,
                            height: 60,
                            width: 60,
                          ),
                        ),
                      ),
                    ),
                    16.width,
                    if (widget.serviceDetail.attchments!.length > 2)
                      Blur(
                        borderRadius: radius(),
                        padding: EdgeInsets.zero,
                        child: Container(
                          height: 60,
                          width: 60,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(border: Border.all(color: white, width: 2), borderRadius: radius()),
                          child: Text('+' '${widget.serviceDetail.attchments!.length - 2}', style: boldTextStyle(color: white)),
                        ),
                      ).onTap(
                        () {
                          GalleryListScreen(
                            galleryImages: widget.serviceDetail.attchments.validate().map((e) => e.url.validate()).toList(),
                            serviceName: widget.serviceDetail.name.validate(),
                          ).launch(context, pageRouteAnimation: PageRouteAnimation.Fade, duration: 400.milliseconds).then((value) {
                            setStatusBarColor(transparentColor, delayInMilliSeconds: 1000);
                          });
                        },
                      ),
                  ],
                ),
                16.height,
                Container(
                  width: context.width(),
                  padding: EdgeInsets.all(16),
                  decoration: boxDecorationDefault(
                    color: context.scaffoldBackgroundColor,
                    border: Border.all(color: context.dividerColor),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (widget.serviceDetail.subCategoryName.validate().isNotEmpty)
                        Marquee(
                          child: Row(
                            children: [
                              Text('${widget.serviceDetail.categoryName}', style: boldTextStyle(size: 14, color: textSecondaryColorGlobal)),
                              Text('  >  ', style: boldTextStyle(size: 14, color: textSecondaryColorGlobal)),
                              Text('${widget.serviceDetail.subCategoryName.capitalizeFirstLetter()}', style: boldTextStyle(size: 14, color: context.primaryColor)),
                            ],
                          ),
                        )
                      else
                        Text('${widget.serviceDetail.categoryName}', style: boldTextStyle(size: 14, color: context.primaryColor)),
                      8.height,
                      Marquee(
                        child: Text('${widget.serviceDetail.name.validate()}', style: boldTextStyle(size: 20)),
                        directionMarguee: DirectionMarguee.oneDirection,
                      ),
                      8.height,
                      Row(
                        children: [
                          PriceWidget(
                            price: widget.serviceDetail.price.validate(),
                            isHourlyService: widget.serviceDetail.isHourlyService,
                            size: 18,
                            hourlyTextColor: textSecondaryColorGlobal,
                            isFreeService: widget.serviceDetail.isFreeService,
                          ),
                          4.width,
                          if (widget.serviceDetail.discount.validate() != 0)
                            Text(
                              '(${widget.serviceDetail.discount.validate()}% ${context.translate.lblOff})',
                              style: boldTextStyle(color: Colors.green),
                            ),
                        ],
                      ),
                      8.height,
                      TextIcon(
                        edgeInsets: EdgeInsets.symmetric(horizontal: 0, vertical: 8),
                        text: '${context.translate.hintDuration}',
                        textStyle: secondaryTextStyle(size: 16),
                        expandedText: true,
                        suffix: Text("${widget.serviceDetail.duration.validate()} ${context.translate.lblHr}", style: boldTextStyle(color: context.primaryColor)),
                      ),
                      TextIcon(
                        text: '${context.translate.lblRating}',
                        textStyle: secondaryTextStyle(size: 16),
                        edgeInsets: EdgeInsets.symmetric(vertical: 4),
                        expandedText: true,
                        suffix: Row(
                          children: [
                            Image.asset(
                              ic_star_fill,
                              height: 18,
                              color: getRatingBarColor(widget.serviceDetail.totalRating.validate().toInt()),
                            ),
                            4.width,
                            Text("${widget.serviceDetail.totalRating.validate().toStringAsFixed(1)}", style: boldTextStyle()),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
