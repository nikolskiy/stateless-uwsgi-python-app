# Stateless python3 container with a simple flask app

## Purpose
The main goal is to run a container on Google cloud run service which is Google's knative implementation.
The environment allows only stateless containers which means you can't write anything to the filesystem at run time.
It turns out that nginx loves writing things to disk and it's very hard to convince it to be completely stateless.
Same thing happens to Supervisor. The solution is to use pure uwsgi since we have a load balancer in front of it anyway.
Luckily, uwsgi has an option to serve static files. In terms of docker-compose or other environments we'll assume that
there will be another container/service that will proxy traffic into our app.

## Resources
* [uWSGI docs](https://uwsgi-docs.readthedocs.io/en/latest/)
* The main inspiration for this little project is 
[nginx-uwsgi-flask-alpine-docker repo](https://github.com/hellt/nginx-uwsgi-flask-alpine-docker)
* Installing [gcloud sdk](https://cloud.google.com/sdk/)
* Google [cloud run tutorial](https://cloud.google.com/run/docs/quickstarts/build-and-deploy)
* Continuous [deployment](https://cloud.google.com/run/docs/continuous-deployment) from git

## Run using docker-compose
1) `pip install docker-compose` (working Docker is required)
2) `docker-compose up --build`
3) The app will be served locally at http://127.0.0.1:8080/

## Deploy to Google Cloud Run
`./deploy-to-gcloud.sh`
