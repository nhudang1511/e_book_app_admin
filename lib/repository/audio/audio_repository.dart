import 'package:e_book_admin/config/share_preferences.dart';
import 'package:e_book_admin/repository/audio/base_audio_repository.dart';
import 'package:e_book_admin/utils/utils.dart';
import 'package:file_picker/file_picker.dart';

import 'package:http/http.dart' as http;

class AudioRepository extends BaseAudioRepository {
  static var client = http.Client();

  @override
  Future<bool> addAudios(
      String bookId, Map<String, PlatformFile> listChapters) async {
    var url = Uri.https(Config.apiURL, '${Config.API}/audio/add');
    var request = http.MultipartRequest('POST', url);
    request.fields['bookId'] = bookId;
    for (String chapter in listChapters.keys) {
      http.MultipartFile reviewFile = http.MultipartFile.fromBytes(
        chapter,
        listChapters[chapter]!.bytes!.cast(),
        filename: listChapters[chapter]!.name, // Đặt tên cho file review
      );
      request.files.add(reviewFile);
    }
    request.headers['Authorization'] = 'Bearer ${SharedService.getToken()}';
    request.headers['Content-Type'] = 'multipart/form-data';
    var response = await request.send();
    var multipartResponseData = await http.Response.fromStream(response);
    if (multipartResponseData.statusCode == 201) {
      return true;
    } else {
      return false;
    }
  }
}
