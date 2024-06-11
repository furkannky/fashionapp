import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';

import '../data/app_data.dart';
import '../screens/details.dart';
import '../model/categories_model.dart';
import '../utils/constants.dart';
import '../model/base_model.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late PageController _pageController;
  final int _currentIndex = 2;

  @override
  void initState() {
    _pageController =
        PageController(initialPage: _currentIndex, viewportFraction: 0.7);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var textTheme = Theme.of(context).textTheme;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// Top Text
              FadeInUp(
                delay: const Duration(milliseconds: 300),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      RichText(
                        text: TextSpan(
                          text: "Find your",
                          style: textTheme.displayLarge,
                          children: [
                            TextSpan(
                              text: " Style",
                              style: textTheme.displayLarge?.copyWith(
                                color: Colors.orange,
                                fontSize: 45,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                      RichText(
                        text: const TextSpan(
                          text: "Be more beautiful with our ",
                          style: TextStyle(
                            color: Color.fromARGB(186, 0, 0, 0),
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                          children: [
                            TextSpan(
                              text: "suggestions :)",
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              /// Categories
              FadeInUp(
                delay: const Duration(milliseconds: 450),
                child: Container(
                  margin: const EdgeInsets.only(top: 7),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.14,
                  child: ListView.builder(
                      shrinkWrap: true,
                      physics: const BouncingScrollPhysics(),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      itemBuilder: (ctx, index) {
                        CategoriesModel current = categories[index];
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Column(
                            children: [
                              CircleAvatar(
                                radius: 35,
                                backgroundImage: AssetImage(current.imageUrl),
                              ),
                              SizedBox(
                                height:
                                    MediaQuery.of(context).size.height * 0.008,
                              ),
                              Text(
                                current.title,
                                style: textTheme.titleMedium,
                              ),
                            ],
                          ),
                        );
                      }),
                ),
              ),

              /// Body Slider
              FadeInUp(
                delay: const Duration(milliseconds: 550),
                child: Container(
                  margin: const EdgeInsets.only(top: 10),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.45,
                  child: PageView.builder(
                    controller: _pageController,
                    itemCount: mainList.length,
                    physics: const BouncingScrollPhysics(),
                    itemBuilder: (context, index) {
                      return GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Details(
                                  data: mainList[index],
                                  isCameFromMostPopularPart: false,
                                ),
                              ),
                            );
                          },
                          child: view(index, textTheme, size));
                    },
                  ),
                ),
              ),

              /// Most Popular Text
              FadeInUp(
                delay: const Duration(milliseconds: 650),
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 8.0, vertical: 5.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("Most Popular", style: textTheme.displaySmall),
                      Text("See all", style: textTheme.headlineMedium),
                    ],
                  ),
                ),
              ),

              /// Most Popular Content
              FadeInUp(
                delay: const Duration(milliseconds: 750),
                child: Container(
                  margin: const EdgeInsets.only(top: 10.0),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height * 0.44,
                  child: GridView.builder(
                    physics: const BouncingScrollPhysics(),
                    itemCount: mainList.length,
                    // Ekran genişliğine ve boyuna bağlı olarak dinamik ızgara oluşturun
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount:
                          MediaQuery.of(context).size.width > 600 ? 4 : 2,
                      // Ekran genişliğine bağlı olarak sütun sayısını ayarlayın
                      childAspectRatio:
                          MediaQuery.of(context).size.width > 600 ? 0.5 : 0.63,
                      // Ekran genişliğine bağlı olarak öğe en-boy oranını ayarlayın
                    ),
                    itemBuilder: (context, index) {
                      BaseModel current = mainList[index];
                      return GestureDetector(
                        onTap: (() => Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) {
                                FocusManager.instance.primaryFocus?.unfocus();
                                return Details(
                                  data: current,
                                  isCameFromMostPopularPart: true,
                                );
                              }),
                            )),
                        child: Hero(
                          tag: current.imageUrl,
                          child: Column(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width * 0.8,
                                height: MediaQuery.of(context).size.width * 0.6,
                                margin: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(3),
                                  image: DecorationImage(
                                    image: AssetImage(current.imageUrl),
                                    fit: BoxFit.cover,
                                  ),
                                  boxShadow: const [
                                    BoxShadow(
                                      offset: Offset(0, 4),
                                      blurRadius: 4,
                                      color: Color.fromARGB(61, 0, 0, 0),
                                    )
                                  ],
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.0),
                                child: Text(
                                  current.name,
                                  style: textTheme.displayMedium,
                                ),
                              ),
                              RichText(
                                text: TextSpan(
                                  text: "€",
                                  style: textTheme.titleSmall?.copyWith(
                                    color: primaryColor,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  children: [
                                    TextSpan(
                                      text: current.price.toString(),
                                      style: textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  /// Page View
  Widget view(int index, TextTheme theme, Size size) {
    return AnimatedBuilder(
        animation: _pageController,
        builder: (context, child) {
          double value = 0.0;
          if (_pageController.position.haveDimensions) {
            value = index.toDouble() - (_pageController.page ?? 0);
            value = (value * 0.04).clamp(-1, 1);
          }
          return Transform.rotate(
            angle: 3.14 * value,
            child: card(mainList[index], theme, size),
          );
        });
  }

  /// Page view Cards
  Widget card(BaseModel data, TextTheme theme, Size size) {
    return Padding(
      padding: const EdgeInsets.only(top: 15.0),
      child: Column(
        children: [
          Hero(
            tag: data.id,
            child: Container(
              width: size.width * 0.6,
              height: size.height * 0.35,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                image: DecorationImage(
                  image: AssetImage(data.imageUrl),
                  fit: BoxFit.cover,
                ),
                boxShadow: const [
                  BoxShadow(
                      offset: Offset(0, 4),
                      blurRadius: 4,
                      color: Color.fromARGB(61, 0, 0, 0))
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10.0),
            child: Text(
              data.name,
              style: theme.displayMedium,
            ),
          ),
          RichText(
            text: TextSpan(
              text: "€",
              style: theme.titleSmall?.copyWith(
                color: primaryColor,
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
              children: [
                TextSpan(
                  text: data.price.toString(),
                  style: theme.titleSmall
                      ?.copyWith(fontWeight: FontWeight.w600, fontSize: 25),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
