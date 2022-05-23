import 'package:aqaratak/widgets/Image_PDF_Video_Fields.dart';
import 'package:aqaratak/widgets/Nearest_locations_Fields.dart';
import 'package:flutter/cupertino.dart';

class StateManagerProvider with ChangeNotifier {
  List<LocationAndDistanceBlock> _locationAndDistanceBlocks = [];
  List<ImageBlock> _imagesBlocks = [];

  List<LocationAndDistanceBlock> get locationAndDistanceBlocks =>
      [..._locationAndDistanceBlocks];
  List<ImageBlock> get imagesBlocks => [..._imagesBlocks];

  void add_location_And_Distance_Block(LocationAndDistanceBlock block) {
    _locationAndDistanceBlocks.add(block);
    notifyListeners();
  }

  void remove_location_And_Distance_Block(int index) {
    _locationAndDistanceBlocks.removeAt(index);
    notifyListeners();
  }

  void add_image_Block(
    ImageBlock block,
  ) {
    _imagesBlocks.add(block);
    notifyListeners();
  }

  void remove_image_Block(int index) {
    _imagesBlocks.removeAt(index);
    notifyListeners();
  }

  void cleareData() {
    _imagesBlocks = [];
    _locationAndDistanceBlocks = [];
  }
}
