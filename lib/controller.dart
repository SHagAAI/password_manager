
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:passwd_manager/model/my_account.dart';
import 'package:passwd_manager/model/my_pin.dart';
import 'package:passwd_manager/objectbox.g.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as p;

class Controller extends GetxController {
  Store? _store;
  PinModel? myPin;
  List<MyAccount>? myAccountList;

  final _loginFormKey = GlobalKey<FormState>();
  final _newPasswordFormKey = GlobalKey<FormState>();
  final _makeMasterPasswordFormKey = GlobalKey<FormState>();
  final _pageController = PageController(initialPage: 0);

  // final TextEditingController _titleC = TextEditingController();
  // final TextEditingController _usernameC = TextEditingController();
  // final TextEditingController _passwordC = TextEditingController();
  
  

  Future<Store> initializeStore(String fromWhere) async {
    

    final pathS = await getApplicationDocumentsDirectory(); // INI FUTURE FUNCTION. HARUS DI AWAIT

    // KALO GK FUTURE, VARIABLE 'path' GK BISA DI AKSES. WHY ??
    _store = Store(getObjectBoxModel(),
      directory: p.join(pathS.path, 'passwordManager')
    );
    
    return _store!;
  }

  Future<PinModel?> getPin() async {
    if (_store == null) {
      await initializeStore('dari getPin - controller.dart');
      
    }
    Query<PinModel> pinQuery = _store!.box<PinModel>().query().build();
    myPin = pinQuery.findFirst();
    return myPin;
    
  }

  makeNewPin(String thePin) async {
    PinModel newPin = PinModel(thePin);
    if (_store == null || _store!.isClosed()) {
      await initializeStore('dari makeNewPin - controller.dart');
    }
    _store!.box<PinModel>().put(newPin);
  }

  bool validateInputPin(String pin){
    // Always called when sign in.
    // Always called after executing getPin() somewhere in the tree, so myPin never null or empty
    if (pin == myPin!.mypin) {
      _loginFormKey.currentState?.reset();
      return true;
    }

    return false;
  }


  Future<bool> updatePin(String newPin, String oldPin) async {
    // Always called after executing getPin() somewhere in the tree, so myPin never null or empty
    // But just to make sure, lets just 'if check' it
    
    getPin();
    if (myPin != null) {
      
      if (validateInputPin(oldPin)) {
        if (_store == null || _store!.isClosed()) {
          await initializeStore('dari updatePin - controller.dart');
        }
        
        // Actually You dont have to put query here because only have 1 record.
        var myQuery =  _store!.box<PinModel>().query(PinModel_.id.equals(myPin!.id)).build();
        
        // var myQuery =  _store!.box<PinModel>().query().build();
        
        var existedPin =  myQuery.find();
        myQuery.close();

        // Update PIN
        existedPin[0].mypin = newPin;
        _store!.box<PinModel>().put(existedPin[0]);
        return true;
      }
      return false;
    }
    return false;
  }

  Future<List<MyAccount>> getData() async {
    if (_store == null || _store!.isClosed()) {
      await initializeStore('dari getPin - controller.dart');
      
    }
    Query<MyAccount> pinQuery = _store!.box<MyAccount>().query().build();
    myAccountList = pinQuery.find();
    pinQuery.close();
    return myAccountList!;
  }

  Future<void> addNewAccountData(MyAccount myAccountData) async {
    if (_store == null) {
      await initializeStore('dari getPin - controller.dart');
      
    }
    _store!.box<MyAccount>().put(myAccountData);
    update();
  }

  updateAccountData(MyAccount updateAcc) async {
    if (_store == null || _store!.isClosed()) {
      await initializeStore('dari getPin - controller.dart');
    }

    _store!.box<MyAccount>().put(updateAcc, mode: PutMode.update);
  
  }

  deleteAccountData(MyAccount deleteThis) async {
    if (_store == null || _store!.isClosed()) {
      await initializeStore('dari getPin - controller.dart');
    }

    _store!.box<MyAccount>().remove(deleteThis.id);
    update();
  }

  get thePin {
    return myPin!.mypin;
  }

  get myAccountData => myAccountList;

  get formKey {
    return _loginFormKey;
  }

  get makePasswordKey {
    return _newPasswordFormKey;
  }
  
  get masterPasswordKey {
    return _makeMasterPasswordFormKey;
  }

  get pageController {
    return _pageController;
  }

  
}