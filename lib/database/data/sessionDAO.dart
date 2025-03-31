import 'package:floor/floor.dart';
import 'session.dart';

@dao
abstract class SessionDao {
  @Query('SELECT * FROM session LIMIT 1')
  Future<Session?> getSession();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> saveSession(Session session);

  @Query('DELETE FROM session')
  Future<void> clearSession();
}
