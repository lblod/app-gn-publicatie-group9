# app-gn-publicatie
Publication platform of [gelinkt-notuleren](https://github.com/lblod/app-gelinkt-notuleren).

## Running and maintaining
Make sure you have docker and docker-compose set up,then execute the following:

```
# Clone this repository
git clone https://github.com/lblod/app-gn-publicatie.git

# Move into the directory
cd app-gn-publicatie

# Start the system
docker-compose -f docker-compose.yml -f docker-compose.dev.yml up -d
```

Wait for everything to boot:
```
docker-compose logs -f virtuoso migrations
```

The database is ready when you see the following in the logs
```
virtuoso_1            | 11:49:56 HTTP/WebDAV server online at 8890
virtuoso_1            | 11:49:56 Server online at 1111 (pid 1)
```

Migrations should list
```
migrations_1          | I, [2020-09-14T11:49:47.047982 #12]  INFO -- : All migrations executed
```

Once the stack has booted successfully you can visit the publication website on http://localhost:8080


### integration with the loket api
This stack can integratie with loket to provide a notification when a decision has been published. 
See the [publicatie-melding](https://github.com/lblod/besluit-publicatie-melding-service) repository for more info.
*NOTE*: In the dev setup this service is disabled by default

### integration with GN
TODO: describe delta integration with GN.
