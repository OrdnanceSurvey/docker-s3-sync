FROM ubuntu:14.04
MAINTAINER Soumen Trivedi "soumen.trivedi@arkayaventure.co.uk"

RUN mkdir -p /data && apt-get clean && apt-get update -y && apt-get install python2.7 curl -y && curl -O https://bootstrap.pypa.io/get-pip.py && python2.7 get-pip.py && pip install awscli s3cmd && apt-get clean
ENV AWS_S3_ACCESS_KEY="mandatory"
ENV AWS_S3_SECRET_KEY="mandatory"
ENV AWS_S3_BUCKET_NAME="mandatory"
ENV RETENTION_PERIOD_IN_DAYS=60
ADD scripts/s3sync.sh /
ENTRYPOINT /bin/sh
CMD /s3sync.sh