abstract class BaseNotificationRepository {
  Future sendNotificationAll(String title, String body);
  Future<bool> sendNotification(String uId,String title, String body);
}