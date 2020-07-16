import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:http/http.dart' as http;
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// Custom Implementation of CacheManager
// by extending the BaseCacheManager abstract class
class MyCacheManager extends BaseCacheManager {
  static const key = "customCache";

  static MyCacheManager _instance;

  // singleton implementation
  // for the custom cache manager
  factory MyCacheManager() {
    if (_instance == null) {
      _instance = new MyCacheManager._();
    }
    return _instance;
  }

  // pass the default setting values to the base class
  // link the custom handler to handle HTTP calls
  // via the custom cache manager
  MyCacheManager._()
      : super(key,
            maxAgeCacheObject: Duration(days: 15),
            maxNrOfCacheObjects: 1000,
            fileFetcher: _myHttpGetter);

  @override
  Future<String> getFilePath() async {
    var directory = await getTemporaryDirectory();
    return path.join(directory.path, key);
  }

  static Future<FileFetcherResponse> _myHttpGetter(String url,
      {Map<String, String> headers}) async {
    HttpFileFetcherResponse response;
    // Do things with headers, the url or whatever.
    try {
      var res = await http.get(url, headers: headers);
      // add a custom response header
      // to regulate the caching time
      // when the server doesn't provide cache-control
      res.headers.addAll({'cache-control': 'private, max-age=120'});
      response = HttpFileFetcherResponse(res);
    } on SocketException {
      print('No internet connection');
    }
    return response;
  }
}
