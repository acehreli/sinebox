module servis.filmservis;

import std.file;
import std.conv;
import std.path: extension;
import std.random: uniform;
import std.string: toLower, strip;
import std.array: replace;

import vibe.http.server;
import vibe.web.web;
import vibe.core.file;
import vibe.core.log;
import vibe.data.bson;

import servis.dataservis;

final class FilmServis
{

    @path("/film/liste")
    void getListe()
    {
        DataServis ds = new DataServis();
        Film[] filmler = ds.liste!Film("filmler");

        render!("film.liste.dt", filmler);
    }

    @path("/film/form/:id")
    void getForm(string _id)
    {
        string action = "/film/ekle";
        Film film;

        if (_id != "0")
        {
            DataServis ds = new DataServis();
            film = ds.dokuman!Film(_id, "filmler");
            action = "/film/duzenle";
        }
        render!("film.form.dt", action, film);
    }

    @path("/film/ekle")
    void postEkle(HTTPServerRequest req)
    {
        string dosyaAdi = posterYukle(req);

        Film f;
		f._id = BsonObjectID.generate();
        f.orjinalAdi = req.form["orjinalAdi"];
        f.turkceAdi = req.form["turkceAdi"];
        f.yil = req.form["yil"];
        f.format = req.form["format"];
        f.dil = req.form["dil"];
        f.tur = req.form["tur"];
        f.poster = dosyaAdi;
        f.konu = req.form["konu"];

        DataServis ds = new DataServis();
        ds.ekle!Film(f, "filmler");

        redirect("/film/form/0");
    }

    @path("/film/duzenle")
    void postDuzenle(HTTPServerRequest req)
    {
        string dosyaAdi = posterYukle(req);
        if (dosyaAdi == "") dosyaAdi = req.form["mevcutPoster"];

        Bson f = Bson.emptyObject;
        f["orjinalAdi"] = req.form["orjinalAdi"];
        f["turkceAdi"] = req.form["turkceAdi"];
        f["yil"] = req.form["yil"];
        f["format"] = req.form["format"];
        f["dil"] = req.form["dil"];
        f["tur"] = req.form["tur"];
        f["poster"] = dosyaAdi;
        f["konu"] = req.form["konu"];

        DataServis ds = new DataServis();
        ds.duzenle("filmler", f, req.form["id"]);

        redirect("/film/form/" ~ req.form["id"]);
    }

    @path("/film/sil/:id")
    void getSil(string _id)
    {
        DataServis ds = new DataServis();
        Film film = ds.dokuman!Film(_id, "filmler");
        /*
        if (ds.sil(_id) != 1)
            logInfo("Kayit silme işleminde hata var");
        */
        // Klasordeki film poster dosyasini sil
        remove("./public/resim/" ~ film.poster);
        redirect("/film/liste");
    }

    @path("/film/arama")
    void getFilmArama(HTTPServerRequest req)
    {
        string aranan = strip(req.query["arama"]);

		DataServis ds = new DataServis();
		Film[] filmler = ds.listeArama!(Film)("filmler", aranan);

		render!("pano.dt", filmler);
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
