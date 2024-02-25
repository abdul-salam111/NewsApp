import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:velocity_x/velocity_x.dart';

class NewsDetailsScreen extends StatelessWidget {
  const NewsDetailsScreen(
      {super.key,
      required this.newsImage,
      required this.channelName,
      required this.uploadedTime,
      required this.title,
      required this.details,required this.content});
  final String newsImage;
  final String channelName;
  final String uploadedTime;
  final String title;
  final String details;
  final String content;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: Colors.black),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.only(left: 8.0, right: 8, top: 10),
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: CachedNetworkImage(
                  imageUrl: newsImage,
                  height: 300.h,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
              10.heightBox,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    channelName,
                    style: GoogleFonts.montserrat(
                        color: Colors.blue, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    uploadedTime,
                    style: GoogleFonts.montserrat(
                        color: Colors.black, fontSize: 12.sp),
                  )
                ],
              ),
              10.heightBox,
              Text(
                title,
                textAlign: TextAlign.justify,
                style: GoogleFonts.montserrat(
                    color: Colors.black,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold),
              ),
              10.heightBox,
              Text(
                details,
                textAlign: TextAlign.justify,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              ),
               Text(
                content,
                textAlign: TextAlign.justify,
                style: GoogleFonts.roboto(
                  color: Colors.black,
                  fontSize: 15.sp,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
