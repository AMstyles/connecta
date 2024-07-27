import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tcard/tcard.dart';
import 'package:provider/provider.dart';
import 'package:iconic/iconic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (_) => ThemeNotifier(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: themeNotifier.isDarkMode ? ThemeData.dark() : ThemeData.light(),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
   final bool isPremiumUser = false; // Set this to true if the user is a premium user
  final TextEditingController _controller = TextEditingController();

  
}

class _HomeScreenState extends State<HomeScreen> {
  TCardController _controller = TCardController();
  List<bool> isSelected = [true, false];
   List<bool> isSelectedToggle = [false, false, false];
  int _page = 0;
  GlobalKey<CurvedNavigationBarState> _bottomNavigationKey = GlobalKey();

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

  int _selectedIndex = 0;

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeNotifier = Provider.of<ThemeNotifier>(context);
    bool isDarkMode = themeNotifier.isDarkMode;
    setState(() {
          //isSelectedToggle[index] = !isSelected[index];
        });
    
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
                                icon: Icon(Icons.notifications,
                                 color: isDarkMode ? Colors.grey: Colors.white,),
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
                                icon: Icon(Icons.perm_identity_rounded,
                                color: isDarkMode? Colors.grey : Colors.white,),
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
                          });
                        },
                      )

                                  )
                              ],
                            ),
                        ],
                      ),
                      
                  ],
                ),
            
              ),
              Expanded(
                child: TCard(
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
                ),
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
                width: 40, // Adjust as per your requirement
                height: 60, // Adjust as per your requirement
                // You can add more properties like width, height, fit, etc.
              ),
              Image.asset(
                'images/icons/speechbubble.png',
                width: 40, // Adjust as per your requirement
                height: 60, // Adjust as per your requirement
                // You can add more properties like width, height, fit, etc.
              ),
               Image.asset(
                'images/icons/love-birds.png',
                width: 40, // Adjust as per your requirement
                height: 60, // Adjust as per your requirement
                // You can add more properties like width, height, fit, etc.
              ),
               Image.asset(
                'images/icons/settings.png',
                width: 40, // Adjust as per your requirement
                height: 60, // Adjust as per your requirement
                // You can add more properties like width, height, fit, etc.
              ),
          //Icon(Iconic.home, size: 30, color: isDarkMode ? Colors.grey : Colors.black),
          //Icon(Iconic.inbox, size: 30, color: isDarkMode ? Colors.grey : Colors.black),
         // Icon(Iconic.heart_arrow, size: 30, color: isDarkMode ? Colors.grey : Colors.black),
         // Icon(Iconic.apps, size: 30, color: isDarkMode ? Colors.grey : Colors.black),
         // Icon(Iconic.world, size: 30, color: isDarkMode ? Colors.grey : Colors.black),
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
class ProfileCard extends StatelessWidget {
  final String imagePath;
  final String name;
  final int age;

  ProfileCard({required this.imagePath, required this.name, required this.age});

  final TextEditingController _controller = TextEditingController();

  void _sendMessage(BuildContext context) {
    String message = _controller.text.trim();
    if (message.isNotEmpty) {
      Fluttertoast.showToast(
        msg: "Message sent: $message",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
      _controller.clear();
    } else {
      Fluttertoast.showToast(
        msg: "Please enter a message.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.BOTTOM,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20.0),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(20.0),
            child: Image.asset(
              imagePath,
              fit: BoxFit.cover,
              height: 300,
            ),
          ),
          SizedBox(height: 20),
          Text(
            '$name, $age',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                icon: Icon(Icons.info),
                onPressed: () {
                  // Implement info button action
                },
              ),
              IconButton(
                icon: Icon(Icons.favorite),
                onPressed: () {
                  // Implement favorite button action
                },
              ),
            ],
          ),
           SizedBox(height: 10,),
             Padding(
               padding: const EdgeInsets.symmetric(horizontal: 20.0),
               child: Container(
                      
                      decoration: BoxDecoration(
                        color:  Color.fromARGB(26, 158, 158, 158),
               
                        borderRadius: BorderRadius.circular(50)
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                           // color: isDarkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 250, 250, 250),
                            child: IconButton(
                              icon: Icon(Icons.refresh, size: 40, color: Colors.blue),
                             onPressed: (){}// _refreshCards,
               
                            ),
                          ),
                          Container(
                          //  color: isDarkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 250, 250, 250),
                            child: IconButton(
                              icon: Icon(Icons.favorite, size: 40, color: Colors.greenAccent),
                              onPressed: () {
                             //   _controller.forward();
                              },
                            ),
                          ),
                          
                          Container(
                          //  color: isDarkMode ? const Color.fromARGB(255, 32, 32, 32) : const Color.fromARGB(255, 250, 250, 250),
                            child: IconButton(
                              icon: Icon(Icons.clear, size: 40, color: Colors.redAccent),
                              onPressed: () {
                             //   _controller.back();
                              },
                            ),
                          ),
                      
                           ],
                      ),
                    ),
             ),
             
          SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20.0),
           child: Row(
  children: [
    Expanded(
      child: TextField(
        controller: _controller,
        decoration: InputDecoration(
          hintText: 'Direct Message',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          suffixIcon: IconButton(
            icon: Icon(Icons.send),
            onPressed: () => _sendMessage(context),
          ),

        ),
      ),
    ),
    SizedBox(width: 10,),
       InkWell(
              onTap: () {
                // Handle onTap event here
                print('Image clicked!');
                // Navigate to another screen or perform any action
              },
              child: Image.asset(
                'images/icons/ic_wa.png',
                width: 40, // Adjust as per your requirement
                height: 60, // Adjust as per your requirement
                // You can add more properties like width, height, fit, etc.
              ),
            ),
       InkWell(
              onTap: () {
                // Handle onTap event here
                print('Image clicked!');
                // Navigate to another screen or perform any action
              },
              child: Image.asset(
                'images/icons/ic_insta.png',
                width: 40, // Adjust as per your requirement
                height: 60, // Adjust as per your requirement
                // You can add more properties like width, height, fit, etc.
              ),
            ),
       InkWell(
              onTap: () {
                // Handle onTap event here
                print('Image clicked!');
                // Navigate to another screen or perform any action
              },
              child: Image.asset(
                'images/icons/ic_fb.png',
                width: 40, // Adjust as per your requirement
                height: 60, // Adjust as per your requirement
                // You can add more properties like width, height, fit, etc.
              ),
            )
 
  ],
),

          ),
        
        ],
      ),
    );
  }
}

class ThemeNotifier with ChangeNotifier {
  bool isDarkMode = false;

  void toggleTheme() {
    isDarkMode = !isDarkMode;
    notifyListeners();
  }
}
