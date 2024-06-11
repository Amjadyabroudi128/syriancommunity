
  import 'package:flutter/cupertino.dart';
 class Validate {
   static final formKey = GlobalKey<FormState>();
    validating () {
    return Validate.formKey.currentState!.validate();
   }
 }
