import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:newsapp/Data/response/status.dart';
import 'package:newsapp/view/newsDetailsScreen.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as formate;
import '../viewModels/homeViewModel.dart';

class CategoryScreen extends StatefulWidget {

  CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  final homeviewmodel = HomeViewModel();

  List<String> categories = [
    'general',
    'Entertainment',
    'Health',
    'Sport',
    'Business',
    'Technology'
  ];

  var selectedIndex = 0.obs;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homeviewmodel.getcategoryNews("general");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(children: [
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Obx(
                () => Row(
                  children: List.generate(
                    categories.length,
                    (index) => Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                              padding:
                                  const EdgeInsets.only(left: 10, right: 10),
                              child: categories[index]
                                  .toString()
                                  .text
                                  .white
                                  .make())
                          .box
                          .color(selectedIndex.value == index
                              ? Colors.blue
                              : Colors.grey)
                          .padding(const EdgeInsets.all(8))
                          .roundedSM
                          .make()
                          .onTap(() {
                        selectedIndex.value = index;
                        homeviewmodel.getcategoryNews(categories[index]);
                      }),
                    ),
                  ),
                ),
              ),
            ),
          ),
          10.heightBox,
          ChangeNotifierProvider<HomeViewModel>(
            create: (context) => homeviewmodel,
            child: Consumer<HomeViewModel>(builder: (context, value, child) {
              switch (value.categoryNews.status) {
                case Status.LOADING:
                  return Center(
                      child: SpinKitChasingDots(
                    color: Colors.blue,
                    size: 20.sp,
                  ));

                case Status.ERROR:
                  return Center(
                      child: Text(value.categoryNews.message.toString()));
                case Status.COMPLETED:
                  return Expanded(
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
                                      errorListener: (value) => const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
                                      errorWidget: (context, url, error) =>
                                          const Icon(
                                        Icons.error,
                                        color: Colors.red,
                                      ),
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
                                              value.categoryNews.data!
                                                  .articles![index].source!.name
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
                                content: value
                                    .categoryNews.data!.articles![index].content
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
          ),
        ]),
      ),
    );
  }
}
