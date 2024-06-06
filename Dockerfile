FROM node:14-alpine

# created a non-root user for security purposes
RUN addgroup -g 1001 appuser && \
    adduser -u 1001 -G appuser -s /bin/sh -D appuser

# changing to the app directory
WORKDIR /usr/src/app

COPY package*.json ./

# installing dependendcies as non-root user
RUN npm install --only=production && \
    npm cache clean --force

# changed ownership to the user and switched to the user
RUN chown -R appuser:appuser .

USER appuser

# copiyng the application code into the image
COPY . .

# exposing the port of the application to be accessible via https
EXPOSE 3000

# used health check to verify that the app is working correctly.
HEALTHCHECK --interval=30s --timeout=5s --start-period=5s --retries=3 \
  CMD curl --fail http://localhost:3000/ || exit 1

CMD ["npm", "start"]


















