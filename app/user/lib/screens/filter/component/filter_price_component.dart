import 'package:actcms_spa_flutter/main.dart';
import 'package:flutter/material.dart';
import 'package:nb_utils/nb_utils.dart';

class FilterPriceComponent extends StatefulWidget {
  @override
  State<FilterPriceComponent> createState() => _FilterPriceComponentState();
}

class _FilterPriceComponentState extends State<FilterPriceComponent> {
  late RangeValues rangeValues;

  @override
  void initState() {
    if (filterStore.isPriceMax.isNotEmpty && filterStore.isPriceMin.isNotEmpty) {
      rangeValues = RangeValues(filterStore.isPriceMin.toDouble(), filterStore.isPriceMax.toDouble());
    } else {
      rangeValues = RangeValues(1, 5000);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: context.width(),
      decoration: boxDecorationDefault(color: context.cardColor),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(language.lblPrice, style: boldTextStyle()).paddingAll(16),
          RangeSlider(
            min: 1,
            max: 5000,
            divisions: (5000 ~/ 100).toInt(),
            labels: RangeLabels(rangeValues.start.toInt().toString(), rangeValues.end.toInt().toString()),
            values: rangeValues,
            onChanged: (values) {
              rangeValues = values;
              filterStore.setMaxPrice(values.end.toInt().toString());
              filterStore.setMinPrice(values.start.toInt().toString());
              setState(() {});
            },
          ),
          16.height,
          Text("[ ${appStore.currencySymbol}${rangeValues.start.toInt()} - ${appStore.currencySymbol}${rangeValues.end.toInt()} ]", style: primaryTextStyle()).center(),
        ],
      ),
    );
  }
}
