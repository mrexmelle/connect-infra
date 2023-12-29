db = db.getSiblingDB('apms')

db.createCollection('templates')
db.createCollection('proposals')
db.createCollection('events')

db.createUser({
    user: 'apms_r',
    pwd: '123',
    roles: [
        {
            role: 'read',
            db: 'apms',
        },
    ],
})

db.createUser({
    user: 'apms_w',
    pwd: '123',
    roles: [
        {
            role: 'readWrite',
            db: 'apms',
        },
    ],
})
