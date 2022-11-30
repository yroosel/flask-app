#!/bin/bash
# staging exercise with jenkins

mkdir staging
mkdir staging/templates
mkdir staging/static

cp sample_app.py staging/.
cp -r templates/* staging/templates/.
cp -r static/* staging/static/.

echo "FROM python" > staging/Dockerfile
echo "RUN pip install flask" >> staging/Dockerfile
echo "COPY  ./static /home/myapp/static/" >> staging/Dockerfile
echo "COPY  ./templates /home/myapp/templates/" >> staging/Dockerfile
echo "COPY  sample_app.py /home/myapp/" >> staging/Dockerfile
echo "EXPOSE 5050" >> staging/Dockerfile
echo "CMD python /home/myapp/sample_app.py" >> staging/Dockerfile

cd staging
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name staging_running sampleapp
docker ps -a 
