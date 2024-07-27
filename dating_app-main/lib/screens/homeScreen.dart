import 'package:dating_app/Widgets/callIndex.dart';
import 'package:flutter/material.dart';
import 'package:tcard/tcard.dart';
import 'package:provider/provider.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import '../Widgets/profileTCard.dart';
import '../Widgets/themeNotifier.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TCardController _controller = TCardController();
  List<bool> isSelected = [true, false];
  List<bool> isSelectedToggle = [false, false, false];
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();
  int _selectedIndex = 0;
  bool isMeetScreen = true;

  List<Widget> _cards = [
    ProfileCard(
      imagePath: 'images/sofia.jpg',
      name: 'Sofia',
      age: 35,
    ),
    ProfileCard(
      imagePath: 'images/sofia.jpg',
      name: 'Sofia',
      age: 35,
    ),
    ProfileCard(
      imagePath: 'images/sofia.jpg',
      name: 'Sofia',
      age: 35,
    ),
  ];

  void _refreshCards() {
    setState(() {
      _cards = List.from(_cards);
    });
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  void _toggleScreen() {
    setState(() {
      isMeetScreen = !isMeetScreen;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool isDarkMode = themeNotifier.isDarkMode;

    return Scaffold(
      body: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isDarkMode
                    ? [Colors.black87, Colors.black54]
                    : [Colors.pinkAccent, Colors.orangeAccent],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
          ),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Connecta',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 28,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              icon: Icon(
                                isDarkMode
                                    ? Icons.wb_sunny
                                    : Icons.nightlight_round,
                                color: isDarkMode ? Colors.grey : Colors.white,
                              ),
                              onPressed: () {
                                themeNotifier.toggleTheme();
                              },
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.notifications,
                                color: isDarkMode ? Colors.grey : Colors.white,
                              ),
                              onPressed: () {},
                            ),
                            PopupMenuButton<String>(
                              onSelected: (value) {
                                // Handle profile and logout options
                              },
                              itemBuilder: (BuildContext context) {
                                return {'Profile', 'Logout'}.map((String choice) {
                                  return PopupMenuItem<String>(
                                    value: choice,
                                    child: Text(choice),
                                  );
                                }).toList();
                              },
                              icon: Icon(
                                Icons.perm_identity_rounded,
                                color: isDarkMode ? Colors.grey : Colors.white,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    SizedBox(height: 10,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(width: 10,),
                        Row(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color.fromARGB(66, 255, 255, 255),
                              ),
                              child: ToggleButtons(
                                isSelected: isSelected,
                                selectedColor: Colors.white,
                                fillColor: Colors.pink,
                                borderColor: Colors.transparent,
                                selectedBorderColor: Colors.transparent,
                                borderRadius: BorderRadius.circular(30),
                                children: <Widget>[
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    padding: EdgeInsets.symmetric(horizontal: isSelected[0] ? 25 : 20),
                                    child: Text(
                                      'Meet',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    padding: EdgeInsets.symmetric(horizontal: isSelected[1] ? 25 : 20),
                                    child: Text(
                                      'Call',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                                onPressed: (int newIndex) {
                                  setState(() {
                                    for (int index = 0; index < isSelected.length; index++) {
                                      if (index == newIndex) {
                                        isSelected[index] = true;
                                      } else {
                                        isSelected[index] = false;
                                      }
                                    }
                                    _toggleScreen();
                                  });
                                },
                              ),
                            )
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Expanded(
                child: isMeetScreen
                    ? TCard(
                        cards: _cards,
                        controller: _controller,
                        onForward: (index, info) {
                          if (info.direction == SwipDirection.Left) {
                            // Handle swipe left
                          } else if (info.direction == SwipDirection.Right) {
                            // Handle swipe right
                          }
                        },
                        onBack: (index, info) {
                          // Handle swipe back
                        },
                        onEnd: () {
                          // Handle end of swipe
                        },
                      )
                    : CallScreen(), // Display CallScreen when 'Call' is selected
              ),
              SizedBox(height: 40,)
            ],
          ),
        ],
      ),
      bottomNavigationBar: CurvedNavigationBar(
        key: _bottomNavigationKey,
        index: 0,
        items: <Widget>[
          Image.asset(
            'images/icons/flame.png',
            width: 40,
            height: 60,
          ),
          Image.asset(
            'images/icons/speechbubble.png',
            width: 40,
            height: 60,
          ),
          Image.asset(
            'images/icons/love-birds.png',
            width: 40,
            height: 60,
          ),
          Image.asset(
            'images/icons/settings.png',
            width: 40,
            height: 60,
          ),
        ],
        color: isDarkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 250, 250, 250),
        buttonBackgroundColor: isDarkMode ? const Color.fromARGB(255, 32, 32, 32)  : const Color.fromARGB(255, 255, 255, 255),
        backgroundColor: isDarkMode ? Colors.black54 : Colors.orangeAccent,
        animationCurve: Curves.easeInOut,
        animationDuration: Duration(milliseconds: 700),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
        letIndexChange: (index) => true,
      ),
    );
  }
}
