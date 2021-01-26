
import 'package:facility_maintenance/Screens/Personal_Data_user/personal_data_user.dart';
import 'package:facility_maintenance/constants.dart';
import 'package:facility_maintenance/injection_container.dart' as di;
import 'package:facility_maintenance/model/fcm_notification_model.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'Screens/Home_Page_employee/home_employee.dart';
import 'Screens/Home_Page_user/home_user.dart';
import 'Screens/Internal_Requests/create_hvac_request.dart';
import 'Screens/Internal_Requests/hvac_requests.dart';
import 'Screens/Internal_Sections_employee/internal_sections_employee.dart';
import 'Screens/Internal_Sections_user/internal_sections_user.dart';
import 'Screens/Welcome/welcome_screen.dart';
import 'data/repositories/shared_preferences.dart';
import 'injection_container.dart';

final RouteObserver<PageRoute> routeObserver = RouteObserver<PageRoute>();

typedef ExceptionCallback = void Function(dynamic exception);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await di.init();
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, dynamic> message;

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FIX IT',
      theme: ThemeData(
        primaryColor: kPrimaryColor,
        scaffoldBackgroundColor: Colors.white,
      ),
      home: RouteAwareWidget(
        '/inter',
        child: ChangeRouteScreen(),
      ),
      routes: {
        '/inter': (context) => ChangeRouteScreen(),
        '/userhome': (context) => HomeUserScreen(),
        '/welcomeScreen': (context) => WelcomeScreen(),
        '/employeehome': (context) => HomeEmployeeScreen(),
        '/employee_in_sections': (context) => InternalSectionsEmployee(),
        '/user_in_sections': (context) => InternalSectionsUser(),
        '/user_personal_data': (context) => PersonalDataScreen(),
        '/hvac_requests': (context) => HVACRequests(),
        '/create_hvac_request': (context) => CreateHVACRequest(),
      },
    );
  }
}
//---------------------------------------------------------------------
///  [RouteAwareWidget]implementing RouteAware in each
///  screen would  change
//---------------------------------------------------------------------

class RouteAwareWidget extends StatefulWidget {
  final String name;
  final Widget child;

  RouteAwareWidget(this.name, {@required this.child});

  @override
  State<RouteAwareWidget> createState() => RouteAwareWidgetState();
}

// Implement RouteAware in a widget's state and subscribe it to the RouteObserver.
class RouteAwareWidgetState extends State<RouteAwareWidget> with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context));
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  // Called when the current route has been pushed.
  void didPush() {
    // print('didPush ${widget.name}');
  }

  @override
  // Called when the top route has been popped off, and the current route shows up.
  void didPopNext() {
    print('didPopNext ${widget.name}');
  }

  @override
  Widget build(BuildContext context) => widget.child;
}

///  [PreviousRouteObserver] to Observing the action of changes in launching
///  screens in case of push notifications

class PreviousRouteObserver extends NavigatorObserver {
  Route _previousRoute;

  Route get previousRoute => _previousRoute;

  String get previousRouteName => _previousRoute.settings.name;

  @override
  void didPush(Route<dynamic> route, Route<dynamic> previousRoute) {
    _previousRoute = previousRoute;
  }

  @override
  void didReplace({Route<dynamic> newRoute, Route<dynamic> oldRoute}) {
    _previousRoute = oldRoute;
  }
}

class ChangeRouteScreen extends StatefulWidget {
  @override
  createState() => _ChangeRouteScreenState();
}

class _ChangeRouteScreenState extends State<ChangeRouteScreen>
    with WidgetsBindingObserver {
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging();
  MySharedPreferences _mySharedPreferences = sl<MySharedPreferences>();

  @override
  void initState() {
    _firebaseMessaging.requestNotificationPermissions(
        const IosNotificationSettings(sound: true, badge: true, alert: true));
    _firebaseMessaging.onIosSettingsRegistered
        .listen((IosNotificationSettings settings) {
      print("Settings registered: $settings");
    });
    _firebaseMessaging.subscribeToTopic('all');
    _firebaseMessaging.getToken().then((token) {
      print("==========================TOKEN=====================\n $token");
      _mySharedPreferences.setToke(token);
      // }
    });
    _firebaseMessaging.configure(
      onMessage: (Map<String, dynamic> message) async {
        print("================onMessage===========:\n ${message}");
        FcmNotificationModel fcmNotificationModel =
            FcmNotificationModel.fromJson(message);

        _showItemDialog(fcmNotificationModel);
      },
      onLaunch: (Map<String, dynamic> message) async {
        print("================onLaunch===========:\n ${message}");
        FcmNotificationModel fcmNotificationModel =
            FcmNotificationModel.fromJson(message);
        _navigateToItemDetail(fcmNotificationModel);
      },
      onResume: (Map<String, dynamic> message) async {
        print("================onResume===========:\n ${message}");
        FcmNotificationModel fcmNotificationModel =
            FcmNotificationModel.fromJson(message);
        _navigateToItemDetail(fcmNotificationModel);
      },
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: WelcomeScreen());
  }

  //------------------------------------------------------------------------------

  void _navigateToItemDetail(FcmNotificationModel fcmNotificationModel) {
    if (fcmNotificationModel.type == FCMpayload.user) {
      Navigator.pushNamed(context, '/create_hvac_request');
    } else if (fcmNotificationModel.type == FCMpayload.employee) {
      Navigator.pushNamed(context, '/hvac_requests');
    }
  }

  //------------------------------------------------------------------------------
  void _showItemDialog(FcmNotificationModel fcmNotificationModel) {
    try {
      showDialog<bool>(
        context: context,
        builder: (_) => _buildDialog(context, fcmNotificationModel),
      ).then((bool shouldNavigate) {
        if (shouldNavigate == true) {}
      });
    } catch (e) {
      print(
          "================Error _showItemDialog message===========:\n ${e.toString()}");
    }
  }

  Widget _buildDialog(
      BuildContext context, FcmNotificationModel fcmNotificationModel) {
    return Theme(
      data:
          Theme.of(context).copyWith(dialogBackgroundColor: Colors.transparent),
      child: AlertDialog(
        content: Column(
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
                boxShadow: <BoxShadow>[
                  BoxShadow(
                    color: Colors.grey[200],
                    offset: Offset(0.0, 3.0),
                    blurRadius: 5.0,
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  /* Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                                color: Colors.white,
                                child: Text(message_title,
                                    style: TextStyle(
                                        fontSize: 18.0,
                                        color: AppTheme.grey[700],
                                        fontFamily: AppTheme.fontName,
                                        fontWeight: FontWeight.w700,),),),
                          ),*/
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        'From : ${fcmNotificationModel.senderName}',
                        style: Theme.of(context).textTheme.subtitle1,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      color: Colors.white,
                      child: Text(
                        fcmNotificationModel.messageBody == null
                            ? ''
                            : fcmNotificationModel.messageBody,
                        style: Theme.of(context).textTheme.subtitle2,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(2.0),
                    child: Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: MediaQuery.of(context).size.width / 4.3,
                          child: FlatButton(
                            color: Colors.grey,
                            child: Text(
                              "open",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            onPressed: () {
                              switch (fcmNotificationModel.type) {
                                case FCMpayload.employee:
                                  Navigator.pushNamed(
                                      context, '/create_hvac_request');
                                  break;
                                case FCMpayload.employee:
                                  Navigator.pushNamed(
                                      context, '/hvac_requests');
                                  break;
                              }
                            },
                          ),
                        ),
                        SizedBox(
                          width: 2.0,
                        ),
                        Container(
                          width: MediaQuery.of(context).size.width / 4.3,
                          child: FlatButton(
                            color: Colors.red,
                            child: Text(
                              "Cancel",
                              style: TextStyle(
                                  fontSize: 14.0, color: Colors.white),
                            ),
                            onPressed: () {
                              Navigator.pop(context, false);
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: <Widget>[],
      ),
    );
  }
}
