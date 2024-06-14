# Use an official Node.js runtime as a parent image for the build stage
FROM node:20-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the package.json and yarn.lock files to the working directory
COPY package.json yarn.lock ./

# Install dependencies
RUN yarn install

# Copy the rest of the application code to the working directory
COPY . .


# Create a new stage to build the final image
FROM node:20-alpine AS runtime

# Set the working directory inside the container
WORKDIR /app

# Copy the built application from the builder stage
COPY --from=builder /app .

# Set the user to 'node' for security
USER node

# Expose port 3000 for the application
EXPOSE 3000

# Command to run the application
CMD ["node", "./bin/www"]
