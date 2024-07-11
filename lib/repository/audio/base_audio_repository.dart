import 'package:file_picker/file_picker.dart';

abstract class BaseAudioRepository {
  Future<bool> addAudios (String bookId, Map<String, PlatformFile> listChapters);
}