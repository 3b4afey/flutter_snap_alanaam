import 'package:flutter/material.dart';
import 'package:flutter_snap_alanaam/features/comments/comment/comment.dart';
import 'package:shared/shared.dart';
import 'package:snap_blocks/snap_blocks.dart';

class RepliedComment extends StatelessWidget {
  const RepliedComment({
    required this.comment,
    required this.post,
    super.key,
  });

  final Comment comment;
  final PostBlock post;

  @override
  Widget build(BuildContext context) {
    return CommentView(isReplied: true, post: post, comment: comment);
  }
}
