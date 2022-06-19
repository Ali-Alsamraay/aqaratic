import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../../helper/constants.dart';
import '../../../providers/Maps_Provider.dart';
import '../../../providers/Properties_provider.dart';
import 'Categories_On_Map.dart';

class MapTab extends StatefulWidget {
  MapTab({
    Key? key,
    required this.categoryId,
  }) : super(key: key);
  final int? categoryId;

  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  MapType? mapType = MapType.terrain;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        backgroundColor: accentColorBrown,
        child: Icon(
          mapType == MapType.satellite ? Icons.satellite_alt : Icons.terrain,
        ),
        onPressed: () async {
          if (mapType == MapType.terrain) {
            setState(() {
              mapType = MapType.satellite;
            });
          } else {
            setState(() {
              mapType = MapType.terrain;
            });
          }
        },
      ),
      body: Stack(
        alignment: Alignment.topCenter,
        children: <Widget>[
          FutureBuilder(
            future: Provider.of<MapsProvider>(context, listen: false)
                .get_markers_for_category_on_map(
              widget.categoryId,
              Provider.of<PropertiesProvider>(context, listen: false)
                  .properties,
              context,
            ),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(
                  child: CircularProgressIndicator.adaptive(),
                );
              } else if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error == null) {
                  return GoogleMap(
                    mapType: mapType!,
                    mapToolbarEnabled: true,
                    trafficEnabled: true,
                    myLocationButtonEnabled: true,
                    onMapCreated: (controller) {
                      Provider.of<MapsProvider>(context, listen: false)
                          .setMapController(
                        controller,
                      );
                    },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(24.7136, 46.6753),
                      zoom: 4.5,
                    ),
                    markers: Provider.of<MapsProvider>(
                      context,
                      listen: false,
                    ).markers,
                  );
                } else if (snapshot.error != null) {
                  return Text("There is an error");
                } else {
                  return AlertDialog(
                    content: Text('State: ${snapshot.connectionState}'),
                  );
                }
              }
              return Text("no data");
            },
          ),
          CategoriesOnMap(),
        ],
      ),
    );
  }
}

