
import '../constans.dart';

class MassageModel{
 final String? Massage ;

  MassageModel({required this.Massage});

  factory MassageModel.FromJson(JsonData)
  {
    return MassageModel(
        Massage : JsonData[Kmassage]
    );
  }
}