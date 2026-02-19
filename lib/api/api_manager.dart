import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:news_app/api/api_constants.dart';
import 'package:news_app/api/end_points.dart';
import 'package:news_app/model/news_response.dart';
import 'package:news_app/model/source_response.dart';

class ApiManager {
  /*https://newsapi.org/v2/top-headlines/sources?apiKey=cf44892e9570475e9f3f85d5a845d682 */
  static Future<SourceResponse> getSources(String categoryId)async{
    Uri url = Uri.https(ApiConstants.baseUrl,EndPoints.sourceApi, {
      'apiKey': ApiConstants.apiKey,
      'category' : categoryId

    }
    );
    try{
      var response =  await http.get(url);
    var responseBody = response.body; ///String
    /// String => json
    var json =  jsonDecode(responseBody);
    /// json => object
    return SourceResponse.fromJson(json);

    // return SourceResponse.fromJson(jsonDecode(response.body));
    // هاد اختصار للاربع سطور الي فوق
    }catch(e){
       rethrow ;
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

  /* https://newsapi.org/v2/everything?q=bitcoin&apiKey=cf44892e9570475e9f3f85d5a845d682*/
  static Future<NewsResponse> getNewsBySourceId(String sourceId)async{
  Uri url = Uri.https(ApiConstants.baseUrl, EndPoints.newsApi,
      {'apiKey':ApiConstants.apiKey,
        'sources':sourceId
      });
  var response = await http.get(url);
  var responseBody = response.body;
  var json = jsonDecode(responseBody);
  return NewsResponse.fromJson( json);
  }
}


