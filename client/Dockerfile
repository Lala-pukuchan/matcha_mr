# base image
FROM node:18-alpine

# set working directory
WORKDIR /app

# copy files
COPY package*.json ./

# install npm
RUN npm install

# expose port
EXPOSE 3000

# start app
CMD ["npm", "run", "dev"]

##productionモードで起動するときに使用
## base image
#FROM node:18-alpine
#
## set working directory
#WORKDIR /app
#
## copy files
#COPY package*.json ./
#
## install npm
#RUN npm install
#
## copy all files
#COPY . .
#
## build the application
#RUN npm run build
#
## expose port
#EXPOSE 3000
#
## start app
#CMD ["npm", "run", "start"]