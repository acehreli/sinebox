module servis.homeservis;

import vibe.web.web;
import servis.dataservis;

final class HomeServis
{
    @path("/")
    void getPano()
    {
        DataServis ds = new DataServis();
        Film[] filmler = ds.liste();

        render!("pano.dt", filmler);
    }

    @path("/video")
    void getVideo()
    {
        render!("video.dt");
    }
}
