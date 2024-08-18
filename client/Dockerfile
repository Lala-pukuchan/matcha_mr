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
