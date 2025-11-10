class LiveStreamModel {
  int? statusCode;
  List<Data>? data;
  int? count;

  LiveStreamModel({this.statusCode, this.data, this.count});

  LiveStreamModel.fromJson(Map<String, dynamic> json) {
    statusCode = json['statusCode'];
    if (json['data'] != null) {
      data = <Data>[];
      json['data'].forEach((v) {
        data!.add(Data.fromJson(v));
      });
    }
    count = json['count'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['statusCode'] = statusCode;
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    data['count'] = count;
    return data;
  }
}

class Data {
  String? id;
  String? name;
  String? description;
  List<String>? language;
  String? startTime;
  dynamic? streamStartedAt;
  Thumbnail? thumbnail;
  String? lectureType;
  dynamic? lectureUploadType;
  String? lectureStatus;
  String? ostelloListingStatus;
  dynamic? ostelloListingRemarks;
  int? score;
  int? commentCount;
  String? category;
  List<String>? topics;
  bool? isDemo;
  bool? streamOnYoutube;
  String? youtubeLivestreamPrivacy;
  dynamic? youtubeLivestreamId;
  dynamic? youtubeLivestreamRtmpIngestionUrl;
  bool? getStreamInteractiveLivestream;
  String? getStreamLivestreamId;
  String? meetingLink;
  String? meetingPasscode;
  bool? getstreamChatEnabled;
  int? sectionIndex;
  bool? recordedLectureAvailable;
  bool? transcriptAvailable;
  bool? summaryAvailable;
  int? videoDuration;
  bool? videoProcessing;
  int? viewCount;
  String? createdAt;
  String? updatedAt;
  dynamic? deletedAt;
  List<dynamic>? attendance;
  List<dynamic>? notification;
  List<dynamic>? view;
  dynamic? onlineCourse;
  List<Faculty>? faculty;
  Institute? institute;
  List<dynamic>? content;
  AcademicLectureDetails? academicLectureDetails;
  SkillLectureDetails? skillLectureDetails;
  dynamic? competitiveExamLectureDetails;
  dynamic? onlineCourseSection;

  Data(
      {this.id,
        this.name,
        this.description,
        this.language,
        this.startTime,
        this.streamStartedAt,
        this.thumbnail,
        this.lectureType,
        this.lectureUploadType,
        this.lectureStatus,
        this.ostelloListingStatus,
        this.ostelloListingRemarks,
        this.score,
        this.commentCount,
        this.category,
        this.topics,
        this.isDemo,
        this.streamOnYoutube,
        this.youtubeLivestreamPrivacy,
        this.youtubeLivestreamId,
        this.youtubeLivestreamRtmpIngestionUrl,
        this.getStreamInteractiveLivestream,
        this.getStreamLivestreamId,
        this.meetingLink,
        this.meetingPasscode,
        this.getstreamChatEnabled,
        this.sectionIndex,
        this.recordedLectureAvailable,
        this.transcriptAvailable,
        this.summaryAvailable,
        this.videoDuration,
        this.videoProcessing,
        this.viewCount,
        this.createdAt,
        this.updatedAt,
        this.deletedAt,
        this.attendance,
        this.notification,
        this.view,
        this.onlineCourse,
        this.faculty,
        this.institute,
        this.content,
        this.academicLectureDetails,
        this.skillLectureDetails,
        this.competitiveExamLectureDetails,
        this.onlineCourseSection});

  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    description = json['description'];
    language = json['language'].cast<String>();
    startTime = json['start_time'];
    streamStartedAt = json['stream_started_at'];
    thumbnail = json['thumbnail'] != null
        ? Thumbnail.fromJson(json['thumbnail'])
        : null;
    lectureType = json['lecture_type'];
    lectureUploadType = json['lecture_upload_type'];
    lectureStatus = json['lecture_status'];
    ostelloListingStatus = json['ostello_listing_status'];
    ostelloListingRemarks = json['ostello_listing_remarks'];
    score = json['score'];
    commentCount = json['comment_count'];
    category = json['category'];
    topics = json['topics'].cast<String>();
    isDemo = json['is_demo'];
    streamOnYoutube = json['stream_on_youtube'];
    youtubeLivestreamPrivacy = json['youtube_livestream_privacy'];
    youtubeLivestreamId = json['youtube_livestream_id'];
    youtubeLivestreamRtmpIngestionUrl =
    json['youtube_livestream_rtmp_ingestion_url'];
    getStreamInteractiveLivestream = json['get_stream_interactive_livestream'];
    getStreamLivestreamId = json['get_stream_livestream_id'];
    meetingLink = json['meeting_link'];
    meetingPasscode = json['meeting_passcode'];
    getstreamChatEnabled = json['getstream_chat_enabled'];
    sectionIndex = json['section_index'];
    recordedLectureAvailable = json['recorded_lecture_available'];
    transcriptAvailable = json['transcript_available'];
    summaryAvailable = json['summary_available'];
    videoDuration = json['video_duration'];
    videoProcessing = json['video_processing'];
    viewCount = json['view_count'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    deletedAt = json['deleted_at'];
    if (json['attendance'] != null) {
      attendance = <dynamic>[];
      json['attendance'].forEach((v) {
       // attendance!.add(new dynamic.fromJson(v));
      });
    }
    if (json['notification'] != null) {
      notification = <dynamic>[];
      json['notification'].forEach((v) {
       // notification!.add(new dynamic.fromJson(v));
      });
    }
    if (json['view'] != null) {
      view = <dynamic>[];
      json['view'].forEach((v) {
       // view!.add(new dynamic.fromJson(v));
      });
    }
    onlineCourse = json['online_course'];
    if (json['faculty'] != null) {
      faculty = <Faculty>[];
      json['faculty'].forEach((v) {
        faculty!.add(Faculty.fromJson(v));
      });
    }
    institute = json['institute'] != null
        ? Institute.fromJson(json['institute'])
        : null;
    if (json['content'] != null) {
      content = <dynamic>[];
      json['content'].forEach((v) {
       // content!.add(new dynamic.fromJson(v));
      });
    }
    academicLectureDetails = json['academic_lecture_details'] != null
        ? AcademicLectureDetails.fromJson(json['academic_lecture_details'])
        : null;
    skillLectureDetails = json['skill_lecture_details'] != null
        ? SkillLectureDetails.fromJson(json['skill_lecture_details'])
        : null;
    competitiveExamLectureDetails = json['competitive_exam_lecture_details'];
    onlineCourseSection = json['online_course_section'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['description'] = description;
    data['language'] = language;
    data['start_time'] = startTime;
    data['stream_started_at'] = streamStartedAt;
    if (thumbnail != null) {
      data['thumbnail'] = thumbnail!.toJson();
    }
    data['lecture_type'] = lectureType;
    data['lecture_upload_type'] = lectureUploadType;
    data['lecture_status'] = lectureStatus;
    data['ostello_listing_status'] = ostelloListingStatus;
    data['ostello_listing_remarks'] = ostelloListingRemarks;
    data['score'] = score;
    data['comment_count'] = commentCount;
    data['category'] = category;
    data['topics'] = topics;
    data['is_demo'] = isDemo;
    data['stream_on_youtube'] = streamOnYoutube;
    data['youtube_livestream_privacy'] = youtubeLivestreamPrivacy;
    data['youtube_livestream_id'] = youtubeLivestreamId;
    data['youtube_livestream_rtmp_ingestion_url'] =
        youtubeLivestreamRtmpIngestionUrl;
    data['get_stream_interactive_livestream'] =
        getStreamInteractiveLivestream;
    data['get_stream_livestream_id'] = getStreamLivestreamId;
    data['meeting_link'] = meetingLink;
    data['meeting_passcode'] = meetingPasscode;
    data['getstream_chat_enabled'] = getstreamChatEnabled;
    data['section_index'] = sectionIndex;
    data['recorded_lecture_available'] = recordedLectureAvailable;
    data['transcript_available'] = transcriptAvailable;
    data['summary_available'] = summaryAvailable;
    data['video_duration'] = videoDuration;
    data['video_processing'] = videoProcessing;
    data['view_count'] = viewCount;
    data['created_at'] = createdAt;
    data['updated_at'] = updatedAt;
    data['deleted_at'] = deletedAt;
    if (attendance != null) {
      data['attendance'] = attendance!.map((v) => v.toJson()).toList();
    }
    if (notification != null) {
      data['notification'] = notification!.map((v) => v.toJson()).toList();
    }
    if (view != null) {
      data['view'] = view!.map((v) => v.toJson()).toList();
    }
    data['online_course'] = onlineCourse;
    if (faculty != null) {
      data['faculty'] = faculty!.map((v) => v.toJson()).toList();
    }
    if (institute != null) {
      data['institute'] = institute!.toJson();
    }
    if (content != null) {
      data['content'] = content!.map((v) => v.toJson()).toList();
    }
    if (academicLectureDetails != null) {
      data['academic_lecture_details'] = academicLectureDetails!.toJson();
    }
    if (skillLectureDetails != null) {
      data['skill_lecture_details'] = skillLectureDetails!.toJson();
    }
    data['competitive_exam_lecture_details'] =
        competitiveExamLectureDetails;
    data['online_course_section'] = onlineCourseSection;
    return data;
  }
}

class Thumbnail {
  String? url;
  String? key;

  Thumbnail({this.url, this.key});

  Thumbnail.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['key'] = key;
    return data;
  }
}

class Faculty {
  String? id;
  String? name;
  String? email;
  String? description;
  List<Images>? images;
  List<dynamic>? videos;
  String? position;
  List<String>? subjects;

  Faculty(
      {this.id,
        this.name,
        this.email,
        this.description,
        this.images,
        this.videos,
        this.position,
        this.subjects});

  Faculty.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    email = json['email'];
    description = json['description'];
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
    if (json['videos'] != null) {
      videos = <dynamic>[];
      json['videos'].forEach((v) {
       // videos!.add(new dynamic.fromJson(v));
      });
    }
    position = json['position'];
    subjects = json['subjects'].cast<String>();
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['email'] = email;
    data['description'] = description;
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    if (videos != null) {
      data['videos'] = videos!.map((v) => v.toJson()).toList();
    }
    data['position'] = position;
    data['subjects'] = subjects;
    return data;
  }
}

class Institute {
  String? id;
  String? name;
  List<Avatar>? avatar;
  List<Images>? images;

  Institute({this.id, this.name, this.avatar, this.images});

  Institute.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    if (json['avatar'] != null) {
      avatar = <Avatar>[];
      json['avatar'].forEach((v) {
        avatar!.add(Avatar.fromJson(v));
      });
    }
    if (json['images'] != null) {
      images = <Images>[];
      json['images'].forEach((v) {
        images!.add(Images.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    if (avatar != null) {
      data['avatar'] = avatar!.map((v) => v.toJson()).toList();
    }
    if (images != null) {
      data['images'] = images!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Images {
  String? host;
  String? url;
  String? key;

  Images({this.host, this.url, this.key});

  Images.fromJson(Map<String, dynamic> json) {
    host = json['host'];
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['host'] = host;
    data['url'] = url;
    data['key'] = key;
    return data;
  }
}
class Avatar {
  String? url;
  String? key;

  Avatar({ this.url, this.key});

  Avatar.fromJson(Map<String, dynamic> json) {
    url = json['url'];
    key = json['key'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['url'] = url;
    data['key'] = key;
    return data;
  }
}

class AcademicLectureDetails {
  String? id;
  List<String>? academicClass;
  List<String>? academicBoards;
  List<String>? academicStream;
  List<String>? academicSubjects;
  dynamic? deletedAt;

  AcademicLectureDetails(
      {this.id,
        this.academicClass,
        this.academicBoards,
        this.academicStream,
        this.academicSubjects,
        this.deletedAt});

  AcademicLectureDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    academicClass = json['academic_class'].cast<String>();
    academicBoards = json['academic_boards'].cast<String>();
    academicStream = json['academic_stream'].cast<String>();
    academicSubjects = json['academic_subjects'].cast<String>();
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['academic_class'] = academicClass;
    data['academic_boards'] = academicBoards;
    data['academic_stream'] = academicStream;
    data['academic_subjects'] = academicSubjects;
    data['deleted_at'] = deletedAt;
    return data;
  }
}

class SkillLectureDetails {
  String? id;
  List<String>? skillDomain;
  List<String>? skillName;
  dynamic? deletedAt;

  SkillLectureDetails(
      {this.id, this.skillDomain, this.skillName, this.deletedAt});

  SkillLectureDetails.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    skillDomain = json['skill_domain'].cast<String>();
    skillName = json['skill_name'].cast<String>();
    deletedAt = json['deleted_at'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['skill_domain'] = skillDomain;
    data['skill_name'] = skillName;
    data['deleted_at'] = deletedAt;
    return data;
  }
}