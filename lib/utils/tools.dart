import 'package:flutter/cupertino.dart';
import 'package:jnvst_prep/providers/user_provider.dart';
import 'package:logger/logger.dart';
import 'package:provider/provider.dart';

logEvent(String msg,) => Logger().w(msg);
logError(String msg, String error) => Logger().e(msg,error: error);
getHeight(context) => MediaQuery.sizeOf(context).height;
getWidth(context) => MediaQuery.sizeOf(context).width;
UserProvider getUserProvider(context) => Provider.of<UserProvider>(context, listen: false);
SizedBox space(double h) => SizedBox(height: h,);