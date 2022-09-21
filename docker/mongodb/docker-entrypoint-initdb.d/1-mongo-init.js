db.createUser({user: "pub", pwd: "pub", roles:[{ role: "userAdmin", db: "pubtator"}, { role: "readWrite", db: "pubtator"}]})
db.createCollection('bc2pubtator');