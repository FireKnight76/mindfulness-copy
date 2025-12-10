import 'package:flutter/material.dart';

class InformationScreen extends StatefulWidget {
  @override
  _InformationScreenState createState() => _InformationScreenState();
}

class _InformationScreenState extends State<InformationScreen> with SingleTickerProviderStateMixin {
  List<bool> _buttonStates = [false, false, false];// functionality for button highlight color
  int selectedIndex = 3;

  void _toggleClick(int index) {
    setState(() {
      for(int i = 0; i < _buttonStates.length; i++ ){
        _buttonStates[i] = false;
        selectedIndex = 3;
      }
      _buttonStates[index] = !_buttonStates[index];
      selectedIndex = index;
    });
  }

  late AnimationController _controller; //animations
  late Animation<Offset> _iconSlideAnimation;
  late Animation<double> _iconScaleAnimation;
  late Animation<Offset> _textSlideAnimation;
  late Animation<double> _textOpacityAnimation;
  late Animation<double> _headOpacityAnimation;

  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );

    _iconSlideAnimation = Tween<Offset>(
      begin: Offset(0, 0),
      end: Offset(1.5, 0), // Move left
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _iconScaleAnimation = Tween<double>(
      begin: 2.0,
      end: 0.5,
    ).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _textSlideAnimation = Tween<Offset>(
      begin: Offset(-1, 1.2),
      end: Offset(0.3, 1.2),
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.5, 1.0, curve: Curves.easeInOut),
      ),
    );

    _textOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
      ),
    );

    _headOpacityAnimation = Tween<double>(
      begin: 0.0,
      end: 1.0,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.8, 1.0, curve: Curves.easeInOut),
      ),
    );

    _controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    var mediaQuery = MediaQuery.of(context);

    ButtonStyle _getButtonStyle(int index) {
      return ElevatedButton.styleFrom(
        backgroundColor: _buttonStates[index] ? Colors.green.shade800 : Colors.white,
        foregroundColor: _buttonStates[index] ? Colors.white : Colors.black,
      );
    }

    // Dit zijn de widgets die verschijnen bij de verschillende knoppen de indexes gaan van links naar rechts
    Widget _getWidgetForSelectedButton() {
      switch (selectedIndex) {
        case 0:
          return Container( //Mindfulness informatie pagina
            padding: EdgeInsets.all(25),
            child: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10, width: 20,),
                  Text(
                    'Wat is Mindfulness',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                  'Mindfulness is de praktijk van volledig aanwezig en betrokken zijn in het moment, '
                  'bewust van je gedachten, gevoelens en omgeving zonder oordeel. Het gaat om '
                  'het cultiveren van een gevoel van kalmte en focus, waarmee je op een doordachte manier kunt reageren op de uitdagingen van het leven '
                  ' in plaats van impulsief te reageren.\n\n'
                  'Deze praktijk heeft zijn oorsprong in oude meditatietradities, maar wordt nu algemeen erkend vanwege de voordelen in het moderne leven. '
                  'Mindfulness kan helpen stress te verminderen, mentale helderheid te verbeteren en het emotionele welzijn te bevorderen. Door je geest te trainen om in het moment te blijven, kun je ontsnappen aan de '
                  'grip van zorgen over de toekomst of spijt over het verleden.\n\n'
                  'Mindfulness kan worden beoefend door meditatie, mindful ademhalen, of zelfs eenvoudige dagelijkse activiteiten '
                  'zoals eten, wandelen of luisteren. Het belangrijkste is om je volledige aandacht te richten op de ervaring, het opmerken van '
                  'de sensaties, emoties en gedachten die opkomen zonder te proberen ze te veranderen of te oordelen.\n\n'
                  'In een wereld vol afleidingen biedt mindfulness een krachtige manier om opnieuw contact te maken met jezelf en '
                  'balans te vinden in je dagelijks leven. Het nodigt je uit om langzamer te gaan, het moment te omarmen en binnenin rust te ontdekken.',

                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        case 1:
          return Container( //over ons pagina
            padding: EdgeInsets.all(25),
            child: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    'Over ons',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'Deze app is gecreëerd om studenten thuis aan mindfulness te laten werken',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        case 2:
          return Container(
            padding: EdgeInsets.all(25),
            child: const SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 10,),
                  Text(
                    'Privacy',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 23,
                        fontWeight: FontWeight.bold
                    ),
                  ),
                  SizedBox(height: 20,),
                  Text(
                    'deze pagina laat informatie zien over de privacy van een gebruiker',
                    style: TextStyle(fontSize: 16, color: Colors.black87),
                  ),
                ],
              ),
            ),
          );
        default:
          return Container(
            padding: const EdgeInsets.all(25),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const SizedBox(height: 10,),
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, _) {
                        return Opacity(
                          opacity: _headOpacityAnimation.value,
                          child:const Text(
                            'Ga je gang en klik een knop in',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 23,
                                fontWeight: FontWeight.bold
                            ),
                          ),
                        );
                      }
                  ),
                  const SizedBox(height: 50,),
                  AnimatedBuilder(
                      animation: _controller,
                      builder: (BuildContext context, _) {
                        return Opacity(
                          opacity: _headOpacityAnimation.value,
                          child: Image.asset(
                            'assets/mindful.png',
                            height: 200,
                          ),
                        );
                      }
                  ),
                ],
              ),
            ),
          );
      }
    }
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: mediaQuery.size.height/3,
            child: Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/jungle-bg.webp"),
                  fit: BoxFit.cover,
                ),
              ),
              child: Stack(
                children: [
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, _){
                      return Transform.translate(
                        offset: _iconSlideAnimation.value*100,
                        child: Transform.scale(
                          scale: _iconScaleAnimation.value,
                          child: Image.asset('assets/info.png'),
                        ),
                      );
                    },
                  ),
                  AnimatedBuilder(
                    animation: _controller,
                    builder: (BuildContext context, _){
                      return Opacity(
                        opacity: _textOpacityAnimation.value,
                        child: Transform.translate(
                          offset: _textSlideAnimation.value * 100,
                          child: Text(
                            'Informatie',
                            style: TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 50,
            left: 10,
            child: IconButton(
                onPressed: ()
                {
                  Navigator.pop(context);
                },
                color: Colors.white,
                icon: Icon(Icons.arrow_back_ios)
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: mediaQuery.size.height / 1.43,
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.topRight,
                      colors: [Colors.white, Colors.white70]
                  ),
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(30),
                    topRight: Radius.circular(30),
                  )
              ),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 30),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ElevatedButton(
                              style: _getButtonStyle(0),
                              child: Text(
                                  'Mindfulness'
                              ),
                              onPressed: () {
                                _toggleClick(0);
                              }
                          ),
                          ElevatedButton(
                              style: _getButtonStyle(1),
                              child: Text(
                                  'Over ons'
                              ),
                              onPressed: () {
                                _toggleClick(1);
                              }
                          ),
                          ElevatedButton(
                              style: _getButtonStyle(2),
                              child: Text(
                                  'Privacy'
                              ),
                              onPressed: () {
                                _toggleClick(2);
                              }
                          ),
                        ],
                      ),
                    ),
                    _getWidgetForSelectedButton(),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
