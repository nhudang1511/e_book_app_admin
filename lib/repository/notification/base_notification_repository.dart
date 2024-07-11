abstract class BaseNotificationRepository {
  Future sendNotificationAll(String title, String body);
  Future sendNotification(String uId);
}