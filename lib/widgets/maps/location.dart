import 'package:flutter/material.dart';
import 'package:map_view/map_view.dart';
import '../../models/url.dart';


class LocationMaps extends StatefulWidget {
  
  final String mapId;
  final String title;
  final double latitude;
  final double longtitude;
  final Color markColor;

  LocationMaps({
    @required this.mapId, 
    @required this.title, 
    @required this.latitude, 
    @required this.longtitude,
    @required this.markColor
  });


  @override
  State<StatefulWidget> createState() {
    return new _LocationMaps();
  }
}

class _LocationMaps extends State<LocationMaps> {
  Uri _staticMapUri;
  MapView mapView = new MapView();
  Marker marker;
 
  void initState() {
    super.initState();
    marker = new Marker(
      widget.mapId, 
      widget.title, 
      widget.latitude, 
      widget.longtitude,
      color: widget.markColor
    );
    getStaticMap();
  }

  void showMap() {
    mapView.show(
        new MapOptions(
            mapViewType: MapViewType.normal,
            showUserLocation: true,
            initialCameraPosition:
                new CameraPosition(new Location(widget.latitude, widget.longtitude), 14.0),
            title: widget.title),
        toolbarActions: [new ToolbarAction("Close", 1)]);

    mapView.onMapReady.listen((_) {
      mapView.addMarker(marker);
    });

    mapView.onToolbarAction.listen((id) {
      if (id == 1) {
        mapView.dismiss();
      }
    });
  }

  void getStaticMap() {
    //AIzaSyALkC9gj4v6GN0UOmJdEw9MtpYjAC6U6O0
    final StaticMapProvider staticMapProvider = new StaticMapProvider(Url.apiKeyStaticMap);
    final Uri staticMapUri = staticMapProvider.getStaticUriWithMarkers([marker],
        height: 500, maptype: StaticMapViewType.roadmap);
    setState(() {
      _staticMapUri = staticMapUri;
     
    });
  }

  @override
  Widget build(BuildContext context) {
    return new InkWell(
      child: FadeInImage(
        image: NetworkImage(_staticMapUri.toString()),
        placeholder: AssetImage(Url.noImage),
        fit: BoxFit.contain,
      ),
      onTap: showMap,
    );
  }
}
