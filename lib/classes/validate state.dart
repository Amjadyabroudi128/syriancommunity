
  import 'package:flutter/cupertino.dart';
  class Validate {
    static final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    static validating() {
      final formState = formKey.currentState;
      if (formState != null) {
        return formState.validate();
      }
      return false;
    }
  }

