part of '../utils.dart';

class Routes {
  Routes._();

  static String startupPage([bool complete = true]) => "/";

  static String authModule([bool complete = true]) => "/auth/";
  static String loginPage([bool complete = true]) =>
      complete ? "/auth/login" : "/login";
  static String signUpPage([bool complete = true]) =>
      complete ? "/auth/signup" : "/signup";

  static String homeModule([bool complete = true]) => "/home/";
  static String homePage([bool complete = true]) => complete ? "/home/" : "/";
}
