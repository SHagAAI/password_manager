import 'package:objectbox/objectbox.dart';

@Entity()
class MyAccount {
  @Id()
  int id  = 0;

  String? title;
  String? loginUsername;
  String? password;

  MyAccount(this.title, this.loginUsername, this.password);
}