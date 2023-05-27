import 'package:Lucky_or_Not/auth_pages/login_page.dart';
import 'package:Lucky_or_Not/models/navigation_item.dart';
import 'package:Lucky_or_Not/provider/navigation_provider.dart';
import 'package:Lucky_or_Not/sign_in_methods/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'phase_selection_page.dart';


class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> with TickerProviderStateMixin {

  late final AnimationController controller;

  bool isPressed = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(
        vsync: this,
        duration:Duration(seconds: 3)
    );
    controller.forward();
  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromRGBO(50,55, 205,1),
      ),
      drawer: NavigationDrawerWidget(),
      backgroundColor: Colors.grey[300],
      body: Center(
        child: Column(
          children: [
            SizedBox(
              height: 300,
              width: 200,
              child: Lottie.asset(
                  'assets/lottiefiles/86992-question-mark.zip',
                controller: controller,
             ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Color.fromRGBO(50,55, 205,1)),
                onPressed: isPressed ? () {
                  setState(() {
                    isPressed = false;
                  });
                  controller.reverse();
                  Future.delayed(const Duration(seconds: 3), () async{
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) =>  PhaseSelectionPage(title: '')
                    ));
                  });
                }: null,
                    child: Text('Play')),
            SizedBox(height: 10,),
            isPressed ? Text('') : SizedBox(
                height: 200,
                width: 200,
                child: Lottie.asset('assets/lottiefiles/97930-loading.zip'))
          ],
        ),
      ),
    );
  }
}

class NavigationDrawerWidget extends StatefulWidget {
   NavigationDrawerWidget({Key? key}) : super(key: key);

  @override
  State<NavigationDrawerWidget> createState() => _NavigationDrawerWidgetState();
}

class _NavigationDrawerWidgetState extends State<NavigationDrawerWidget> with SingleTickerProviderStateMixin {
  final email = FirebaseAuth.instance.currentUser!.email!;

  late final AnimationController controller;

  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = AnimationController(vsync: this,
    duration: Duration(seconds: 4));
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 20),
        color: Color.fromRGBO(50,55, 205,1),
        child: ListView(
          children:<Widget>[
            DrawerHeader(
              child: Container(
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.black),
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.white
                ),
                child: Column(
                  children: [
                    SizedBox(height:10),
                    Icon(Icons.verified_user,size: 50),
                  Text('Logged in'),
                    Text('as'),
                    Text('$email')
                  ],
                ),
              ),
            ),
            SizedBox(height: 24,),
             buildMenuItem(
              context,
              item: NavigationItem.home_filled,
              text: 'Main Page',
              icon: Icons.home_filled
            ),
            SizedBox(height: 25),
            buildMenuItem(
                context,
                item: NavigationItem.score,
                text: 'See Score Table ',
                icon: Icons.score
            ),
            SizedBox(height: 25),
            buildMenuItem(
                context,
                item: NavigationItem.store,
                text: 'Store Your Questions',
                icon: Icons.store
            ),
            SizedBox(height: 20,),
            Divider(color: Colors.white70,),
            SizedBox(height: 20,),
            TextButton(
                onPressed: () {
                  controller.forward();
                  setState(() {
                    isLoading = true;
                  });
                  Future.delayed(const Duration(seconds: 4), () async{
                    await signOut();
                    Navigator.of(context).pushReplacement(MaterialPageRoute(
                        builder: (context) => LoginPage()
                      ));
                    });
                  },
                child: Text('Log Out',style: TextStyle(color: Colors.white),)),
           Container(
             decoration: BoxDecoration(
                 border: Border.all(color: Colors.black),
                 borderRadius: BorderRadius.circular(10),
                 color: Colors.white
             ),
                height: 50,
                width: 50,
                child: Lottie.asset(
                  'assets/lottiefiles/10327-waving-hello-and-goodbye.zip',
                  controller: controller,
                )
           ),
            isLoading ? Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Logging out...',style: TextStyle(color: Colors.white),),
              ],
            )
                : Text('')
          ],
        ),
      ),
    );
  }
  Widget buildMenuItem(
      BuildContext context,
      {required String text,
        required IconData icon,
      required NavigationItem item}) {

    final color = Colors.white;

    final provider = Provider.of<NavigationProvider>(context);

    final currentItem = provider.navigationItem;
    final isSelected = item == currentItem;

    return Material(
      color: Colors.transparent,
      child: ListTile(
        selected: isSelected,
          selectedTileColor: Colors.white24,
          leading: Icon(icon,color: color),
          title: Text(text,style: TextStyle(color: color,fontSize: 16)),
        onTap: () => selectedItems(context,item),
      ),
    );
  }
  selectedItems(BuildContext context, NavigationItem item) {
    final provider = Provider.of<NavigationProvider>(context,listen:false);
    provider.setNavigationItem(item);
  }
}

