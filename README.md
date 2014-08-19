** Dockerfile for node-koop

This Dockerfile installs node-koop and various data providers (git, gist, socrata).

You can use this Dockerfile to build node-koop instance by doing following.

1. Clone this repository.

```
git clone https://github.com/soichih/docker-node-koop.git
```
3. (Optionally) Make any necessary changes to Dockerfile

4. Build your container

```
docker build -t koop .
```

* Starting up your service

1. Create default.yaml

You need to add default.yaml containing your github token, etc.. If you are using Docker postgres instance, you should be 
able to leave the postgis configuration the same as below.

```
server:
  port: 8080

logfile: '/var/log/koop.log'
data_dir: '/usr/local/koop/'

github_token: 'ad0c275487931dabef79076bbfc7a112e4bb3abd'

db:
  postgis:
    conn: "postgres://postgres@db/postgres"
```

2. Start up postgres container

```
docker run --name koop-postgres -d postgres
```

3. Finally, start your koop and link to your postgres instance (adjust your -p to whichever the port that you want to expose your koop on)

```
docker run -d --link koop-postgres:db -v `pwd`/default.yml:/koop/config/default.yml -p 49163:8080 --name mykoop koop
```

4. Happy Testing!

Browse to http://<your docker host>:49163/


