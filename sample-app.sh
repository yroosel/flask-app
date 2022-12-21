#!/bin/bash
# staging exercise with jenkins
echo "===== Creating folders for the staging of the deployment"
mkdir staging
mkdir staging/templates
mkdir staging/static
echo "===== Copying files to staging environment"
cp sample_app.py staging/.
cp -r templates/* staging/templates/.
cp -r static/* staging/static/.
echo "===== Creating Dockerfile on the fly"
echo "FROM python" > staging/Dockerfile
echo "RUN pip install flask" >> staging/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> staging/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> staging/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> staging/Dockerfile
echo "EXPOSE 5050" >> staging/Dockerfile
echo "CMD python /home/myapp/sample_app.py" >> staging/Dockerfile
echo "==== Building docker image in the staging environment"
cd staging
docker build -t sampleapp .
echo "===== Running docker application in the staging environment"
docker run -t -d -p 5050:5050 --name staging_running sampleapp
echo "===== Checking if the container is running (to be improved with grep)"
docker ps -a 
