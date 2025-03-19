import 'package:floor/floor.dart';

@Entity(tableName: 'session')
class Session {
  @primaryKey
  final String phoneNumber;

  Session(this.phoneNumber);
}
