// lib/factories/crop_disease_factory.dart
import '../models/disease_model.dart';
import '../handlers/crop_disease_handler.dart';
import '../crops/rice_disease.dart';
import '../crops/wheat_disease.dart';
import '../crops/maize_disease.dart';
import '../crops/potato_disease.dart';
import '../crops/tomato_disease.dart';
import '../crops/soybean_disease.dart';
import '../crops/orange_disease.dart';
import '../crops/apple_disease.dart';
import '../crops/mango_disease.dart';
import '../crops/unknown_disease.dart';

class CropDiseaseFactory {
  static final Map<int, CropDiseaseHandler> _handlers = {
    0: RiceDiseaseHandler(),
    1: WheatDiseaseHandler(),
    2: MaizeDiseaseHandler(),
    3: PotatoDiseaseHandler(),
    4: TomatoDiseaseHandler(),
    5: SoybeanDiseaseHandler(),
    6: OrangeDiseaseHandler(),
    7: AppleDiseaseHandler(),
    8: MangoDiseaseHandler(),
  };

  static DiseaseModel createDisease(int prediction, int cropId) {
    final handler = _handlers[cropId];
    if (handler == null) {
      return UnknownDiseaseHandler().createDisease(prediction, cropId);
    }
    return handler.createDisease(prediction, cropId);
  }
}
