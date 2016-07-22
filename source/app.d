import vibe.http.fileserver;
import vibe.http.router;
import vibe.web.web;
import vibe.core.log;

import servis.homeservis;
import servis.filmservis;

shared static this()
{
    setLogLevel(LogLevel.info);

    URLRouter routers = new URLRouter;
    routers.registerWebInterface(new HomeServis());
    routers.registerWebInterface(new FilmServis());
    routers.get("*", serveStaticFiles("./public/"));
    routers.get("*", serveStaticFiles("/home/zafer/Downloads/"));

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.sessionStore = new MemorySessionStore();
    settings.bindAddresses = ["::1", "127.0.0.1", "192.168.1.55"];

    listenHTTP(settings, routers);

    logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}
