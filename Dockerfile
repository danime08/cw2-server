<<<<<<< HEAD
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
=======
# Use official Node.js runtime as a parent image
FROM node:18-alpine

# Set working directory inside container
WORKDIR /app

# Copy package.json and package-lock.json (if present)
COPY package*.json ./

# Install dependencies
RUN npm install

# Copy rest of the app source code
COPY . .

# Expose the port the app runs on (change if needed)
EXPOSE 3000

# Command to run the app (change to your main app file)
>>>>>>> 3720f80 (Pushed all project files)
CMD ["node", "server.js"]
