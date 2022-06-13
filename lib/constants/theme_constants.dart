import 'package:flutter/material.dart';
class ThemeConst {
    Color primary  = const Color(0xfffc5142);
    Color spare = const Color(0xfffc7462);
    bool isDark;

    ThemeConst({required this.isDark});

    ThemeData get themeData {
        TextTheme txtTheme = (isDark ? ThemeData.dark() : ThemeData.light()).textTheme;
        Color txtColor = txtTheme.bodyText1!.color!;
        ColorScheme colorScheme = ColorScheme(
            // Decide how you want to apply your own custom them, to the MaterialApp
            brightness: isDark ? Brightness.dark : Brightness.light,
            primary: spare,
            secondary: spare,
            background: isDark ? Colors.black : Colors.white,
            surface: primary,
            onBackground: txtColor,
            onSurface: txtColor,
            onError: Colors.white,
            onPrimary:isDark ? Colors.black : Colors.white,
            onSecondary: isDark ? Colors.black : Colors.white,
            error: Colors.red.shade400,
        );



        /// Now that we have ColorScheme and TextTheme, we can create the ThemeData
        var themeConst = ThemeData.from(textTheme: txtTheme, colorScheme: colorScheme)
        // We can also add on some extra properties that ColorScheme seems to miss
            .copyWith( highlightColor: spare, toggleableActiveColor: spare);

        /// Return the themeData which MaterialApp can now use
        return themeConst;
    }


    static ThemeData lightTheme = ThemeData(
        brightness: Brightness.light,
        primaryColor: const Color(0xfffc7462),
        textTheme: const TextTheme(
        titleMedium: TextStyle(color: Color(0xfffc7462),),
        ),
        hoverColor: Colors.deepOrange,
    );

     static ThemeData darkTheme = ThemeData(
        brightness: Brightness.dark,
    );


}
