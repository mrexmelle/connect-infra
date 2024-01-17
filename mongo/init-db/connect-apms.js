db = db.getSiblingDB('apms')

db.createCollection('templates')
db.createCollection('proposals')
db.createCollection('events')

db.createUser({
    user: 'apms',
    pwd: '123',
    roles: [
        {
            role: 'readWrite',
            db: 'apms',
        },
    ],
})
