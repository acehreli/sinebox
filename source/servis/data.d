module servis.data;

import std.file;
import std.json;
import std.conv;

public import model.film;

final class DataServis
{
    public Film[] filmListesi()
    {
        string json = cast(string) read("/media/depo/Projeler/d/sinebox/source/data/filmler.json");

        JSONValue[] veriler = parseJSON(json).array;
        Film[] filmler;
        foreach (JSONValue veri; veriler)
        {
            Film f;
            f.id = veri["id"].integer;
            f.adi = veri["adi"].str;
            f.yil = veri["yil"].integer;
            f.rip = veri["rip"].str;
            f.dil = veri["dil"].str;

            filmler ~= f;
        }
        return filmler;
    }
}
