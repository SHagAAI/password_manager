import 'package:objectbox/objectbox.dart';

@Entity()
class PinModel {
    @Id()
    int id=0;

    PinModel(this.mypin);

    String? mypin;

}