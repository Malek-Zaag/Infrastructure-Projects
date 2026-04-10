

# install jenkins 

docker run -d --name jenkins --restart unless-stopped \
-p 8080:8080 -p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
jenkins/jenkins:lts


## DooD 
docker run -d --name jenkins --restart unless-stopped \
-p 8080:8080 -p 50000:50000 \
-v jenkins_home:/var/jenkins_home \
-v /var/run/docker.sock:/var/run/docker.sock \
jenkins/jenkins:lts



docker exec -it jenkins bash