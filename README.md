# simple-java-maven-app

The repository contains a simple Java application which outputs the string
"Hello world!" and is accompanied by a couple of unit tests to check that the
main application works as expected. The results of these tests are saved to a
JUnit XML report.

The `Jenkinsfile` (i.e. Pipeline) builds and deploys the Java application on GKE.

A second application is being deployed to demonstrate Horizantal Pod Autoscaling.
In order to increase the load follow the below procedure.

First, find the application url.

Second, tart a container, and send an infinite loop of queries to the php-apache service:

	`kubectl run --generator=run-pod/v1 -it --rm load-generator --image=busybox /bin/sh`

Third, in the container command prompt run:
	
	`while true; do wget -q -O- http://<url>; done`

And forth, watch the application autoscale.