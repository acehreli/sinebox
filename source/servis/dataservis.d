module servis.dataservis;

import d2sqlite3;
import std.typecons : Nullable;

import std.file;
import std.json;
import std.conv;

public import model.film;

final class DataServis
{
    private Database db;

    public this()
    {
        db = Database("/media/depo/Projeler/d/sinebox/source/data/sinema.sqlite3");
    }

    public void ekle(Film film)
    {
        string ekle = "INSERT INTO filmler (orjinal_adi,turkce_adi,yil,format,dil,tur,poster,konu) "~
                      "VALUES (:orjinal_adi,:turkce_adi,:yil,:format,:dil,:tur,:poster,:konu)";

        Statement stat = db.prepare(ekle);
        stat.bind(":orjinal_adi", film.orjinalAdi);
        stat.bind(":turkce_adi", film.turkceAdi);
        stat.bind(":yil", film.yil);
        stat.bind(":format", film.format);
        stat.bind(":dil", film.dil);
        stat.bind(":tur", film.tur);
        stat.bind(":poster", film.poster);
        stat.bind(":konu", film.konu);

        stat.execute();
        stat.reset();
    }

    public Film[] liste()
    {
        ResultRange filmler = db.execute("SELECT * FROM filmler");

        Film[] liste;
        foreach (Row film; filmler)
        {
            Film f;
            f.id = film["id"].as!int;
            f.orjinalAdi = film["orjinal_adi"].as!string;
            f.turkceAdi = film["turkce_adi"].as!string;
            f.yil = film["yil"].as!string;
            f.format = film["format"].as!string;
            f.dil = film["dil"].as!string;
            f.tur = film["tur"].as!string;
            f.poster = film["poster"].as!string;
            f.konu = film["konu"].as!string;
            liste ~= f;
        }

        return liste;
    }

    public Film kayit(string id)
    {
        ResultRange filmler = db.execute("SELECT * FROM filmler WHERE id = " ~ id);

        Film f;
        foreach (Row film; filmler)
        {
            f.id = film["id"].as!int;
            f.orjinalAdi = film["orjinal_adi"].as!string;
            f.turkceAdi = film["turkce_adi"].as!string;
            f.yil = film["yil"].as!string;
            f.format = film["format"].as!string;
            f.dil = film["dil"].as!string;
            f.tur = film["tur"].as!string;
            f.poster = film["poster"].as!string;
            f.konu = film["konu"].as!string;
        }

        return f;
    }

    public void duzenle(Film film)
    {
        string duzenle = "UPDATE filmler SET orjinal_adi=:orjinal_adi,turkce_adi=:turkce_adi,"~
                         "yil=:yil,format=:format,dil=:dil,tur=:tur,poster=:poster,konu=:konu "~
                         "WHERE id = :id";

        Statement stat = db.prepare(duzenle);
        stat.bind(":orjinal_adi", film.orjinalAdi);
        stat.bind(":turkce_adi", film.turkceAdi);
        stat.bind(":yil", film.yil);
        stat.bind(":format", film.format);
        stat.bind(":dil", film.dil);
        stat.bind(":tur", film.tur);
        stat.bind(":id", film.id);
        stat.bind(":poster", film.poster);
        stat.bind(":konu", film.konu);

        stat.execute();
        stat.reset();
    }

    public int sil(string filmId)
    {
        string sil = "DELETE FROM filmler WHERE id = :id";

        Statement stat = db.prepare(sil);
        stat.bind(":id", filmId);

        stat.execute();
        stat.reset();

        return db.totalChanges;
    }
}
