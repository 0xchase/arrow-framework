import 'package:flutter/material.dart';
import 'package:collapsible_sidebar/collapsible_sidebar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    List<CollapsibleItem> _items = [];

    _items.add(
      CollapsibleItem(
        icon: Icons.abc,
        text: "Text",
        isSelected: true,
        onPressed: () {

        }
      )
    );
    _items.add(
      CollapsibleItem(
        icon: Icons.abc,
        text: "Text",
        onPressed: () {

        }
      )
    );
    _items.add(
      CollapsibleItem(
        icon: Icons.abc,
        text: "Text",
        onPressed: () {

        }
      )
    );
    _items.add(
      CollapsibleItem(
        icon: Icons.abc,
        text: "Text",
        onPressed: () {

        }
      )
    );
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
            return CollapsibleSidebar(
              //isCollapsed: true, //true by default, set to 'false' to have the full sidebar open on initially loading the app
              items: _items,
              title: 'Lorem Ipsum',
              titleBack: false,  //false by default, set to 'true' to use a back icon instead of avatar picture
              titleBackIcon: Icons.arrow_back, //the back icon is 'arrow_back' by default (customizable)
              onTitleTap: () {  //custom callback function called when title avatar or back icon is pressed
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text('Yay! Flutter Collapsible Sidebar!')));
              },
              onHoverPointer: SystemMouseCursors.click, //the default hover mouse pointer is set to 'click' type by default (customizable)
              textStyle: TextStyle(fontSize: 20), //custom style for sidebar title
              titleStyle: TextStyle(fontSize: 20), //custom style for collapsible items text
              toggleTitleStyle: TextStyle(fontSize: 20), //custom style for toggle button title
              avatarImg: NetworkImage('https://www.w3schools.com/howto/img_avatar.png'),
              body: Container(),
              height: double.infinity,
              minWidth: 80,
              maxWidth: 270,
              borderRadius: 15,
              iconSize: 40,
              toggleTitle: 'Collapse', //title text of Toggle Button
              toggleButtonIcon: Icons.chevron_right,
              backgroundColor: Color(0xff2B3138),
              selectedIconBox: Color(0xff2F4047),
              selectedIconColor: Color(0xff4AC6EA),
              selectedTextColor: Color(0xffF3F7F7),
              unselectedIconColor: Color(0xff6A7886),
              unselectedTextColor: Color(0xffC0C7D0),
              duration: Duration(milliseconds: 500),
              curve: Curves.fastLinearToSlowEaseIn,
              screenPadding: 4,
              topPadding: 0, //space between image avatar and icons
              bottomPadding: 0, //space between icons and toggle button
              fitItemsToBottom: true, //fit all icons to the end of the space between image avatar and toggle button
              showToggleButton: true,
              /*sidebarBoxShadow: [BoxShadow(
                color: Colors.blue,
                blurRadius: 10,
                spreadRadius: 0.01,
                offset: Offset(3, 3),
              ),],*/
            //sidebarBoxShadow accepts a list<BoxShadow> just like the "BoxDecoration" parameter of a "Container". By default a black shadow is applied.
      );
  }
}
