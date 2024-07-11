import 'package:e_book_admin/model/models.dart';

abstract class BaseMissionRepository {
  Future<List<Mission>?> getAllMissions();

  Future<Mission?> addMission(
    String name,
    String detail,
    int coins,
    String type,
    int times,
  );

  Future<bool> updateMission(
    String id,
    String name,
    String detail,
    int coins,
    String type,
    int times,
  );

  Future<bool> deleteMission(
    String id,
  );
}
