module servis.dataservis;

import vibe.db.mongo.mongo;
import vibe.data.bson;
import vibe.core.log;

public import model.film;

final class DataServis
{
	private MongoDatabase db;

	public this()
	{
        db = connectMongoDB("127.0.0.1").getDatabase("sinebox");
	}

    public void ekle(T)(T model, string koleksiyon)
    {
        model._id = BsonObjectID.generate();

        MongoCollection coll = db[koleksiyon];
        coll.insert(model);
    }

    public void duzenle(string koleksiyon, Bson veri, string id)
    {
        MongoCollection coll = db[koleksiyon];
        coll.update(["_id": BsonObjectID.fromString(id)], ["$set": veri]);
    }

    public T[] liste(T)(string koleksiyon, Bson sirala = Bson.emptyObject)
    {
        MongoCollection model = db[koleksiyon];
        auto bsonModel = model.find().sort(sirala);

        T[] modelListe;
        foreach (bson; bsonModel)
        {
            T m = deserializeBson!(T)(bson);
            modelListe ~= m;
        }

        return modelListe;
    }

	public T[] listeLimit(T)(string koleksiyon, int limit)
	{
		MongoCollection model = db[koleksiyon];
		auto bsonModel = model.find().sort(["$natural" : Bson(-1)]).limit(limit);

		T[] modelListe;
		foreach (bson; bsonModel)
		{
			T m = deserializeBson!(T)(bson);
			modelListe ~= m;
		}

		return modelListe;
	}

	public T[] listeArama(T)(string koleksiyon, string aranan)
	{
		MongoCollection model = db[koleksiyon];
		auto bsonModel = model.find(["$or": [ 
                ["turkceAdi": BsonRegex(aranan, "i")], 
                ["tur": BsonRegex(aranan,"i")] 
        ] ]);

		T[] modelListe;
		foreach (bson; bsonModel)
		{
			T m = deserializeBson!(T)(bson);
			modelListe ~= m;
		}

		return modelListe;
	}

    public T dokuman(T)(string id, string koleksiyon)
    {
        MongoCollection coll = db[koleksiyon];
        Bson bson = coll.findOne(["_id" : BsonObjectID.fromString(id)]);
        return deserializeBson!T(bson);
    }
}
