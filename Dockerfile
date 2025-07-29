# Use the official Node.js image
FROM node:18

# Set the working directory
WORKDIR /usr/src/app

# Copy dependency files and install
COPY package*.json ./
RUN npm install

# Copy the rest of the application
COPY . .

# Optional environment variable
ENV HOSTNAME cw2-node-server

# Expose the port your app runs on
EXPOSE 8080

# Start the app
CMD ["node", "server.js"]
