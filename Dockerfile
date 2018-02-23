FROM node:carbon

# Create app directory
WORKDIR /usr/src/app

# Install app dependencies
# A wildcard is used to ensure both package.json AND package-lock.json are copied
# where available (npm@5+)
COPY package*.json ./

RUN npm install
# If you are building your code for production
# RUN npm install --only=production

# Bundle app source
COPY . .

# docker run -p 8081:8080 sf.rcp.aws-docker
# will bind port 8080 of the container to port 8081 of the host machine.
EXPOSE 8080
CMD [ "npm", "start" ]

