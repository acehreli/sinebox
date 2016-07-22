module servis.filmservis;

import std.file;
import std.conv;
import std.path: extension;
import std.random: uniform;

import vibe.http.server;
import vibe.web.web;
import vibe.core.file;
import vibe.core.log;

import servis.dataservis;

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
        string[] posterler = posterYukle(req);

        Film f;
        f.orjinalAdi = req.form["orjinalAdi"];
        f.turkceAdi = req.form["turkceAdi"];
        f.yil = req.form["yil"];
        f.format = req.form["format"];
        f.dil = req.form["dil"];
        f.tur = req.form["tur"];
        f.poster1 = posterler.length == 1 ? posterler[0] : "bos.png";
        f.poster2 = posterler.length == 2 ? posterler[1] : "bos.png";

        DataServis ds = new DataServis();
        ds.ekle(f);

        redirect("/film/form/0");
    }

    @path("/film/duzenle")
    void postDuzenle(HTTPServerRequest req)
    {
        string[] posterler = posterYukle(req);

        Film f;
        f.id = to!int(req.form["id"]);
        f.orjinalAdi = req.form["orjinalAdi"];
        f.turkceAdi = req.form["turkceAdi"];
        f.yil = req.form["yil"];
        f.format = req.form["format"];
        f.dil = req.form["dil"];
        f.tur = req.form["tur"];
        f.poster1 = posterler.length == 1 ? posterler[0] : "bos.png";
        f.poster2 = posterler.length == 2 ? posterler[1] : "bos.png";

        DataServis ds = new DataServis();
        ds.duzenle(f);

        redirect("/film/form/" ~ to!string(f.id));
    }

    @path("/film/sil/:id")
    void getSil(string _id)
    {
        DataServis ds = new DataServis();
        if (ds.sil(_id) != 1)
            logInfo("Kayit silme işleminde hata var");

        redirect("/film/liste");
    }

    private string[] posterYukle(HTTPServerRequest req)
    {
        string resimKlasor = "./public/resim";
        if (!existsFile(resimKlasor)) createDirectory(resimKlasor);

        string[] resimler;
        foreach (resim; req.files)
        {
            string numara = std.conv.to!string(uniform(1000, 9999));
            string uzanti = extension(resim.filename.toString());
            Path resimAdresi = Path(resimKlasor~ "/poster_" ~ numara ~ uzanti);
            moveFile(resim.tempPath, resimAdresi, true);
            resimler ~= "poster_" ~ numara ~ uzanti;
        }

        return resimler;
    }
}
