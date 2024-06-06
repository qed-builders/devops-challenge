HEllo :)

This test indeed have been a challenge for me.

First, to build and run the application locally I have created the Dockerfile where:
- I chose to create a non-root user for security purposes, to reduse any risks of vulnerabilities
- Set the working directory inside the container to "/usr/src/app", where the code would be copied and commands ran.
- Copied the packages, installed npm dependencies and changed ownership of all the files to the "appuser" and set it to default
- Exposed port 3000 on the container - meant to have the container listeninng to port 3000
- Added a "Healthcheck" passs to see that the application responds to http://localhost:3000, and if it fails to expose error status code 1.

As a secondary step, for Continuous Integration, i have set the CI to:
- Run on any push or PR on current branches: main and feat2-cd
- My choice was to run via ubuntu
- Set up the "actions/checkout@v3" to retrieve repository's codebase, also set the node.js environment to version 20 and installed npm dependencies and the Mocha testing framework (also couldve work with Jasmine fw)
- My choice was also to run the tests of the "app.js" from my root folder - just for testing purposes and came along with the CI task where I have set the docker Buildx to build the docker image, run a container with port 3000 exposed and tested it by making a curl request via "http://localhost:3000" - so it will have the test done on each push/PR done on the repo.

For the third step I went with:

I.  Created the terraform configuration to initially have:
- Instance (EC2) resource that will be created using a public AMI of Ubuntu 22.04, I have also set the volume size of 20GB, VPC with CIDR Block 10.0.0.0/16 and the subnet with CIDR block 10.0.1.0/24 in the eu-central-1a region, security group to set the traffic on port 80 (for http / web traffic) and port 22 to have SSH access and my initial choise was to create the key-pair via terraform and expose it outside the module via output, so it can be called into by the CiCD configuration.

Sadly, after many tries, couldnt expose it to propperly set the output and use it on ssh even tho it had created the key and stored it on my /ec2-terraform folder as I wanted. So, you will find this option as commented on my TF files.

I have also tried to create a key via aws console, stored it into the github secrets and called it after, but then i found out that having the option "allocation_public_ip = true" won't work without setting up a public IP via elastic, so I came back to my terraform files and set the route to have internet access, set the elastic ip association and the exposure of the IP in the output step to be used via ssh.

For the fourth step I have set the dockerhub token and username as well on Github Secrets and called them via my CI configuration and pushed the docker image to dockerhub registry.

After that, as I have previously mentioned, I tried on many tries to make the the connection via ssh to my ec2 machine but for some reason (not yet discovered as I ran out of time) couldnt make it work, as github didnt communicated with EC2 machine. But even tho I am sending you this test in this state, with no communication between github and ec2 to start the docker image deployment on the machine, ill try on my own to make it work. 

I am satisfied to had the opportunity to have this test done, it was a real challenge that I love worked on and spend my free hours on :D


