import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


const primaryColor=Color(0xff605858);
const secondaryColor=Color(0xffFFFFFF);
const colorWhite=Color(0xffffffff);
const colorBlack=Color(0xff000000);
const colorBottomnav=Color(0xffC6C6C6);


const storageBucketPath='gs://dzuabry.appspot.com';


String timeAgoSinceDate(String dateString, {bool numericDates = true}) {
DateTime date = DateTime.parse(dateString);
final date2 = DateTime.now();
final difference = date2.difference(date);

if ((difference.inDays / 365).floor() >= 2) {
return '${(difference.inDays / 365).floor()} years ago';
} else if ((difference.inDays / 365).floor() >= 1) {
return (numericDates) ? '1 year ago' : 'Last year';
} else if ((difference.inDays / 30).floor() >= 2) {
return '${(difference.inDays / 365).floor()} months ago';
} else if ((difference.inDays / 30).floor() >= 1) {
return (numericDates) ? '1 month ago' : 'Last month';
} else if ((difference.inDays / 7).floor() >= 2) {
return '${(difference.inDays / 7).floor()} weeks ago';
} else if ((difference.inDays / 7).floor() >= 1) {
return (numericDates) ? '1 week ago' : 'Last week';
} else if (difference.inDays >= 2) {
return '${difference.inDays} days ago';
} else if (difference.inDays >= 1) {
return (numericDates) ? '1 day ago' : 'Yesterday';
} else if (difference.inHours >= 2) {
return '${difference.inHours} hours ago';
} else if (difference.inHours >= 1) {
return (numericDates) ? '1 hour ago' : 'An hour ago';
} else if (difference.inMinutes >= 2) {
return '${difference.inMinutes} minutes ago';
} else if (difference.inMinutes >= 1) {
return (numericDates) ? '1 minute ago' : 'A minute ago';
} else if (difference.inSeconds >= 3) {
return '${difference.inSeconds} seconds ago';
} else {
return 'Just now';
}
}
