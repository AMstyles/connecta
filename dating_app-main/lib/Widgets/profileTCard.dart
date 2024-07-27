import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

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
                    child: IconButton(
                      icon: Icon(Icons.refresh, size: 40, color: Colors.blue),
                      onPressed: () {
                        // _refreshCards;
                      },
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.favorite, size: 40, color: Colors.greenAccent),
                      onPressed: () {
                        // _controller.forward();
                      },
                    ),
                  ),
                  Container(
                    child: IconButton(
                      icon: Icon(Icons.clear, size: 40, color: Colors.redAccent),
                      onPressed: () {
                        // _controller.back();
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
                    'images/icons/speechbubble.png',
                    width: 40,
                    height: 60,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle onTap event here
                    print('Image clicked!');
                    // Navigate to another screen or perform any action
                  },
                  child: Image.asset(
                    'images/icons/speechbubble.png',
                    width: 40,
                    height: 60,
                  ),
                ),
                InkWell(
                  onTap: () {
                    // Handle onTap event here
                    print('Image clicked!');
                    // Navigate to another screen or perform any action
                  },
                  child: Image.asset(
                    'images/icons/speechbubble.png',
                    width: 40,
                    height: 60,
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
