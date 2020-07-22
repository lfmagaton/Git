import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_crud/data/dummy_users.dart';
import 'package:flutter_crud/models/users.dart';

//Padrão "observer" ChangeNotifier
class Users with ChangeNotifier {
  final Map<String, User> _items = {...DUMMY_USERS};

  List<User> get all {
    return [
      ..._items.values
    ]; //retorna clone dos dados através do operador "..." spread
  }

  int get count {
    return _items.length;
  } //retorna a quantidade de items

  User byIndex(int i) {
    return _items.values.elementAt(i);
  }

  void put(User user) {
    if (user == null) {
      return;
    }

    if (user.id != null &&
        !user.id.trim().isNotEmpty &&
        _items.containsKey(user.id)) {
      _items.update(
        user.id,
        (value) => User(
          id: user.id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    } //altera
    else {
      //adicionar
      final id = Random()
          .nextDouble()
          .toString(); //Gera um ID randomico via "import 'dart:math';"

      _items.putIfAbsent(
        id,
        () => User(
          id: id,
          name: user.name,
          email: user.email,
          avatarUrl: user.avatarUrl,
        ),
      );
    }

    //adicionar
    //ou alterar

    notifyListeners(); //atualiza tela - provider notificado
  }
}
