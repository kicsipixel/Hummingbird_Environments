# Leveraging Docker Compose profiles

Source file for the [article]()

### You need to create `.env` and `.env_test` files:

`.env`:

```
# Application
DATABASE_HOST=db
DATABASE_NAME=prague-parks
DATABASE_USERNAME=hb_usernam3
DATABASE_PASSWORD=secret
# PostgreSQL database
PGDATA=/var/lib/postgresql/data/pgdata
POSTGRES_USER=hb_usernam3
POSTGRES_PASSWORD=secret
POSTGRES_PORT=5432
POSTGRES_DB=prague-parks
POSTGRES_HOST=localhost
```

`.env_test`:

```
# Application
# Environment variables are set in Xcode.
# PostgreSQL database
PGDATA=/var/lib/postgresql/data/pgdata
POSTGRES_HOST=localhost
POSTGRES_PORT=5433
POSTGRES_USER=hb_usernam3
POSTGRES_PASSWORD=secret
POSTGRES_DB=prague-parks-tes
```

### To start different environments:

#### PROD

```
$ docker compose up --profile prod up
```

#### DEV

```
$ docker compose up --profile dev up
```

#### TEST

```
$ docker compose up --env-file .env_test --profile test up
```
