import 'package:sqlite_kullanimi/Kisiler.dart';
import 'package:sqlite_kullanimi/VeritabaniYardimcisi.dart';

class Kisilerdao {

  Future<List<Kisiler>> tumKisiler() async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler");

    return List.generate(maps.length, (i) {

      var satir = maps[i];

      return Kisiler(satir["kisi_id"],satir["kisi_ad"],satir["kisi_yas"]);

    });
  }
  Future<void> kisiEkle(String kisi_ad,int kisi_yas) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String, dynamic>();
    bilgiler["kisi_ad"] = kisi_ad;
    bilgiler["kisi_yas"] = kisi_yas;

    await db.insert("kisiler", bilgiler);
  }

  Future<void> kisiSil(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    await db.delete("kisiler",where: "kisi_id = ?",whereArgs: [kisi_id]);
  }

  Future<void> kisiGuncelle(int kisi_id,String kisi_ad,int kisi_yas) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    var bilgiler = Map<String,dynamic>();
    bilgiler["kisi_ad"] = kisi_ad;
    bilgiler["kisi_yas"] = kisi_yas;

    await db.update("kisiler", bilgiler,where: "kisi_id=?",whereArgs: [kisi_id]);
  }

  Future<int> kayitKontrol(String kisi_ad) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT count(*) AS sonuc FROM kisiler WHERE kisi_ad='$kisi_ad'");

    return maps[0]["sonuc"];
  }

  Future<Kisiler> kisiGetir(int kisi_id) async {
    var db = await VeritabaniYardimcisi.veritabaniErisim();

    List<Map<String,dynamic>> maps = await db.rawQuery("SELECT * FROM kisiler WHERE kisi_id=$kisi_id");

    var satir = maps[0];

    return Kisiler(satir["kisi_id"],satir["kisi_ad"],satir["kisi_yas"]);
  }




}