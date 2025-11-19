// data/remote/live_stream_api.dart
import 'dart:convert';

import 'package:dio/dio.dart';

import '../model/live_stream_model.dart';

class LiveStreamApi {
  final Dio _dio;
  final String _baseUrl = 'https://api2.ostello.co.in/onlineCourses/lecture';
  final String _token =
      'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpZCI6IjU1MzIwYTgxLTk4NmUtNDkyMi04YWM4LWEyYmVkOGI5MTQ4OSIsIm5hbWUiOiJSaXlheiBBbGkiLCJlbWFpbCI6bnVsbCwidXNlcnR5cGUiOjMsInBob25lbnVtYmVyIjoiODg0NzYxMzYxOCIsImlhdCI6MTc2MzM2OTUyNiwiZXhwIjoxNzYzNDU1OTI2fQ.jkkxwem9TPMCRqwrgmI-jxJ-BAkg-u-fwEbuD2ISlhE'; // Replace with a dynamic token

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
      print(response.data);

      // Assuming the list of streams is under a key like 'data' or 'lectures'
     // final List data = response.data['data']['lectures'] ?? [];
      LiveStreamModel model=LiveStreamModel.fromJson(response.data);

      return model.data??[];
    } catch (e) {
      print('Failed to fetch streams: $e');
      throw Exception('Failed to fetch streams: $e');
    }
  }
}
