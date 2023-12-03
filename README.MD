### Deployment instruction are from the following page 
[https://www.digitalocean.com/community/tutorials/how-to-build-and-deploy-a-flask-application-using-docker-on-ubuntu-20-04]

### Deployment commends 
1. Check if port 56733 is available `sudo nc localhost 80111 < /dev/null; echo $?` if response is 1 the port can be used
2. `sudo bash start.sh`
3. `sudo docker ps`