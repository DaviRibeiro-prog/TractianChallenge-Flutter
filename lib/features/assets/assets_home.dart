// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:tractian_challenge/features/assets/components/status_container_component.dart';
import 'package:tractian_challenge/models/assets/asset_model.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../../utils/components/base_page.dart';
import '../../utils/components/custom_textfield.dart';
import '../../utils/singletons/main_singleton.dart';

class AssetsHomePage extends StatefulWidget {
  const AssetsHomePage({super.key});

  @override
  State<AssetsHomePage> createState() => _AssetsHomePageState();
}

class _AssetsHomePageState extends State<AssetsHomePage> {
  final mainSingleton = Modular.get<MainSingleton>();

  bool filter = false;
  List<Asset> filteredList = [];

  @override
  void initState() {
    super.initState();
    restartList();
/*     // =-==-=-FOR TEST=-=-=-
    filteredList[1].status = 'unplannedStop';
    filteredList[2].status = 'inDowntime';
    filteredList[4].status = 'offline';
    setState(() {});
    //=-=-=-=-=-=-==--=-=-= */
  }

  @override
  Widget build(BuildContext context) {
    return BasePage(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 10, right: 20),
            child: CustomTextfield(
              onChanged: (text) {
                if (text.isEmpty) {
                  restartList();
                } else {
                  if (!filter) {
                    filteredList.clear();
                  }
                  startFilter(text);
                }
              },
              hintText: 'Search asset...',
            ),
          ),
          Expanded(
            child: filteredList.isEmpty
                ? Center(
                    child: Text(
                      'No asset found',
                      textAlign: TextAlign.center,
                      style: TextStyle(color: Colors.white54, fontSize: 30),
                    ),
                  )
                : ListView.separated(
                    padding: EdgeInsets.all(20),
                    separatorBuilder: (context, index) => Padding(
                      padding: EdgeInsets.only(
                          left: 12, right: 12, bottom: 30, top: 30),
                      child: Container(
                        height: 1.5,
                        color: Colors.white24,
                      ),
                    ),
                    itemCount: filteredList.length,
                    shrinkWrap: true,
                    itemBuilder: ((context, index) {
                      Asset asset = filteredList[index];
                      return GestureDetector(
                        onTap: () {
                          Modular.to
                              .pushNamed('/assetInfo', arguments: asset)
                              .then((value) => {restartList()});
                        },
                        child: Row(
                          children: [
                            SizedBox(
                              height: 90,
                              width: MediaQuery.of(context).size.width / 4.5,
                              child: CachedNetworkImage(
                                imageUrl: asset.image,
                                imageBuilder: (context, imageProvider) =>
                                    Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(40),
                                    image: DecorationImage(
                                      image: imageProvider,
                                      fit: BoxFit.cover,
                                    ),
                                  ),
                                ),
                                placeholder: (context, url) => SizedBox(
                                    width: 60,
                                    height: 40,
                                    child: CircularProgressIndicator()),
                                errorWidget: (context, url, error) =>
                                    Icon(Icons.error),
                              ),
                            ),
                            SizedBox(width: 25),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SizedBox(
                                  width:
                                      MediaQuery.of(context).size.width - 200,
                                  child: Text(
                                    asset.name,
                                    maxLines: 2,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 24,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                                SizedBox(height: 12),
                                Text(
                                    'Healthscore: ' +
                                        asset.healthscore.toString() +
                                        '%',
                                    style: TextStyle(
                                        color: Colors.white54, fontSize: 20)),
                                SizedBox(height: 12),
                                StatusContainer(status: asset.status)
                              ],
                            ),
                            Flexible(
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: SizedBox(
                                  child: Icon(
                                    Icons.arrow_right,
                                    color: Colors.white,
                                    size: 50,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      );
                    }),
                  ),
          ),
        ],
      ),
    );
  }

  separePriority() {
    //
    // METHOD TO SEPARATE THE LIST BY PRIORITY (INALERT - UNPLANNED - INOPERATION - INDOWN - OFFILINE)
    //
    List<Asset> offlineAssets = [];
    //
    List<Asset> inAlertAssets = [];
    //
    List<Asset> unplannedStopAssets = [];
    //
    List<Asset> inOperationAssets = [];
    //
    List<Asset> inDowntimeAssets = [];

    for (Asset element in filteredList) {
      if (element.status == 'offline') {
        offlineAssets.add(element);
      } else {
        if (element.status == 'inAlert') {
          inAlertAssets.add(element);
        } else if (element.status == 'unplannedStop') {
          unplannedStopAssets.add(element);
        } else if (element.status == 'inOperation') {
          inOperationAssets.add(element);
        } else {
          inDowntimeAssets.add(element);
        }
      }
    }

    filteredList.clear();
    final finalList = [];

    //
    // FINAL SORT (BY ID)
    //

    offlineAssets.sort((a, b) => a.id.compareTo(b.id));
    inAlertAssets.sort((a, b) => a.id.compareTo(b.id));
    unplannedStopAssets.sort((a, b) => a.id.compareTo(b.id));
    inOperationAssets.sort((a, b) => a.id.compareTo(b.id));
    inDowntimeAssets.sort((a, b) => a.id.compareTo(b.id));

    ////
    //  CREATING THE FINAL SORTED LIST
    ///

    for (var element in inAlertAssets) {
      //
      // 1- ADDING THE 'INALERT' ITEMS
      //
      finalList.add(element);
    }
    for (var element in unplannedStopAssets) {
      //
      // 2- ADDING THE 'UNPLANNED' ITEMS
      //
      finalList.add(element);
    }
    for (var element in inOperationAssets) {
      //
      // 3- ADDING THE 'INOPERATION' ITEMS
      //
      finalList.add(element);
    }
    for (var element in inDowntimeAssets) {
      //
      //  4- ADDING THE 'INDOWNTIME' ITEMS
      //
      finalList.add(element);
    }
    for (var element in offlineAssets) {
      //
      // 5- ADDING THE 'OFFLINE' ITEMS
      //
      finalList.add(element);
    }

    for (var element in finalList) {
      //
      // REPLACING THE ORIGINAL FILTRED LIST WITH THE FINAL SORTED LIST
      //
      filteredList.add(element);
    }
    setState(() {});
  }

  startFilter(String text) {
    //
    // METHOD FOR THE TEXTFIELD (FILTER)
    //
    for (var element in mainSingleton.assets) {
      if (element.name.toUpperCase().contains(text.toUpperCase())) {
        filteredList.add(element);
      }
    }
    separePriority();
  }

  restartList() {
    //
    //  METHOD TO CLEAR THE FILTERED LIST AND REPLACE WITH THE ORIGINAL ONE
    //
    filteredList.clear();
    for (var element in mainSingleton.assets) {
      filteredList.add(element);
    }
    separePriority();
  }
}

extension StringCasingExtension on String {
  String toCapitalized() =>
      length > 0 ? '${this[0].toUpperCase()}${substring(1).toLowerCase()}' : '';
  String toTitleCase() => replaceAll(RegExp(' +'), ' ')
      .split(' ')
      .map((str) => str.toCapitalized())
      .join(' ');
}
