
import '../model/base_model.dart';
import '../services/api_constanta.dart';

final BaseModel SERVER_NOT_WORKING = BaseModel(
  code: 123,
  message: "server vaqtincha ishlamayapti, iltimos qaytadan urinib ko\'ring",
);

getUserToken() async {
  return 'Bearer ${ApiConstanta.USER_TEST_TOKEN}';
}
