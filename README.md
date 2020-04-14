# GKE CI/CD with Jenkins Pipeline

The repository contains a simple Java application which outputs the string
"Hello world!" and is accompanied by a couple of unit tests to check that the
main application works as expected. The results of these tests are saved to a
JUnit XML report.

Assumptions:
1. Jenkins is deployed on Kubernetes cluster.
2. Kubernetes plugin is installed and cloud is configured properly.

Tutorials can be found at:
https://cloud.google.com/solutions/jenkins-on-kubernetes-engine-tutorial
https://www.youtube.com/watch?v=ObGR0EfVPlg

The `Jenkinsfile` (i.e. Pipeline) builds and deploys the Java application on GKE.

A second application is being deployed to demonstrate Horizantal Pod Autoscaling.
The intense folder contains all you need for the creation of the image.

In order to increase the load follow the below procedure.

First, find the application url.

Second, tart a container, and send an infinite loop of queries to the php-apache service:

	`kubectl run --generator=run-pod/v1 -it --rm load-generator --image=busybox /bin/sh`

Third, in the container command prompt run:
	
	`while true; do wget -q -O- http://<url>; done`

And forth, watch the application autoscale.