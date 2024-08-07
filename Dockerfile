# Use an official node image as the base
FROM node:20.9.0

# Set the working directory
WORKDIR /app

# Copy the package.json and package-lock.json
COPY package*.json ./

# Install dependencies
RUN npm install
RUN npm install --save-dev vue-svg-loader
RUN npm install buffer

# Copy the rest of the application code
COPY . .

# Expose the port the app runs on
EXPOSE 8080

# Command to run the app with --host flag
# CMD ["npm", "run", "dev", "--", "--host"]
CMD ["npm", "run", "dev"]