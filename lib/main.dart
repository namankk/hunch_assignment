import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: Scaffold(
          appBar: AppBar(
            // TRY THIS: Try changing the color here to a specific color (to
            // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
            // change color while the other colors stay the same.
            backgroundColor: Theme.of(context).colorScheme.inversePrimary,
            // Here we take the value from the MyHomePage object that was created by
            // the App.build method, and use it to set our appbar title.
            title: const Text("Hunch Assignment"),
          ),
          body: ListView.separated(
              itemCount: 5,
              itemBuilder: (context, index) {
                return Stack(
                  children: [
                    Container(
                      margin: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          border: Border.all(color: Colors.black, width: 1)),
                      child: Column(
                        children: [centerButton(context), bottomMenu()],
                      ),
                    ),
                    closeButtonWidget()
                  ],
                );
              },
              separatorBuilder: (context, index) {
                return const SizedBox(
                  height: 10,
                );
              }), // This trailing comma makes auto-formatting nicer for build methods.
        ));
  }

  SizedBox centerButton(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.width / 2,
      child: Center(
        child: ElevatedButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return const CustomDialog();
                },
              );
            },
            style: ElevatedButton.styleFrom(
                shape: const ContinuousRectangleBorder()),
            child: const Text("Tap to open")),
      ),
    );
  }

  Container bottomMenu() {
    return Container(
      padding: const EdgeInsets.only(bottom: 10.0),
      color: Colors.white,
      child: Row(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Row(
            children: [
              Icon(Icons.comment, size: 13.0),
              Padding(
                padding: EdgeInsets.only(left: 3.0),
                child: Text("12 Comments", style: TextStyle(fontSize: 12)),
              )
            ],
          ),
          divideLine(),
          Stack(
            children: [
              Column(
                children: [
                  const Row(
                    children: [
                      Icon(Icons.stacked_bar_chart, size: 13.0),
                      Padding(
                        padding: EdgeInsets.only(left: 3.0),
                        child: Text("Peek", style: TextStyle(fontSize: 12)),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 2.0, right: 15.0),
                    margin: const EdgeInsets.only(left: 15.0, right: 15.0),
                    decoration: const BoxDecoration(
                        shape: BoxShape.rectangle, color: Colors.amber),
                    child: const Text("coming soon",
                        style: TextStyle(fontSize: 10)),
                  )
                ],
              ),
              Positioned(
                  right: 10,
                  bottom: 0,
                  child: Transform.rotate(
                    angle: 95,
                    child: Container(
                      height: 14,
                      width: 14,
                      decoration: const BoxDecoration(
                          shape: BoxShape.rectangle, color: Colors.white),
                    ),
                  ))
            ],
          ),
          divideLine(),
          const Row(
            children: [
              Icon(Icons.share, size: 13.0),
              Padding(
                padding: EdgeInsets.only(left: 3.0),
                child: Text("Share", style: TextStyle(fontSize: 12)),
              )
            ],
          ),
        ],
      ),
    );
  }

  Positioned closeButtonWidget() {
    return Positioned(
      right: 2,
      top: 2,
      child: Container(
        height: 30,
        width: 30,
        decoration: const BoxDecoration(
          shape: BoxShape.circle,
          color: Colors.deepPurple,
        ),
      ),
    );
  }

  Widget divideLine() {
    return Container(
      height: 10,
      width: 1,
      margin: const EdgeInsets.only(top: 3.0),
      color: Colors.black,
    );
  }
}

class CustomDialog extends StatefulWidget {
  const CustomDialog({super.key});

  @override
  State<StatefulWidget> createState() => _CustomDialogState();
}

class _CustomDialogState extends State<CustomDialog>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 1),
    );
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);
    _controller.forward();

    Future.delayed(const Duration(seconds: 5), () {
      _controller.reverse().whenComplete(() => Navigator.of(context).pop());
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: FadeTransition(
        opacity: _animation,
        child: const AlertDialog(
          title: Text('Thank you'),
          content: Text('This dialog will close in 5 seconds.'),
        ),
      ),
    );
  }
}
