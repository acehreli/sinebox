module servis.filmservis;

import std.file;
import std.conv;
import std.path: extension;
import std.random: uniform;
import std.string: toLower;
import std.array: replace;

import vibe.http.server;
import vibe.web.web;
import vibe.core.file;
import vibe.core.log;

import servis.dataservis;
import std.stdio;
final class FilmServis
{

    @path("/film/liste")
    void getListe()
    {
        DataServis ds = new DataServis();
        Film[] filmler = ds.liste();

        render!("film.liste.dt", filmler);
    }

    @path("/film/form/:id")
    void getForm(string _id)
    {
        string action = "/film/ekle";
        Film film;

        if (to!int(_id) > 0)
        {
            DataServis ds = new DataServis();
            film = ds.kayit(_id);
            action = "/film/duzenle";
        }
        render!("film.form.dt", action, film);
    }

    @path("/film/ekle")
    void postEkle(HTTPServerRequest req)
    {
        string dosyaAdi = posterYukle(req);

        Film f;
        f.orjinalAdi = req.form["orjinalAdi"];
        f.turkceAdi = req.form["turkceAdi"];
        f.yil = req.form["yil"];
        f.format = req.form["format"];
        f.dil = req.form["dil"];
        f.tur = req.form["tur"];
        f.poster = dosyaAdi;
        f.konu = req.form["konu"];

        DataServis ds = new DataServis();
        ds.ekle(f);

        redirect("/film/form/0");
    }

    @path("/film/duzenle")
    void postDuzenle(HTTPServerRequest req)
    {
        string dosyaAdi = posterYukle(req);
        if (dosyaAdi == "") dosyaAdi = req.form["mevcutPoster"];

        Film f;
        f.id = to!int(req.form["id"]);
        f.orjinalAdi = req.form["orjinalAdi"];
        f.turkceAdi = req.form["turkceAdi"];
        f.yil = req.form["yil"];
        f.format = req.form["format"];
        f.dil = req.form["dil"];
        f.tur = req.form["tur"];
        f.poster = dosyaAdi;
        f.konu = req.form["konu"];

        DataServis ds = new DataServis();
        ds.duzenle(f);

        redirect("/film/form/" ~ to!string(f.id));
    }

    @path("/film/sil/:id")
    void getSil(string _id)
    {
        DataServis ds = new DataServis();
        Film film = ds.kayit(_id);
        if (ds.sil(_id) != 1)
            logInfo("Kayit silme işleminde hata var");

        // Klasordeki film poster dosyasini sil
        remove("./public/resim/" ~ film.poster);
        writeln("=========== DELETE A RECORD ================");
        redirect("/film/liste");
    }

    private string posterYukle(HTTPServerRequest req)
    {
        string resimKlasor = "./public/resim";
        if (!existsFile(resimKlasor)) createDirectory(resimKlasor);

        string posterAdi;
        foreach (resim; req.files)
        {
            string numara = std.conv.to!string(uniform(1000, 9999));
            string uzanti = extension(resim.filename.toString());
            string isim = toLower(req.form["orjinalAdi"].replace(" ", "-"));

            Path resimAdresi = Path(resimKlasor ~ "/"~ isim ~ "_" ~ numara ~ uzanti);
            moveFile(resim.tempPath, resimAdresi, true);

            posterAdi = isim ~ "_" ~ numara ~ uzanti;
        }

        return posterAdi;
    }
}
