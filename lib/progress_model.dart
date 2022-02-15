import 'dart:typed_data';

class ProgressModel {
  late final List<int> numberOfVideos;

  ProgressModel({
    required int janNumberOfVideos,
    required int febNumberOfVideos,
    required int marNumberOfVideos,
    required int aprNumberOfVideos,
    required int mayNumberOfVideos,
    required int junNumberOfVideos,
    required int julNumberOfVideos,
    required int augNumberOfVideos,
    required int sepNumberOfVideos,
    required int octNumberOfVideos,
    required int novNumberOfVideos,
    required int decNumberOfVideos,
  }) {
    Uint32List temp = Uint32List(12);
    temp[0] = janNumberOfVideos;
    temp[1] = febNumberOfVideos;
    temp[2] = marNumberOfVideos;
    temp[3] = aprNumberOfVideos;
    temp[4] = mayNumberOfVideos;
    temp[5] = junNumberOfVideos;
    temp[6] = julNumberOfVideos;
    temp[7] = augNumberOfVideos;
    temp[8] = sepNumberOfVideos;
    temp[9] = octNumberOfVideos;
    temp[10] = novNumberOfVideos;
    temp[11] = decNumberOfVideos;
    numberOfVideos = UnmodifiableUint32ListView(temp);
  }
}
