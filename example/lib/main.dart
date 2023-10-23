import 'package:flutter/material.dart';
import 'package:inputbox_timer/inputbox_timer.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TimerInputBox Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue
      ),
      home: const MyHomePage(title: 'TimerInputBox Demo'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  TextEditingController controller = TextEditingController();
  bool isTimeOver = false;
  
  void callFunc() {
    setState(() {
      isTimeOver = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Is Time Over? => ${isTimeOver.toString()}',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: isTimeOver ? Colors.red : Colors.black
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 20, bottom: 20)),
            SizedBox(
              width: MediaQuery.of(context).size.width / 3,
              child: TimerInputField(
                controller: controller,
                excuteOnTimeOut: callFunc,
                timeoutSecond: 10, // 10 Seconds
                maxLength: 5,
                keyboardType: TextInputType.number,
                readOnly: isTimeOver,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
