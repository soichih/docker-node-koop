FROM ubuntu:14.04

RUN apt-get -y update
RUN apt-get -y install npm
RUN apt-get -y install git

#koop prerequisites
#RUN apt-get -y install postgresql-server-dev-all
RUN apt-get -y install postgresql-client
RUN ln -s /usr/bin/nodejs /usr/bin/node

#install supervisor
RUN npm install -g supervisor

#install koop
RUN git clone https://github.com/Esri/koop #4
WORKDIR koop
RUN npm install

#install providers
RUN npm install https://github.com/chelm/koop-github/tarball/master #4
RUN npm install https://github.com/chelm/koop-gist/tarball/master #4
RUN npm install https://github.com/chelm/koop-socrata/tarball/master #4

EXPOSE 8080
CMD supervisor server.js

