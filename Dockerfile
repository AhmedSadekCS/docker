# start with a ready-made Linux image that includes Node.js version 22.
FROM node:22-alpine

# inside the container, set the main working folder to /app
# Any subsequent command will execute from within `/app`.
# In other words, instead of having to type `cd /app` every time, Docker does it for you.
WORKDIR /app


# This means copying any file that starts with "package" and ends with ".json" from your local machine to the `/app` directory inside the image.
# This is important because the `package.json` file contains the list of dependencies your application needs to run, and `npm install` will use this file to install those dependencies.
COPY package*.json ./


# This means that while building the image, run this command: `npm install` to install all the dependencies listed in the `package.json` file. This ensures that when the container is run, it has all the necessary packages to execute the application.
RUN npm install


# This means copying all the files from your local machine (the current directory) to the `/app` directory inside the image. This includes your application code, configuration files, and any other necessary files for your application to run.
# The first dot (`.`) signifies: the current location on your local machine. The second dot (`.`) signifies: the current location inside the image (which is `/app` due to the `WORKDIR` command). So, effectively, this command copies everything from your local directory into the `/app` directory in the image.
COPY . .

# This means that when the container is run, it will listen for incoming network traffic on port 4200. This is important because your application (likely an Angular app) will be running on this port, and exposing it allows you to access the application from outside the container.
# Essentially, the container is saying: "I will listen for requests on port 4200"
# In Angular, this is typically the port used by: the development server (ng serve) to serve the application. By exposing this port, you can access the Angular application from your host machine or other containers that are linked to this one.
# To actually open it, you must use the `-p` flag at runtime: `docker run -p 4200:4200 <image-name>` which maps port 4200 of the container to port 4200 on your host machine, allowing you to access the application via `http://localhost:4200`.
# 4200: container port
EXPOSE 4200

# This is the command that will be executed when the container starts up.
# In other words, when you run: `docker run <image-name>`, this command will be executed inside the container.
CMD ["npm", "start"]
