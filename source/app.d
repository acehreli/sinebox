import vibe.http.fileserver;
import vibe.http.router;
import vibe.web.web;
import vibe.core.log;

import servis.home;

shared static this()
{
	setLogLevel(LogLevel.info);

    URLRouter routers = new URLRouter;
	routers.registerWebInterface(new Home());
    routers.get("*", serveStaticFiles("./public/"));

    auto settings = new HTTPServerSettings;
    settings.port = 8080;
    settings.sessionStore = new MemorySessionStore();
    settings.bindAddresses = ["::1", "127.0.0.1"];

	listenHTTP(settings, routers);

	logInfo("Please open http://127.0.0.1:8080/ in your browser.");
}
