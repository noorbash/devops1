# Use official Node.js LTS as base image
FROM node:20-alpine

# Set working directory
WORKDIR /app

# Install essential dependencies for build
RUN apk add --no-cache \
    bash \
    git \
    curl \
    python3 \
    make \
    g++ \
    && npm install -g npm@latest

# Set environment variables
ENV NODE_ENV=development

# Copy package.json and package-lock.json (if available)
COPY package*.json ./

# Install dependencies
RUN npm install

# Install TypeScript and Node types
RUN npm install --save-dev @types/node@latest typescript@latest

# Copy the rest of the application
COPY . .

# Build the application
RUN npm run build

# Expose application port
EXPOSE 3000

# Start the application
CMD ["npm", "start"]
