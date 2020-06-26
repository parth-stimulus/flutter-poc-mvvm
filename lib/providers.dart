import 'package:poc/services/firebase_services.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';
import 'package:poc/services/authentication_service.dart';

//
//import 'core/models/user.dart';
//import 'core/services/api.dart';

List<SingleChildWidget> providers = [
  ...independentServices,
  ...dependentServices,
//  ...uiConsumableProviders
];

List<SingleChildWidget> independentServices = [
  Provider.value(value: FirebaseServices())
];

List<SingleChildWidget> dependentServices = [
  ProxyProvider<FirebaseServices, AuthenticationService>(
    update: (context, firebaseServices, authenticationService) =>
        AuthenticationService(firebaseServices: firebaseServices),
  )
];

//List<SingleChildWidget> uiConsumableProviders = [
//  StreamProvider<User>(
//    create: (context) =>
//    Provider.of<AuthenticationService>(context, listen: false).user,
//  )
//];
