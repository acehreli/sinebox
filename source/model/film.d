module model.film;

import vibe.data.bson;

struct Film
{
	BsonObjectID _id;
    string orijinalAdi;
    string turkceAdi;
    string yil;
    string format;
    string dil;
    string tur;
    string poster;
    string konu;
}
