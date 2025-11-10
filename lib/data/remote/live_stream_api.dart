// data/remote/live_stream_api.dart
import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/live_stream_model.dart';

class LiveStreamApi {
  final Dio _dio;
  final String _baseUrl = 'https://api2.ostello.co.in/onlineCourses/lecture';
  final String _token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjIyMGU0MDJmLTAyY2ItNDhjYi04OTUxLWJiNzAzMmQ4ZDgzZSIsIm5hbWUiOiJTaGFoYmF6IiwiZW1haWwiOiJ0c2Rhc2Rlc3QyQGdtYWlsLmNvbSIsInVzZXJ0eXBlIjozLCJwaG9uZW51bWJlciI6IjczOTgzNTgwMTIiLCJpYXQiOjE3NjI3NzI4NDAsImV4cCI6MTc2Mjg1OTI0MH0.UgO-_wHnrqTbwC_Cvo15G1Jx7WgiF8mNN-jfz4xdXNA'; // Replace with a dynamic token

  LiveStreamApi(this._dio);

  Future<List<Data>> fetchStreams() async {
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
     // final List data = response.data['data']['lectures'] ?? [];
      LiveStreamModel model=LiveStreamModel.fromJson(response.data);

      return model.data??[];
    } catch (e) {
       throw Exception('Failed to fetch streams: $e');
    }
  }
}
