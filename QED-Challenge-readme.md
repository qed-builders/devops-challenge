HEllo :)

This test indeed have been a challenge for me.

First, to build and run the application locally I have created the Dockerfile where:
- I chose to create a non-root user for security purposes, to reduse any risks of vulnerabilities
- Set the working directory inside the container to "/usr/src/app", where the code would be copied and commands ran.
- Copied the packages, installed npm dependencies and changed ownership of all the files to the "appuser" and set it to default
- Exposed port 3000 on the container - meant to have the container listeninng to port 3000
- Added a "Healthcheck" passs to see that the application responds to http://localhost:3000

