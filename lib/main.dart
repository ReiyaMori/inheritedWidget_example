import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return MaterialApp(
      title: 'Learn Inherited',
      home: const HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key key}) : super(key: key);
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<int> count = [0, 0, 0];
  Button button = Button.none;

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text('Inherited'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        Container(
          padding: EdgeInsets.all(50),
          child: InkWell(
            child: Container(
              color: Colors.amber,
              padding: EdgeInsets.all(10),
              child: Icon(Icons.add),
            ),
            onTap: () {
              setState(() {
                count.add(0);
              });
            },
          ),
        ),
        Expanded(
          child: Container(
            padding: EdgeInsets.only(top: 20, right: 30, left: 30),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30)),
                color: Colors.grey),
            child: Scrollbar(
              child: ListView.builder(
                  itemCount: count.length,
                  itemBuilder: (context, int index) {
                    MainModel model = _createModel(count[index]);
                    return Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                              width: 120,
                              child: Inherited(
                                model: model,
                                child: Message(num: index),
                              ),
                            ),
                            InkWell(
                              child: Container(
                                color: Colors.black54,
                                padding: EdgeInsets.all(10),
                                child: Icon(
                                  Icons.add,
                                  color: Colors.white,
                                ),
                              ),
                              onTap: () {
                                setState(() {
                                  count[index]++;
                                });
                                print('pressed increase');
                              },
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            InkWell(
                              child: Container(
                                color: Colors.amberAccent,
                                padding: EdgeInsets.all(10),
                                child: Icon(Icons.delete),
                              ),
                              onTap: () {
                                setState(() {
                                  count.removeAt(index);
                                });
                              },
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                      ],
                    );
                  }),
            ),
          ),
        )
      ]),
    );
  }

  MainModel _createModel(int value) => MainModel(counter: value);
}

class Message extends StatelessWidget {
  final int num;
  Message({this.num}) : super();
  @override
  Widget build(BuildContext context) {
    final MainModel model = Inherited.of(context, listen: true).model;
    print('Message Wiget is rebuilded');
    // TODO: implement build
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('model $num  : ${model.counter.toString()}'),
          Text(model.message),
        ],
      ),
    );
  }
}

class Inherited extends InheritedWidget {
  final MainModel model;
  const Inherited({this.model, Widget child}) : super(child: child);
  static Inherited of(BuildContext context, {@required bool listen}) {
    print('called Inherited.of');
    return listen
        ? context.dependOnInheritedWidgetOfExactType<Inherited>()
        : context.getElementForInheritedWidgetOfExactType<Inherited>().widget
            as Inherited;
  }

  @override
  bool updateShouldNotify(Inherited oldWidget) => model != oldWidget.model;
}

class MainModel {
  int counter;
  MainModel({@required this.counter});
  void increase() => this.counter++;
  String get message => (this.counter % 2 == 0) ? '偶数' : '奇数';
}

enum Button { none, tap, longPress, doubletap }
