import 'package:base/beranda/utils/menu_beranda.dart';
import 'package:base/beranda/view/beranda_view.dart';
import 'package:core/core.dart';
import 'package:flutter/material.dart';

class BerandaController extends State<BerandaView> {
  static late BerandaController instance;
  late BerandaView view;

  DataUser? roleData;
  MenuBeranda menuBeranda = MenuBeranda();

  @override
  void initState() {
    instance = this;

    roleData = UserDataDatabase.userDataModel.data;

    super.initState();
  }

  @override
  void dispose() => super.dispose();

  @override
  Widget build(BuildContext context) => widget.build(context, this);
}
