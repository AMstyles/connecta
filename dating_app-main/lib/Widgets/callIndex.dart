import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Widgets/themeNotifier.dart';
import 'package:draggable_widget/draggable_widget.dart';

class CallScreen extends StatefulWidget {
  @override
  _CallScreenState createState() => _CallScreenState();
}

class _CallScreenState extends State<CallScreen> {
  String userName = "Jeniffer";
  int userAge = 23;
  String userCountry = "UK";
  String userImage = 'images/jeniffer.jpg';
  String userLocation = "LocationA";
  String randomUser = "Random User Profile";
  String randomUserLocation = "LocationB or LocationC";

  bool isCallActive = false;

  void _connectRandomUser() {
    setState(() {
      // Implement the logic to connect with a random user
      isCallActive = true;
      randomUser = "UserB";
      randomUserLocation = "LocationB";
    });
  }

  void _disconnectCall() {
    setState(() {
      isCallActive = false;
      randomUser = "Random User Profile";
      randomUserLocation = "LocationB or LocationC";
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
                  ],
                ),
              ),
              Expanded(
                child: Column(
                  children: [
                    Container(
                      height: 300,
                      child: DraggableWidget(
                        bottomMargin: 80,
                        topMargin: 80,
                        intialVisibility: true,
                        horizontalSpace: 20,
                        shadowBorderRadius: 50,
                        child: Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                userImage,
                                width: 100,
                                height: 100,
                              ),
                              Text(
                                '$userName, $userAge',
                                style: TextStyle(fontSize: 24),
                              ),
                              Text(
                                userCountry,
                                style: TextStyle(fontSize: 16),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'UserA in $userLocation',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    Text(
                      isCallActive ? '$randomUser in $randomUserLocation' : 'Random User Profile',
                      style: TextStyle(fontSize: 18, color: Colors.white),
                    ),
                    SizedBox(height: 10),
                    isCallActive ? Container(
                      width: 150,
                      height: 150,
                      child: DraggableWidget(
                        bottomMargin: 80,
                        topMargin: 80,
                        intialVisibility: true,
                        horizontalSpace: 20,
                        shadowBorderRadius: 50,
                        child: FloatingActionButton(
                          backgroundColor: Colors.red,
                          onPressed: _disconnectCall,
                          child: Icon(Icons.call_end),
                        ),
                      ),
                    ) : Container(
                      width: 150,
                      height: 150,
                      child: DraggableWidget(
                        bottomMargin: 80,
                        topMargin: 80,
                        intialVisibility: true,
                        horizontalSpace: 20,
                        shadowBorderRadius: 50,
                        child: FloatingActionButton(
                          backgroundColor: Colors.green,
                          onPressed: _connectRandomUser,
                          child: Icon(Icons.call),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
