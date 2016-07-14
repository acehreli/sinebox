module servis.home;

import vibe.http.server;
import vibe.web.web;

import servis.data;

final class Home
{
    @path("/")
    void getIndex()
    {
        DataServis ds = new DataServis();
        Film[] filmler = ds.filmListesi();

        render!("index.dt", filmler);
    }
}
