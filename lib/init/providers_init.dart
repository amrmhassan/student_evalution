import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../providers/user_provider.dart';
import '../theming/providers/theme_provider.dart';

class ProvidersInit {
  static List<SingleChildWidget> providers = [
    ChangeNotifierProvider(create: (context) => ThemeProvider()),
    ChangeNotifierProvider(create: (context) => UserProvider()),
  ];
}
