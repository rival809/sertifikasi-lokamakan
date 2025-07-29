import 'package:core/core.dart';
import 'package:flutter/material.dart';

class UpdateNopol {
  final bool statusHitam;
  final bool statusPutih;
  final bool statusMerah;
  final bool statusKuning;
  final Color warnaPlat;
  final Color warnaBorder;
  final Color warnaFont;
  final Color warnaPlaceholder;
  final String kodePlat;

  const UpdateNopol({
    this.statusHitam = true,
    this.statusPutih = false,
    this.statusMerah = false,
    this.statusKuning = false,
    this.warnaPlat = gray900,
    this.warnaBorder = gray100,
    this.warnaFont = gray100,
    this.warnaPlaceholder = gray100,
    this.kodePlat = "1",
  });
}
