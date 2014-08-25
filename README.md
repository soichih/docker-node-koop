# Dockerfile for node-koop

This Dockerfile installs node-koop and various data providers (git, gist, socrata).

## Build

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

This will take about 10-20 minutes. If you are in a hurry, you are free to use pull my built instance from Dockerhub.

```
docker pull soichih/koop
```

## Start koop

1. Create default.yaml

You need to add default.yaml containing your github token, etc.. If you are using Docker postgres container, you should be 
able to leave the postgis configuration the same as below.

```
server:
  port: 8080

logfile: '/var/log/koop.log'
data_dir: '/usr/local/koop/'

github_token: 'xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx'

db:
  postgis:
    conn: "postgres://postgres@db/postgres"
```

2. Start up postgit container

```
docker run -d --name koop-postgis soichih/postgis
```

3. Finally, start your koop and link to your postgres instance (adjust your -p to whichever the port that you want to expose your koop on)

```
docker run -d --link koop-postgis:db -v `pwd`/default.yml:/koop/config/default.yml -p 49163:8080 --name mykoop koop
```

4. Happy Testing!

Browse to http://[your docker host]:49163/


