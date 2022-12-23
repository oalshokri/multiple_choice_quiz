import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ResultPage extends StatefulWidget {
  final int score;
  final int fullMark;
  const ResultPage({Key? key, required this.score, required this.fullMark})
      : super(key: key);
  @override
  State<ResultPage> createState() => _ResultPageState();
}

class _ResultPageState extends State<ResultPage> with TickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 2),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> _animation = CurvedAnimation(
    parent: _controller,
    curve: Curves.elasticOut,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  double _angle = 0;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const FlutterLogo(
            size: 200,
          ),
          SizedBox(
            height: 100,
          ),
          const Text(
            'Congratulation',
            textAlign: TextAlign.center,
            style: TextStyle(color: Colors.amber, fontSize: 34),
          ),
          SizedBox(
            height: 16,
          ),
          Text(
            'You Achieved ${widget.score} / ${widget.fullMark}',
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
          ),
          SizedBox(
            height: 100,
          ),
          SizedBox(
            width: 200,
            height: 100,
            child: Center(
              child: ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _angle = 90;
                    });
                  },
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        RotationTransition(
                          turns: _animation,
                          child: Icon(
                            Icons.refresh_rounded,
                            size: 34,
                          ),
                        ),
                        Text(
                          'Try Again',
                          style: TextStyle(
                              fontSize: 16, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  )),
            ),
          )
        ],
      ),
    );
  }
}
