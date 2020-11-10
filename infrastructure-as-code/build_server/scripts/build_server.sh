#!/bin/bash

sudo chmod 666 /var/run/docker.sock
sudo docker run -d -p 80:8080 -p 50000:50000 -v /var/run/docker.sock:/var/run/docker.sock cmelgreen/jenkins_config_as_code