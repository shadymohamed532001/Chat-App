
import '../constans.dart';

class MassageModel{
 final String? Massage ;
 final String? Id;

  MassageModel({required this.Massage,required this.Id});

  factory MassageModel.FromJson(JsonData)
  {
    return MassageModel(
        Massage : JsonData[Kmassage],
      Id: JsonData['id']
    );
  }
}