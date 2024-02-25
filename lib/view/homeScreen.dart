import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/Data/response/status.dart';
import 'package:newsapp/view/categoriesScreen.dart';
import 'package:newsapp/view/newsDetailsScreen.dart';
import 'package:newsapp/viewModels/homeViewModel.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as formate;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

enum NewsChannel {
  bbcNews,
  aryNews,
  independent,
  reuters,
  cnn,
  alJazeera,
  cbcNews
}

class _HomeScreenState extends State<HomeScreen> {
  final homeviewmodel = HomeViewModel();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeviewmodel.getHeadlineNews(name);
    homeviewmodel.getcategoryNews('general');
  }

  NewsChannel? selectedChannel = NewsChannel.bbcNews;
  String name = "bbc-news";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          leading: const Icon(
            Icons.list,
            color: Colors.black,
          ).onTap(() {Get.to(()=> CategoryScreen());}),
          actions: [
            PopupMenuButton<NewsChannel>(
                onSelected: (NewsChannel item) {
                  if (NewsChannel.bbcNews.name == item.name) {
                    name = 'bbc-news';
                  } else if (NewsChannel.aryNews.name == item.name) {
                    name = 'ary-news';
                  } else if (NewsChannel.alJazeera.name == item.name) {
                    name = 'al-jazeera-english';
                  } else if (NewsChannel.cnn.name == item.name) {
                    name = 'cnn';
                  } else if (NewsChannel.cbcNews.name == item.name) {
                    name = 'cbc-news';
                  } else if (NewsChannel.independent.name == item.name) {
                    name = 'independents';
                  }
                  setState(() {
                    homeviewmodel.getHeadlineNews(name);
                    selectedChannel = item;
                  });
                },
                icon: const Icon(
                  Icons.more_vert,
                  color: Colors.black,
                ),
                initialValue: selectedChannel,
                itemBuilder: (contxt) => <PopupMenuEntry<NewsChannel>>[
                      const PopupMenuItem(
                        value: NewsChannel.bbcNews,
                        child: Text(
                          "BBC News",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const PopupMenuItem(
                        value: NewsChannel.aryNews,
                        child: Text(
                          "ary-news",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const PopupMenuItem(
                        value: NewsChannel.alJazeera,
                        child: Text(
                          "alJazeera",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const PopupMenuItem(
                        value: NewsChannel.cnn,
                        child: Text(
                          "cnn",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const PopupMenuItem(
                        value: NewsChannel.independent,
                        child: Text(
                          "independent",
                          style: TextStyle(color: Colors.black),
                        ),
                      ),
                      const PopupMenuItem(
                        value: NewsChannel.cbcNews,
                        child: Text(
                          "cbc-news",
                          style: TextStyle(color: Colors.black),
                        ),
                      )
                    ])
          ],
          automaticallyImplyLeading: false,
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          title: Text(
            "News",
            style: GoogleFonts.robotoSerif(color: Colors.black),
          ),
        ),
        body: ChangeNotifierProvider<HomeViewModel>(
          create: (context) => homeviewmodel,
          child: Column(
            children: [
              Consumer<HomeViewModel>(builder: (context, value, child) {
                switch (value.headlinesNews.status) {
                  case Status.LOADING:
                    return Center(
                        child: SpinKitChasingDots(
                      color: Colors.blue,
                      size: 50.sp,
                    ));

                  case Status.ERROR:
                    return Center(
                        child: Text(value.headlinesNews.message.toString()));
                  case Status.COMPLETED:
                    return SizedBox(
                      height: 370.h,
                      child: ListView.builder(
                          physics: BouncingScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemCount: value.headlinesNews.data!.articles!.length,
                          itemBuilder: (context, index) {
                            return Column(
                              children: [
                                Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    Container(
                                      margin: const EdgeInsets.all(9),
                                      height: 350.h,
                                      width: 300.w,
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.r),
                                        child: CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          imageUrl: value.headlinesNews.data!
                                              .articles![index].urlToImage
                                              .toString(),
                                          placeholder: (context, url) => Center(
                                            child: SpinKitCircle(
                                              color: Colors.blue,
                                              size: 20.sp,
                                            ),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              const Icon(
                                            Icons.error,
                                            color: Colors.red,
                                          ),
                                          color: Colors.black.withOpacity(0.2),
                                          colorBlendMode: BlendMode.darken,
                                        ),
                                      ),
                                    ),
                                    Positioned(
                                      bottom: 20,
                                      child: ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(10.r),
                                          child: Container(
                                            padding: const EdgeInsets.all(20),
                                            color: Colors.white,
                                            width: 270,
                                            child: Column(
                                              children: [
                                                Text(
                                                  value.headlinesNews.data!
                                                      .articles![index].title
                                                      .toString(),
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  maxLines: 3,
                                                  textAlign: TextAlign.justify,
                                                  style: GoogleFonts.montserrat(
                                                      fontSize: 15.sp,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.black),
                                                ),
                                                20.heightBox,
                                                Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment
                                                          .spaceBetween,
                                                  children: [
                                                    Text(
                                                      value
                                                          .headlinesNews
                                                          .data!
                                                          .articles![index]
                                                          .source!
                                                          .name
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 10.sp,
                                                              fontWeight:
                                                                  FontWeight
                                                                      .bold,
                                                              color:
                                                                  Colors.blue),
                                                    ),
                                                    Text(
                                                      formate.DateFormat.yMMMd()
                                                          .format(DateTime
                                                              .parse(value
                                                                  .headlinesNews
                                                                  .data!
                                                                  .articles![
                                                                      index]
                                                                  .publishedAt
                                                                  .toString()))
                                                          .toString(),
                                                      style: GoogleFonts
                                                          .montserrat(
                                                              fontSize: 10.sp,
                                                              color:
                                                                  Colors.black),
                                                    ),
                                                  ],
                                                )
                                              ],
                                            ),
                                          )),
                                    )
                                  ],
                                ),
                              ],
                            ).onTap(() {
                              Get.to(() => NewsDetailsScreen(
                                  content: value.headlinesNews.data!
                                      .articles![index].content
                                      .toString(),
                                  details: value.headlinesNews.data!
                                      .articles![index].description
                                      .toString(),
                                  newsImage: value.headlinesNews.data!
                                      .articles![index].urlToImage
                                      .toString(),
                                  channelName: value.headlinesNews.data!
                                      .articles![index].source!.name
                                      .toString(),
                                  uploadedTime: formate.DateFormat.yMMMd()
                                      .format(
                                          DateTime.parse(value.headlinesNews.data!.articles![index].publishedAt.toString()))
                                      .toString(),
                                  title: value.headlinesNews.data!.articles![index].title.toString()));
                            });
                          }),
                    );
                  default:
                    return Container();
                }
              }),
              Consumer<HomeViewModel>(builder: (context, value, child) {
                switch (value.categoryNews.status) {
                  case Status.LOADING:
                    return Center(
                        child: SpinKitChasingDots(
                      color: Colors.blue,
                      size: 50.sp,
                    ));

                  case Status.ERROR:
                    return Center(
                        child: Text(value.categoryNews.message.toString()));
                  case Status.COMPLETED:
                    return SizedBox(
                      height: 270,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: const BouncingScrollPhysics(),
                          itemCount: value.categoryNews.data!.articles!.length,
                          itemBuilder: (context, index) {
                            return Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(5.r),
                                      child: CachedNetworkImage(
                                        imageUrl: value.categoryNews.data!
                                            .articles![index].urlToImage
                                            .toString(),
                                        height: 120.h,
                                        width: 100.h,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    10.widthBox,
                                    SizedBox(
                                      width: 200.w,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            value.categoryNews.data!
                                                .articles![index].title
                                                .toString(),
                                            overflow: TextOverflow.ellipsis,
                                            maxLines: 2,
                                            style: GoogleFonts.roboto(
                                                fontSize: 15.sp,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.black),
                                          ),
                                          50.heightBox,
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                value
                                                    .categoryNews
                                                    .data!
                                                    .articles![index]
                                                    .source!
                                                    .name
                                                    .toString(),
                                                overflow: TextOverflow.ellipsis,
                                                maxLines: 2,
                                                style: GoogleFonts.roboto(
                                                    fontSize: 10.sp,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue),
                                              ),
                                              Text(
                                                formate.DateFormat.yMMMd()
                                                    .format(DateTime.parse(value
                                                        .categoryNews
                                                        .data!
                                                        .articles![index]
                                                        .publishedAt
                                                        .toString()))
                                                    .toString(),
                                                style: GoogleFonts.montserrat(
                                                    fontSize: 10.sp,
                                                    color: Colors.black),
                                              ),
                                            ],
                                          )
                                        ],
                                      ),
                                    )
                                  ],
                                )).onTap(() {
                              Get.to(() => NewsDetailsScreen(
                                  content: value.categoryNews.data!
                                      .articles![index].content
                                      .toString(),
                                  details: value.categoryNews.data!
                                      .articles![index].description
                                      .toString(),
                                  newsImage: value.categoryNews.data!
                                      .articles![index].urlToImage
                                      .toString(),
                                  channelName: value.categoryNews.data!
                                      .articles![index].source!.name
                                      .toString(),
                                  uploadedTime: formate.DateFormat.yMMMd()
                                      .format(
                                          DateTime.parse(value.categoryNews.data!.articles![index].publishedAt.toString()))
                                      .toString(),
                                  title: value.categoryNews.data!.articles![index].title.toString()));
                            });
                          }),
                    );
                  default:
                    return Container();
                }
              }),
            ],
          ),
        ));
  }
}
