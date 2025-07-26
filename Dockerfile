# Use the official Node.js image
FROM node:18

# Set the working directory
WORKDIR /usr/src/app

# Copy the server.js file into the container
COPY server.js .

# Set an environment variable
ENV HOSTNAME cw2-node-server

# Expose port 8080
EXPOSE 8080

# Start the app
CMD ["node", "server.js"]
