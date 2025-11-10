// data/remote/live_stream_api.dart
import 'package:dio/dio.dart';

import '../model/live_stream_model.dart';

class LiveStreamApi {
  final Dio _dio;
  final String _baseUrl = 'https://api2.ostello.co.in/onlineCourses/lecture';
  final String _token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIyMGU0MDJmLTAyY2ItNDhjYi04OTUxLWJiNzAzMmQ4ZDgzZSIsIm5hbWUiOiJTaGFoYmF6IiwiZW1haWwiOiJ0c2Rhc2Rlc3QyQGdtYWlsLmNvbSIsInVzZXJ0eXBlIjozLCJwaG9uZW51bWJlciI6IjczOTgzNTgwMTIiLCJpYXQiOjE3NjI1OTQ4NTUsImV4cCI6MTc2MjY4MTI1NX0.J4DMr7svBo1mKA1iPXCoGgdHzcteRIyQlY1s3_nIbEM'; // Replace with a dynamic token

  LiveStreamApi(this._dio);

  Future<List<LiveStreamModel>> fetchStreams() async {
    try {
      final response = await _dio.get(
        _baseUrl,
        queryParameters: {
          'limit': 10,
          'skip': 0,
          'order_by': 'start_time',
          'order': 'DESC',
          'lecture_type': 'open_live',
          'lecture_status': 'live',
          'is_get_stream_interactive_livestream': true,
        },
        options: Options(headers: {'Authorization': _token}),
      );

      // Assuming the list of streams is under a key like 'data' or 'lectures'
      final List data = response.data['data']['lectures'] ?? [];

      return data.map((json) => LiveStreamModel.fromJson(json)).toList();
    } catch (e) {
      LiveStreamModel model = LiveStreamModel(
        streamId: "livestream-b941303c-9953-49c6-8ce4-87eff5835688",
        userId: "220e402f-02cb-48cb-8951-bb7032d8d83e",
        streamType: "streaming",
        title: "T1",
      );
      LiveStreamModel model2 = LiveStreamModel(
        streamId: "livestream-e45fef34-5500-4fdd-9560-95ecd9003175",
        userId: "220e402f-02cb-48cb-8951-bb7032d8d83e",
        streamType: "streaming",
        title: "T2",
      );
      List<LiveStreamModel> list = [];
      list.add(model);
      list.add(model2);
      // throw Exception('Failed to fetch streams: $e');
      return list;
    }
  }
}
