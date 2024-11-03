import 'package:flutter/material.dart';

class VPNScreen extends StatefulWidget {
  @override
  _VPNScreenState createState() => _VPNScreenState();
}

class _VPNScreenState extends State<VPNScreen> with TickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _animation;
  bool _isConnected = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 5),
      vsync: this,
    );

    _animation = Tween<double>(begin: 0.01, end: 1.3).animate(
      CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOut,
      ),
    );
  }

  void _toggleConnection() {
    setState(() {
      _isConnected = !_isConnected;
    });

    if (_isConnected) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(image: DecorationImage(image: AssetImage('assets/img_50.png'),fit: BoxFit.cover) ),
         child:
        Stack(
          children: [
        Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Animated Avatar
              AnimatedBuilder(
                animation: _animation,
                builder: (context, child) {
                  return Transform.scale(
                    scale: _animation.value,
                    child: ClipOval(
                      child: Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                          color: _isConnected ? Colors.blueGrey : Colors.deepPurple,
                          gradient: LinearGradient(
                            colors: _isConnected
                                ? [Colors.deepPurple, Colors.blueGrey]
                                : [Colors.blueGrey, Colors.deepPurple],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              offset: Offset(0, 4),
                              blurRadius: 10,
                            ),
                          ],
                        ),
                        child: Center(
                          child: Icon(
                            _isConnected ? Icons.lock : Icons.lock_open,
                            color: Colors.white,
                            size: 50,
                          ),
                        )
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 20),
              Text(
                _isConnected ? 'VPN Connected' : 'VPN Disconnected',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 20),
              // Connect/Disconnect Button
              ElevatedButton(
                onPressed: _toggleConnection,
                style: ElevatedButton.styleFrom(
                  primary: Colors.blueGrey,
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 15),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                ),
                child: Text(
                  _isConnected ? 'Disconnect' : 'Connect',
                  style: TextStyle(fontSize: 18),
                ),
              ),
            ],
          ),

            ),


            ],
            ))
      );

  }
}