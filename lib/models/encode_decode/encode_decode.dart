import 'dart:convert';

class EncodeDecode{
    static String encode(List<int> dd) => json.encode(
        dd
            .map<int>((e) => e)
            .toList(),
      );

  static List<int> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<int>((e) => e)
          .toList();
}