// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';

class JournalModel extends Equatable {
  final String id;
  final String userId;
  final String title;
  final String content;
  final DateTime createdAt;

  const JournalModel({
    required this.id,
    required this.userId,
    required this.title,
    required this.content,
    required this.createdAt,
  });

// ambil dari FBase convert ke dart
  factory JournalModel.fromSnapshot(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return JournalModel(
      id: doc.id,
      userId: data['userId'],
      title: data['title'],
      content: data['content'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'userId': userId,
      'title':title ,
      'content': content,
      'createdAt': Timestamp.fromDate(createdAt),

    };
  }

  @override
  List<Object> get props {
    return [id, userId, title, content, createdAt];
  }
}
