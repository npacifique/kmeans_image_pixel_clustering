### Deployment instruction are from the following page 
[https://www.digitalocean.com/community/tutorials/how-to-build-and-deploy-a-flask-application-using-docker-on-ubuntu-20-04]
[https://medium.com/geekculture/how-to-dockerize-your-flask-application-2d0487ecefb8]

### Deployment commends 
1. Check if port 8111 is available `sudo nc localhost 8111 < /dev/null; echo $?` if response is 1 the port can be used
2. `sudo bash start.sh`
3. `sudo docker ps`
