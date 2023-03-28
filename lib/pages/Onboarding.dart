import 'package:flutter/material.dart';
import 'package:liquid_swipe/liquid_swipe.dart';

class UserOnboard extends StatefulWidget {
  static const TextStyle goldcoinGreyText = TextStyle(
    color: Colors.grey,
    fontSize: 26,
    fontFamily: "Righteous",
  );
  static const TextStyle goldcoinWhiteText = TextStyle(
    color: Colors.white,
    fontSize: 26.0,
    fontFamily: "Righteous",
  );
  static const TextStyle greyStyle = TextStyle(
    color: Colors.grey,
    fontSize: 40.0,
    fontFamily: "Product Sans",
  );
  static const TextStyle whiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 40.0,
    fontFamily: "Product Sans",
  );
  static const TextStyle boldStyle = TextStyle(
    fontSize: 40.0,
    fontFamily: "Product Sans",
    fontWeight: FontWeight.bold,
  );
  static const TextStyle descriptionGreyStyle = TextStyle(
    color: Colors.grey,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );
  static const TextStyle descriptionWhiteStyle = TextStyle(
    color: Colors.white,
    fontSize: 20.0,
    fontFamily: "Product Sans",
  );

  @override
  _UserOnboardState createState() => _UserOnboardState();
}

class _UserOnboardState extends State<UserOnboard>
    with SingleTickerProviderStateMixin {
  bool _visible = true;
  int page = 0;
  late LiquidController _liquidController;
  late Animation<double> transformAnimation;
  late Animation<double> opacityAnimation;
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _liquidController = LiquidController();
    _controller =
        AnimationController(duration: Duration(milliseconds: 700), vsync: this);
    transformAnimation = Tween<double>(begin: 70.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.5,
          1,
          curve: Curves.easeOut,
        ),
      ),
    );
    opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Interval(
          0.7,
          1,
          curve: Curves.easeInOutExpo,
        ),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      Container(
        height: MediaQuery.of(context).size.height,
        width: double.infinity,
        color: Colors.white,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Remind.Me",
                style: UserOnboard.goldcoinGreyText,
              ),
            ),
            Center(
              child: Container(
                constraints: BoxConstraints(
                  minHeight: 200,
                  maxHeight: 300,
                ),
                child: Image.asset("assets/img/remainder.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("On-Time", style: UserOnboard.greyStyle),
                  Text("Remainders",
                      style: TextStyle(
                        color: Color(0xFFFF735C),
                        fontSize: 40.0,
                        fontFamily: "Righteous",
                      )),
                  const SizedBox(height: 20.0),
                  Text(
                    "Once you set your Time-Table,\n"
                    "Remind.Me reminds you,\n"
                    "quicker than you think.",
                    overflow: TextOverflow.clip,
                    style: UserOnboard.descriptionGreyStyle,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        width: double.infinity,
        color: Color(0xFFBCE2F8),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Remind.Me",
                style: UserOnboard.goldcoinWhiteText,
              ),
            ),
            Container(
              height: 340,
              child: Image.asset("assets/img/assignments.png"),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "College",
                    style: TextStyle(
                      fontSize: 40.0,
                      fontFamily: "Product Sans",
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    "Assignments",
                    style: TextStyle(
                      color: Color(0xFF425DCE),
                      fontSize: 40.0,
                      fontFamily: "Righteous",
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Set due dates for your assignments,\n"
                    "And finish it in time.",
                    overflow: TextOverflow.clip,
                    style: TextStyle(
                      fontSize: 18.0,
                      fontFamily: "Product Sans",
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
      Container(
        height: MediaQuery.of(context).size.height,
        padding: EdgeInsets.symmetric(vertical: 20, horizontal: 0),
        width: double.infinity,
        color: Color(0xFF4A4DF5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Text(
                "Remind.Me",
                style: UserOnboard.goldcoinWhiteText,
              ),
            ),
            Center(
              child: Container(
                width: double.infinity,
                constraints: BoxConstraints(
                  minHeight: 290,
                  maxHeight: 315,
                ),
                child: Image.asset("assets/img/calender.png"),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30.0, right: 15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    flex: 1,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("Class", style: UserOnboard.whiteStyle),
                        Text(
                          "Calender",
                          style: TextStyle(
                            color: Color(0xFF140A81),
                            fontSize: 40.0,
                            fontFamily: "Righteous",
                          ),
                        ),
                        const SizedBox(height: 10.0),
                        Text(
                          "Look at the Big Picture,\n"
                          "Manage your time,\nin a productive way.",
                          overflow: TextOverflow.clip,
                          style: UserOnboard.descriptionWhiteStyle,
                        ),
                      ],
                    ),
                  ),
                  AnimatedBuilder(
                    animation: transformAnimation,
                    builder: (BuildContext context, child) {
                      if (page == 2) _controller.forward();
                      return Transform.translate(
                        offset: Offset(transformAnimation.value, 0.0),
                        child: Opacity(
                          opacity: opacityAnimation.value,
                          child: child,
                        ),
                      );
                    },
                    child: Container(
                      width: 60,
                      height: 60,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: IconButton(
                        onPressed: () =>
                            Navigator.of(context).pushNamed("/getInfo"),
                        iconSize: 40,
                        tooltip: "Let's Go",
                        icon: Icon(
                          Icons.navigate_next_rounded,
                          color: Color(0xFF140A81),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    ];

    return Scaffold(
      body: GestureDetector(
        onHorizontalDragDown: (_) => setState(() => _visible = false),
        child: LiquidSwipe(
          enableLoop: false,
          initialPage: 0,
          fullTransitionValue: 500,
          liquidController: _liquidController,
          waveType: WaveType.liquidReveal,
          ignoreUserGestureWhileAnimating: true,
          slideIconWidget: AnimatedOpacity(
            duration: Duration(milliseconds: 400),
            opacity: _visible ? 1.0 : 0.0,
            child: Icon(
              Icons.arrow_back_ios_rounded,
              size: 25.0,
              color: page == 0 ? Color(0xFFFF735C) : Color(0xFF425DCE),
            ),
          ),
          onPageChangeCallback: (int val) {
            setState(
              () {
                _visible = val == 2 ? false : true;
                page = val;
              },
            );
          },
          positionSlideIcon: 0.8,
          pages: pages,
        ),
      ),
    );
  }
}
