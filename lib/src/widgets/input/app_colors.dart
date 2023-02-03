import 'package:flutter/material.dart';
//import 'package:stories_editor/src/presentation/utils/Extensions/hexColor.dart';

class AppColors {
  static const defaultColors = [
    Colors.white,
    Colors.black,
    Colors.blue,
    Colors.green,
    Colors.orange,
    Colors.red,
    Colors.pink,
    //Colors.purple,
    Colors.deepPurple,
    //Colors.indigo,

    //Colors.lightBlue,
    //Colors.cyan,
    //Colors.teal,

    //Colors.lightGreen,
    //Colors.lime,
    //Colors.yellow,
    //Colors.amber,

    //Colors.deepOrange,
    //Colors.brown,
    //Colors.grey,
    //Colors.blueGrey,
  ];
  List<Color>? get colorList => defaultColors;

  // static List<List<Color>> gradientBackgroundColors = [
  //   [
  //     const Color.fromRGBO(31, 179, 237, 1),
  //     const Color.fromRGBO(17, 106, 197, 1)
  //   ],
  //   [
  //     const Color.fromRGBO(240, 19, 77, 1),
  //     const Color.fromRGBO(228, 0, 124, 1)
  //   ],
  //   [
  //     const Color.fromRGBO(255, 190, 32, 1),
  //     const Color.fromRGBO(251, 112, 71, 1)
  //   ],
  //   [
  //     const Color.fromRGBO(255, 255, 255, 1),
  //     const Color.fromRGBO(234, 236, 255, 1)
  //   ],
  //   [HexColor.fromHex('#2AA8F2'), HexColor.fromHex('#A800FF')],
  //   [HexColor.fromHex('#A800FF'), HexColor.fromHex('#2AA8F2')],
  //   [HexColor.fromHex('#A800FF'), HexColor.fromHex('#FF0900')],
  //   [
  //     HexColor.fromHex('#33CD11'),
  //     HexColor.fromHex('#33CD75'),
  //     HexColor.fromHex('#0099FF')
  //   ],
  //   [HexColor.fromHex('#FF0043'), HexColor.fromHex('#FFAA20')],
  //   [HexColor.fromHex('#9911AA'), HexColor.fromHex('#FF0013')],
  //   [HexColor.fromHex('#323232'), HexColor.fromHex('#354047')],
  //   [HexColor.fromHex('#A9AAAE'), HexColor.fromHex('#C8CACA')],
  //   [
  //     HexColor.fromHex('#FF0033'),
  //     HexColor.fromHex('#FF8800'),
  //     HexColor.fromHex('#FFAA00'),
  //     HexColor.fromHex('#009508'),
  //     HexColor.fromHex('#0078FF'),
  //     HexColor.fromHex('#8001AA')
  //   ],
  //   [const Color(0xFFee9ca7), const Color(0xFFffdde1)],
  //   [const Color(0xFF2193b0), const Color(0xFF6dd5ed)],
  //   [const Color(0xFFb92b27), const Color(0xFF1565C0)],
  //   [const Color(0xFF373B44), const Color(0xFF4286f4)],
  //   [const Color(0xFFbdc3c7), const Color(0xFF2c3e50)],
  //   [const Color(0xFF00416A), const Color(0xFFE4E5E6)],
  //   [const Color(0xFFFFE000), const Color(0xFF799F0C)],
  //   [const Color(0xFF4364F7), const Color(0xFF6FB1FC)],
  //   [const Color(0xFF799F0C), const Color(0xFFACBB78)],
  //   [const Color(0xFFffe259), const Color(0xFFffa751)],
  //   [const Color(0xFF536976), const Color(0xFF292E49)],
  //   [const Color(0xFF1488CC), const Color(0xFF2B32B2)],
  //   [const Color(0xFFec008c), const Color(0xFFfc6767)],
  //   [const Color(0xFFcc2b5e), const Color(0xFF753a88)],
  //   [const Color(0xFF2193b0), const Color(0xFF6dd5ed)],
  //   [const Color(0xFF2b5876), const Color(0xFF4e4376)],
  //   [const Color(0xFFff6e7f), const Color(0xFFbfe9ff)],
  //   [const Color(0xFFe52d27), const Color(0xFFb31217)],
  //   [const Color(0xFF603813), const Color(0xFFb29f94)],
  //   [const Color(0xFF16A085), const Color(0xFFF4D03F)],
  //   [const Color(0xFFD31027), const Color(0xFFEA384D)],
  //   [const Color(0xFFEDE574), const Color(0xFFE1F5C4)],
  //   [const Color(0xFF02AAB0), const Color(0xFF00CDAC)],
  //   [const Color(0xFFDA22FF), const Color(0xFF9733EE)],
  //   [const Color(0xFF348F50), const Color(0xFF56B4D3)],
  //   [const Color(0xFFF09819), const Color(0xFFEDDE5D)],
  //   [const Color(0xFFFF512F), const Color(0xFFDD2476)],
  //   [const Color(0xFF1A2980), const Color(0xFF26D0CE)],
  //   [const Color(0xFFFF512F), const Color(0xFFF09819)],
  //   [const Color(0xFFEB3349), const Color(0xFFF45C43)],
  //   [const Color(0xFF1D976C), const Color(0xFF93F9B9)],
  //   [const Color(0xFFFF8008), const Color(0xFFFFC837)],
  //   [const Color(0xFF16222A), const Color(0xFF3A6073)],
  //   [const Color(0xFF4776E6), const Color(0xFF8E54E9)],
  //   [const Color(0xFF232526), const Color(0xFF414345)],
  //   [const Color(0xFF00c6ff), const Color(0xFF0072ff)],
  //   [const Color(0xFFe6dada), const Color(0xFF274046)],
  //   [const Color(0xFFece9e6), const Color(0xFFffffff)],
  //   [const Color(0xFF11998e), const Color(0xFF38ef7d)],
  //   [const Color(0xFFff9a9e), const Color(0xFFfad0c4)],
  //   [const Color(0xFFa18cd1), const Color(0xFFfbc2eb)],
  //   [const Color(0xFFfad0c4), const Color(0xFFffd1ff)],
  //   [const Color(0xFFffecd2), const Color(0xFFfcb69f)],
  //   [const Color(0xFFff9a9e), const Color(0xFFfecfef)],
  //   [const Color(0xFFf6d365), const Color(0xFFfda085)],
  //   [const Color(0xFFfbc2eb), const Color(0xFFa6c1ee)],
  //   [const Color(0xFFfdcbf1), const Color(0xFFe6dee9)],
  //   [const Color(0xFFa1c4fd), const Color(0xFFc2e9fb)],
  //   [const Color(0xFFd4fc79), const Color(0xFF96e6a1)],
  // ];
}
