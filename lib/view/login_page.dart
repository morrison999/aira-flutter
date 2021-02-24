import 'package:accessibility/components/aira_app_bar.dart';
import 'package:accessibility/components/text_size.dart';
import 'package:accessibility/controller/login_page.dart';
import 'package:accessibility/model/user.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginPage extends StatelessWidget {
  final controller = Get.put(LoginPageController());
  final userService = Get.find<UserService>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AiraAppBar(
          titleIn: "Login page",
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Welcome to Aira",
                  style: TextStyle(fontSize: AiraTextSize.getLarge()),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 30.0),
                child: Text(
                  "Please register",
                  style: TextStyle(fontSize: AiraTextSize.get()),
                ),
              ),
              Row(
                children: [
                  Row(children: [
                    Text("Name"),
                    TextField(
                      controller: TextEditingController(
                          text: userService.user.value.name),
                    )
                  ]),
                  Row()
                ],
              ),
              Row(),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: ElevatedButton(
                      child: Text("Register"),
                      onPressed: _dummy,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ));
  }

  void _dummy() {
    debugPrint("Dummy called");
  }
// This trailing comma makes auto-formatting nicer for build methods.
}

// Future<String> _getQuote() async {
//   var item = await getQuotesFromServer(3);
//   return item[0];
// }
//
// Future<List<String>> getQuotesFromServer([int count = 1]) async {
//   List<String> list;
//   var response = await http
//       .get("https://goquotes-api.herokuapp.com/api/v1/random?count=$count");
//   if (response != null) {
//     var data = jsonDecode(response.body);
//     debugPrint(data);
//   } else
//     return ["Server not responding"];
//   return list;
// }
//
// void _processSwipe(DragEndDetails details) {
//   SwipeDirection dir = SwipeTracker().getDirection();
//
//   switch (dir) {
//     case SwipeDirection.None:
//       break;
//     case SwipeDirection.Left:
//       _setCounter(-10);
//       break;
//     case SwipeDirection.Right:
//       _setCounter(10);
//       break;
//     case SwipeDirection.Up:
//       _setCounter(5);
//       break;
//     case SwipeDirection.Down:
//       _setCounter(0);
//       break;
//   }
//  debugPrint("Swipe direction: $dir");
//}

class AriaElevatedButton extends ElevatedButton {
  static Widget create(String buttonText, Function() onPress,
      {String semanticText, Function() onLongPress}) {
    return ElevatedButton(
      onPressed: onPress,
      onLongPress: onLongPress,
      child: Semantics(
        label: semanticText ?? "",
        child: Text(buttonText, style: TextStyle(fontWeight: FontWeight.bold)),
      ),
    );
  }
}

/// used for gesture detection. Not currently in use.
/// These are the directions you can swipe.
enum SwipeDirection { None, Left, Right, Up, Down }

/// keeps track of swipe motion from start through end event.
/// It tracks x,y motion to determine the direction via the update events
///
class SwipeTracker {
  static final SwipeTracker _me = SwipeTracker._internal();
  double _startX, _startY, _endX, _endY;
  bool _canceled = false;

  factory SwipeTracker() {
    return _me;
  }

  SwipeTracker._internal();

  void reset() {
    _canceled = true;
    debugPrint("Swipe canceled");
  }

  // Capture the current location
  void onStart(DragStartDetails details) {
    _canceled = false;
    _startX = details.globalPosition.dx;
    _startY = details.globalPosition.dy;
  }

  // update to the latest position
  void onUpdate(DragUpdateDetails details) {
    _endX = details.globalPosition.dx;
    _endY = details.globalPosition.dy;
  }

  //diff the start and end locations. Then determine if they moved more
  // in the x or y direction. Then determine if they moved far enough to
  // constitute a move.

  SwipeDirection getDirection() {
    if (_canceled) return SwipeDirection.None;
    double diffX = _endX - _startX;
    double diffY = _endY - _startY;
    double absX = diffX.abs();
    double absY = diffY.abs();

    // min distance you must swipe before it is considered a valid swipe.
    const double minimumMove = 50.0;

    if (absX < minimumMove && absY < minimumMove) {
      debugPrint("Minimum not met ($absX, $absY)!");
      return SwipeDirection.None;
    }
    if (absX > absY) {
      return diffX > 0 ? SwipeDirection.Right : SwipeDirection.Left;
    } else {
      return diffY > 0 ? SwipeDirection.Down : SwipeDirection.Up;
    }
  }
}
