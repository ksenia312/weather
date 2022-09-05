import 'package:flutter/material.dart';

abstract class AppColors {
  get scaffold {}

  get appBar {}

  get foreground {}

}

class ColorsLight implements AppColors {
  @override
  get appBar => const Color(0xFFFCFDFF);

  @override
  get scaffold => const Color(0xFFFCFDFF);

  @override
  get foreground => Colors.indigo.shade900;
}

class ColorsDark implements AppColors {
  @override
  get appBar => const Color(0xff08224f);

  @override
  get scaffold => const Color(0xff04183a);

  @override
  get foreground => const Color(0xFFD9DEEA);
}
