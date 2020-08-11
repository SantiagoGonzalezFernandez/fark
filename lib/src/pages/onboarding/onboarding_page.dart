//Imports that are not mine
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

//Imports that are mine
import 'package:fark/src/utils/background_gradient.dart';

class OnboardingPage extends StatefulWidget {
  @override
  _OnboardingPageState createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {

  final int _numPages = 3;
  int _currentPage = 0;
  final PageController _pageController = PageController(initialPage: 0);

  List<Widget> _buildPageIndicator(){
    List<Widget> list = [];
    for(int i = 0; i < _numPages; i++){
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive){
    return AnimatedContainer(
      duration: Duration(milliseconds: 150),
      margin: EdgeInsets.symmetric(horizontal: 8.0),
      height: 8.0,
      width: isActive ? 24.0 : 16.0,
      decoration: BoxDecoration(
        color: isActive ? Colors.white : Color(0xff7B51D3),
        borderRadius: BorderRadius.all(Radius.circular(12.0))
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion<SystemUiOverlayStyle>(
        value: SystemUiOverlayStyle.light,
        child: Container(
          decoration: BoxDecoration(
            gradient: generateBackgroundGradient()
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              ButtonSkip(text: 'Saltar'),
              Container(
                height: 600.0,
                child: PageView(
                  physics: ClampingScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (int page){
                    setState(() {
                      _currentPage = page;
                    });
                  },
                  children: [
                    OnBoardingImageTextSubText(
                      svgAssetImage: 'assets/image/onboarding/onboardingOne.svg',
                      title: 'Facilidades a la hora\nde mostrarte',
                      subTitle: 'Completa la informacion necesaria y nosotros nos ocupamos de crear tu curriculum de la mejor manera.',
                    ),
                    OnBoardingImageTextSubText(
                      svgAssetImage: 'assets/image/onboarding/onboardingTwo.svg',
                      title: 'Chats privados que abren puertas',
                      subTitle: 'Chats privados con reclutadores y tambien con las personas de tu rubro para conseguir trabajo.',
                    ),
                    OnBoardingImageTextSubText(
                      svgAssetImage: 'assets/image/onboarding/onboardingThree.svg',
                      title: 'Selecciona entre muchas propuestas',
                      subTitle: 'Muchas oportunidades a solo un click.\nAnimate a creer en vos.',
                    ),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: _buildPageIndicator(),
              ),
              _currentPage != _numPages - 1 
              ? BottomButtonsPages(
                pageController: _pageController,
              ) : Text('')
            ],
          ),
        ),
      ),
      bottomSheet: _currentPage == _numPages - 1 
      ? ButtonComenzar(
        text: 'Comenzar',
      ) 
      : Text('')
    );
  }
}

class ButtonComenzar extends StatelessWidget {

  final String text;

  const ButtonComenzar({
    @required this.text
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100.0,
      width: double.infinity,
      color: Colors.white,
      child: GestureDetector(
        onTap: () => Navigator.pushReplacementNamed(context, 'login'),
        child: Center(
          child: Padding(
            padding: EdgeInsets.only(bottom: 30.0),
            child: Text(
              text,
              style: TextStyle(
                color: Color(0xff5B16D0),
                fontSize: 20.0,
                fontWeight: FontWeight.bold
              ),
            ),
          )
        ),
      ),
    );
  }
}

class ButtonSkip extends StatelessWidget {

  final String text;

  ButtonSkip({
    @required this.text
  }); 

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        alignment: Alignment.centerRight,
        child: FlatButton(
          onPressed: () => Navigator.pushReplacementNamed(context, 'login'),
          child: Text(
            text,
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.0
            ),
          ),
        ),
      ),
    );
  }
}

class OnBoardingImageTextSubText extends StatelessWidget {

  final String svgAssetImage;
  final String title;
  final String subTitle;

  OnBoardingImageTextSubText({
    @required this.svgAssetImage, 
    @required this.title, 
    @required this.subTitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(40.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: SvgPicture.asset(
              svgAssetImage,
              height: 300.0,
              width: 300.0,
            ),          
          ),
          SizedBox(
            height: 30.0,
          ),
          Text(
            title,
            style: titleStyle,
          ),
          SizedBox(
            height: 15.0,
          ),
          Text(
            subTitle,
            style: subtitleStyle,
          )
        ],
      ),
    );
  }

  final titleStyle = TextStyle(
    color: Colors.white,
    fontFamily: 'ProductSans',
    fontSize: 26.0,
    height: 1.5,
  );

  final subtitleStyle = TextStyle(
    color: Colors.white,
    fontSize: 18.0,
    height: 1.2,
  );
}

class BottomButtonsPages extends StatelessWidget {

  const BottomButtonsPages({
    @required PageController pageController,
  }) : _pageController = pageController;

  final PageController _pageController;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Expanded(
        child: Align(
          alignment: FractionalOffset.bottomRight,
          child: FlatButton(
            onPressed: (){
              _pageController.nextPage(
                duration: Duration(milliseconds: 500), 
                curve: Curves.ease
              );
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Siguiente',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 22.0
                  ),
                ),
                SizedBox(
                  width: 10.0,
                ),
                Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                  size: 30.0,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}