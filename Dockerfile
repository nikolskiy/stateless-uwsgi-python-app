FROM python:3.7-alpine

# Force rebuild
RUN ls

# C compiler and linux headers are required to build uwsgi
RUN apk add --no-cache \
    build-base \
    linux-headers && \
    pip3 install --upgrade pip && \
    pip3 install uwsgi

# Copy python requirements file
COPY requirements.txt /tmp/requirements.txt
RUN pip3 install -r /tmp/requirements.txt

# Remove pip cache. We are not going to need it anymore
RUN rm -r /root/.cache

# Add config files
COPY configs/uwsgi.ini /etc/
COPY configs/mime.types /etc/

# Add our application files
RUN mkdir app
COPY ./app /app
WORKDIR /app

ENV PYTHONDONTWRITEBYTECODE 1
ENV PYTHONUNBUFFERED 1

EXPOSE 8080

CMD ["/usr/local/bin/uwsgi", "--ini", "/etc/uwsgi.ini"]
