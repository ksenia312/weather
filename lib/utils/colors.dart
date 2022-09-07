import 'package:flutter/material.dart';

/// Абстрактный класс [AppColors] для задания цветов приложения
abstract class AppColors {
  get scaffold {}

  get appBarBackground {}

  get primaryLight {}

  get foreground {}

  get accentForeground {}

  get dividerColor {}

  get error {}

  get highlight {}
}

class ColorsLight implements AppColors {
  @override
  get appBarBackground => const Color(0xFFFCFDFF);

  @override
  get scaffold => const Color(0xFFF7F9FD);

  @override
  get foreground => Colors.indigo;

  @override
  get primaryLight => const Color(0xFFFCFDFF);

  @override
  get accentForeground => Colors.indigo.shade900;

  @override
  get dividerColor => Colors.indigo.shade500;

  @override
  get error => const Color(0xFF8F0A31);

  @override
  get highlight => const Color(0xFF9F00FF);
}

class ColorsDark implements AppColors {
  @override
  get appBarBackground => const Color(0xff090e3f);

  @override
  get scaffold => const Color(0xff0e1452);

  @override
  get foreground => const Color(0xFFD9DEEA);

  @override
  get primaryLight => const Color(0xff181f6b);

  @override
  get accentForeground => const Color(0xFFD9DEEA);

  @override
  get dividerColor => const Color(0xFFD9DEEA);

  @override
  get error => const Color(0xFFFF9EC6);

  @override
  get highlight => const Color(0xFFDCACFF);
}
