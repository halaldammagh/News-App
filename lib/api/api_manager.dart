import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/model/source_response.dart';

class ApiManager {
  static Future<SourceResponse> getSources(String categoryId) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      EndPoints.sourceApi,
      {
        'apiKey': ApiConstants.apiKey,
        'category': categoryId,
      },
    );

    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return SourceResponse.fromJson(json);
    } catch (e) {
      rethrow;
      /*تخيّلي الخطأ ورقة مكتوب عليها:
وين صار الخطأ + تفاصيله.

✅ rethrow

بيرجع نفس الورقة نفسها للأعلى.
يعني بيحافظ على مكان الخطأ الأصلي (الـ stack trace الأصلي).

استخدميه لما بدك تسجّلي الخطأ أو تعملي شي وبعدين تتركيه يطلع لفوق بدون ما تغيّريه.

✅ throw

بتاخدي الخطأ وبترميه من جديد (كأنه صار هلأ).
أحياناً بيبين كأن الخطأ صار داخل catch مو بالمكان الحقيقي.

استخدميه لما بدك ترمي خطأ جديد أو تغيّري نوعه/رسالة الخطأ.*/

    }
  }

  // ✅ البحث الصحيح (everything + q) ويرجع NewsResponse
  static Future<NewsResponse> searchNews(String query) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      EndPoints.newsApi, // أو EndPoints.everythingApi
      {
        'apiKey': ApiConstants.apiKey,
        'q': query,
      },
    );

    try {
      var response = await http.get(url);
      var json = jsonDecode(response.body);
      return NewsResponse.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }

  static Future<NewsResponse> getNewsBySourceId(String sourceId, {int page = 1 ,  int pageSize = 10,
  }) async {
    Uri url = Uri.https(
      ApiConstants.baseUrl,
      EndPoints.newsApi,
      {
        'apiKey': ApiConstants.apiKey,
        'sources': sourceId,
        'page': '$page',
        'pageSize': '$pageSize',
      },
    );

    var response = await http.get(url);
    var json = jsonDecode(response.body);
    return NewsResponse.fromJson(json);
  }
}


