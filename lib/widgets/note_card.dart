import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:shared_prefernces/screens/home/screen/note_editor.dart';
import 'package:shared_prefernces/style/app_style.dart';

Widget noteCard(Function()? onTap, QueryDocumentSnapshot doc) {
  return InkWell(
    onTap: onTap,
    child: Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppStyle.cardsColor[doc['color_id']],
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            doc['note_title'],
            style: AppStyle.mainTitle,
          ),
          const SizedBox(height: 4),
          Text(
            doc['creation_date'],
            style: AppStyle.dateTitle,
          ),
          const SizedBox(height: 8),
          Text(
            doc['note_content'],
            style: AppStyle.mainContent,
            overflow: TextOverflow.ellipsis,
          ),
          const Spacer(),
        ],
      ),
    ),
  );
}
