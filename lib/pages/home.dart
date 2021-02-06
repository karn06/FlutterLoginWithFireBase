import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_app/pages/ChatList.dart';
import 'package:flutter_app/pages/chat_screen.dart';
import 'package:toast/toast.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  var names = loadChatListItem;

  Widget appBarText = Text('My Chats');
  Icon searchIcon = Icon(Icons.search);
  final _auth = FirebaseAuth.instance;

  void _showToast(String toastText) {
    Toast.show(toastText, context,
        duration: Toast.LENGTH_LONG,
        gravity: Toast.BOTTOM,
        backgroundColor: Colors.red,
        textColor: Color(0xFF000000));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leadingWidth: 28.0,
        title: Row(
          children: [
            Hero(
              tag: 'profile_picture',
              child: CircleAvatar(
                radius: 20.0,
                backgroundImage: AssetImage('images/profile.jpeg'),
              ),
            ),
            SizedBox(
              width: 8.0,
            ),
            appBarText,
          ],
        ),
        backgroundColor: Colors.white12,
        actions: [
          IconButton(
              icon: searchIcon,
              onPressed: () {
                showSearch(context: context, delegate: DataSearch());
              }),
          IconButton(
              icon: Icon(Icons.more_vert),
              onPressed: () {
                _auth.signOut();
                Navigator.pop(context);
                _showToast('Successfully signed out');
              })
        ],
      ),
      backgroundColor: Colors.white,
      body: ListView.builder(
        itemCount: names.length,
        itemBuilder: (context, index) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(names[index]),
                    ),
                  );
                },
                child: Card(
                  color: Colors.redAccent[100],
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            vertical: 10.0, horizontal: 10.0),
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (_) => new AlertDialog(
                                      actions: [
                                        Image.asset(
                                          names[index].image,
                                          fit: BoxFit.fitWidth,
                                        )
                                      ],
                                    ));
                          },
                          child: CircleAvatar(
                              radius: 40.0,
                              backgroundImage: AssetImage(names[index].image)),
                        ),
                      ),
                      SizedBox(
                        width: 10.0,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            names[index].name,
                            style: TextStyle(color: Colors.black),
                          ),
                          SizedBox(
                            height: 10.0,
                          ),
                          Text(
                            names[index].description,
                            style: TextStyle(color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class DataSearch extends SearchDelegate<ChatList> {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: Icon(Icons.clear),
        onPressed: () {
          query = "";
        },
      )
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
        icon: Icon(Icons.arrow_back),
        onPressed: () {
          Navigator.pop(context, null);
        });
  }

  @override
  Widget buildResults(BuildContext context) {
    return Scaffold();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    var cl = query.isEmpty
        ? loadChatListItem
        : loadChatListItem
            .where((element) => element.name.startsWith(query))
            .toList();
    return ListView.builder(
      itemCount: cl.length,
      itemBuilder: (context, index) {
        final ChatList chatList = cl[index];
        return cl.isEmpty
            ? Center(
                child: Text(
                'No Data Found',
                style: TextStyle(color: Colors.black),
              ))
            : GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(cl[index]),
                    ),
                  );
                },
                child: Card(
                  margin:
                      EdgeInsets.symmetric(vertical: 10.0, horizontal: 15.0),
                  color: Colors.deepOrange,
                  child: Padding(
                    padding: const EdgeInsets.all(18.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 5.0),
                          child: CircleAvatar(
                              radius: 30.0,
                              backgroundImage:
                                  AssetImage('images/profile.jpeg')),
                        ),
                        SizedBox(
                          width: 10.0,
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              chatList.name,
                              style: TextStyle(color: Colors.black),
                            ),
                            SizedBox(
                              height: 10.0,
                            ),
                            Text(
                              chatList.description,
                              style: TextStyle(color: Colors.black),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
      },
    );
  }
}
