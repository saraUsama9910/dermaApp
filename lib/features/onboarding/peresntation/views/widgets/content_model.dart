import 'package:graduation/core/utils/image_constants.dart';

class UnbordingContent {
  String image;
  String title;
  String discription;

  UnbordingContent(
      {required this.image, required this.title, required this.discription});
}

List<UnbordingContent> contents = [
  UnbordingContent(
      title: 'Welcome to Our Community',
      image: ImageConstants.onlineWorld,
      discription: """you will have multi options here"""),
  UnbordingContent(
      title: 'Scan Your Skin',
      image: ImageConstants.scanSkin,
      discription:
          """effective solution for individuals to monitor skin health proactively"""),
  UnbordingContent(
      title: 'Info About Diseases',
      image: ImageConstants.medicalPrescription,
      discription:
          """It helps you learn about many common skin diseases and how to prevent or treat them """),
];
