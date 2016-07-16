# 司改會數位典藏系統

這是[民間司法改革基金會](http://www.jrf.org.tw)的[數位典藏檢索系統](http://digital.jrf.org.tw)。

This is the [Digital Archive Querying System](http://digital.jrf.org.tw) of [Judicial Reform Foundation](http://www.jrf.org.tw), Taiwan.

[![Build Status](https://travis-ci.org/JRF-tw/jrf_digital_website.svg?branch=master)](https://travis-ci.org/JRF-tw/jrf_digital_website)

## Project Build

- Make sure you have already start PostgreSql

```
bundle install
```

```
cp config/database.yml.default config/database.yml
cp config/config.yml.default config/config.yml
```

- Setup database.yml & start postgresql.

```
bundle install
rake db:create db:migrate
rails server
```

- Yo login as admin, setup Google or Facebook OAuth login at `config/config.yml`, and set the user as admin in rails console.

## PostgreSql

- install

```
brew install postgresql
brew unlink postgresql
brew link postgresql
ARCHFLAGS="-arch x86_64" gem install pg
```

- goto http://postgresapp.com/ download and start it.

- setup user & password

```
psql
```

- replace your_name & your_password

```
CREATE USER your_name WITH PASSWORD 'your_password';
CREATE DATABASE "your_name";
GRANT ALL PRIVILEGES ON DATABASE "your_name" to "your_name";
ALTER USER "your_name" WITH SUPERUSER;
```

## LICENSE
This project is release under MIT License.
