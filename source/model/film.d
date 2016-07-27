module model.film;

struct Film
{
    int id;
    string orjinalAdi;
    string turkceAdi;
    string yil;
    string format;
    string dil;
    string tur;
    string poster;
    string konu;
}



/*
    CREATE TABLE filmler (
        id          INTEGER      PRIMARY KEY AUTOINCREMENT,
        orjinal_adi STRING (250) NOT NULL,
        turkce_adi  STRING (250) NOT NULL,
        yil         STRING (10)  NOT NULL,
        format      STRING (250) NOT NULL,
        dil         STRING (250) NOT NULL,
        tur         STRING (250) NOT NULL
    );
*/
