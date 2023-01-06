import 'dart:math';
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:tractian_challenge/features/assets/components/asset_orders_dialog_component.dart';
import 'package:tractian_challenge/features/assets/components/status_container_component.dart';
import 'package:tractian_challenge/models/assets/asset_model.dart';
import 'package:tractian_challenge/models/workOrders/work_order_model.dart';
import 'package:tractian_challenge/utils/components/base_appbar.dart';
import 'package:tractian_challenge/utils/components/base_page.dart';

import '../../models/user_model.dart';
import '../../utils/singletons/main_singleton.dart';

class AssetInfoPage extends StatefulWidget {
  const AssetInfoPage({super.key});

  @override
  State<AssetInfoPage> createState() => _AssetInfoPageState();
}

class _AssetInfoPageState extends State<AssetInfoPage> {
  final mainSingleton = Modular.get<MainSingleton>();
  Asset? asset;
  User? user;
  List<WorkOrder> openOrders = [];
  @override
  Widget build(BuildContext context) {
    // ignore: unnecessary_null_comparison
    if (asset == null) {
      final arg = ModalRoute.of(context)!.settings.arguments as Asset;
      var json = arg.toJson();
      asset = Asset.fromJson(json);
      user = mainSingleton.users
          .firstWhere((element) => element.id == asset!.assignedUserIds[0]);

      for (var element in mainSingleton.workOrders) {
        if (element.assetId == asset!.id) {
          openOrders.add(element);
        }
      }
    }

    return BasePage(
      onWillPop: () {
        Navigator.pop(context);
      },
      appBar: BaseAppBar(title: 'Asset Info'),
      child: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 20, right: 20, top: 40, bottom: 90),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 250,
                child: CachedNetworkImage(
                  imageUrl: asset!.image,
                  imageBuilder: (context, imageProvider) => Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  placeholder: (context, url) => CircularProgressIndicator(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
              SizedBox(height: 60),
              Text(
                asset!.name,
                style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 25),
              ),
              SizedBox(height: 40),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIconLabel(Icons.info_outline, 'Status'),
                  StatusContainer(status: asset!.status)
                ],
              ),
              customDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIconLabel(Icons.sensor_occupied_outlined, 'Sensor'),
                  Text(
                    asset!.sensors[0].toCapitalized(),
                    style: TextStyle(color: Colors.white60, fontSize: 21),
                  ),
                ],
              ),
              customDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIconLabel(Icons.engineering_outlined, 'Model'),
                  Text(
                    asset!.model.toCapitalized(),
                    style: TextStyle(color: Colors.white60, fontSize: 21),
                  ),
                ],
              ),
              customDivider(),
              getIconLabel(
                  Icons.energy_savings_leaf_outlined, 'Roller Bearing Data'),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.only(left: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    asset!.specifications.rpm != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Text(
                              "• RPM: " +
                                  asset!.specifications.rpm!.toStringAsFixed(2),
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 21),
                            ),
                          )
                        : SizedBox(),
                    // ignore: unnecessary_null_comparison
                    asset!.specifications.maxTemp != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Text(
                              "• Maximum Temperature: " +
                                  asset!.specifications.maxTemp
                                      .toStringAsFixed(2) +
                                  '°',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 21),
                            ),
                          )
                        : SizedBox(),
                    asset!.specifications.power != null
                        ? Padding(
                            padding: const EdgeInsets.only(bottom: 18),
                            child: Text(
                              "• Power: " +
                                  asset!.specifications.power!
                                      .toStringAsFixed(2) +
                                  ' kWh',
                              style: TextStyle(
                                  color: Colors.white60, fontSize: 21),
                            ),
                          )
                        : SizedBox(),
                    // ignore: unnecessary_null_comparison
                    asset!.metrics.totalCollectsUptime != null
                        ? Text(
                            "• Total Collects Uptime: " +
                                asset!.metrics.totalCollectsUptime
                                    .toStringAsFixed(2),
                            style:
                                TextStyle(color: Colors.white60, fontSize: 21),
                          )
                        : SizedBox(),
                  ],
                ),
              ),
              customDivider(),
              GestureDetector(
                onTap: () async {
                  if (openOrders.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        "No Open Orders Avaiable",
                        style: TextStyle(fontSize: 18),
                      ),
                    ));
                  } else {
                    await AssetOrdersDialog().openDialog(context, openOrders);
                  }
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        getIconLabel(Icons.book, 'Open Orders'),
                        SizedBox(height: 0),
                        Text(
                          'Click for more',
                          style: TextStyle(color: Colors.white60, fontSize: 18),
                        )
                      ],
                    ),
                    Text(
                      openOrders.length.toString(),
                      style: TextStyle(color: Colors.white60, fontSize: 21),
                    )
                  ],
                ),
              ),
              customDivider(),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  getIconLabel(
                      Icons.medical_information_outlined, 'Health Score'),
                  Text(
                    asset!.healthscore.toStringAsFixed(2) + '%',
                    style: TextStyle(color: Colors.white60, fontSize: 21),
                  ),
                ],
              ),
              SizedBox(height: 40),
              SizedBox(
                width: MediaQuery.of(context).size.width,
                child: SfCartesianChart(
                    borderWidth: 0,
                    primaryXAxis: CategoryAxis(
                      labelStyle: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      borderColor: Colors.white,
                      minimum: 0,
                      maximum: 4,
                    ),
                    primaryYAxis: NumericAxis(
                      maximum: 4,
                      minimum: 0,
                      interval: 1,
                      axisLabelFormatter: (axisLabelRenderArgs) {
                        axisLabelRenderArgs.value;
                        return getYChart(axisLabelRenderArgs.value);
                      },
                    ),
                    series: <ChartSeries>[
                      LineSeries<ChartData, String>(
                          width: 3,
                          dataSource: getGraphicData(),
                          pointColorMapper: (ChartData data, _) => data.color,
                          xValueMapper: (ChartData data, _) => data.x,
                          yValueMapper: (ChartData data, _) => data.y)
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }

  customDivider() {
    return Padding(
      padding: EdgeInsets.only(right: 8, left: 8, bottom: 25, top: 25),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 2,
        color: Colors.white24,
      ),
    );
  }

  getYChart(value) {
    print(value);
    var textSize = 16.0;

    if (value == 4) {
      return ChartAxisLabel(
          'In\nAlert ', TextStyle(color: Colors.red, fontSize: textSize));
    } else if (value == 3) {
      return ChartAxisLabel('Unplanned\nStop ',
          TextStyle(color: Colors.orange, fontSize: textSize));
    } else if (value == 2) {
      return ChartAxisLabel(
          'In\nOperation ', TextStyle(color: Colors.green, fontSize: textSize));
    } else if (value == 1) {
      return ChartAxisLabel(
          'In\nDowntime ', TextStyle(color: Colors.blue, fontSize: textSize));
    } else if (value == 0) {
      return ChartAxisLabel(
          'Offline ', TextStyle(color: Colors.grey, fontSize: textSize));
    } else {
      return ChartAxisLabel(
          '', TextStyle(color: Colors.grey, fontSize: textSize));
    }
  }

  getGraphicData() {
    List<ChartData> data = [];
    for (var element in asset!.healthHistory) {
      String status = element.status;
      Color color;
      double index;

      String time = 'Day ' +
          element.timestamp.split('-')[1] +
          '\n' +
          element.timestamp.split('-')[2].split('T')[0] +
          ':00';

      if (status == 'inAlert') {
        color = Colors.red;
        index = 4;
      } else if (status == 'unplannedStop') {
        color = Colors.orange;
        index = 3;
      } else if (status == 'inOperation') {
        color = Colors.green;
        index = 2;
      } else if (status == 'inDowntime') {
        color = Colors.blue;
        index = 1;
      } else {
        color = Colors.grey;
        index = 0;
      }
      color = Colors.white;

      data.add(ChartData(time, index, color));
    }
    return data;
  }

  getIconLabel(icon, text) {
    return Row(
      children: [
        Icon(
          icon,
          size: 40,
          color: Colors.lightBlueAccent,
        ),
        SizedBox(width: 20),
        Text(
          text,
          style: TextStyle(
              color: Colors.white, fontWeight: FontWeight.bold, fontSize: 20),
        ),
      ],
    );
  }
}

class ChartData {
  ChartData(this.x, this.y, this.color);
  final String x;
  final double y;
  final Color color;
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
