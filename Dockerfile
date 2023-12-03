# FROM tiangolo/uwsgi-nginx-flask:python3.8-alpine
# Use the official Alpine Linux image as the base image
FROM alpine:latest

# Update the package repository and install Python 3 and pip
RUN apk update && \
    apk add --no-cache python3 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    apk add --no-cache py3-pip && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi 


ENV STATIC_URL /static
ENV STATIC_PATH /var/www/app/static
COPY ./requirements.txt /var/www/requirements.txt

# Install Flask
RUN pip3 install --no-cache-dir Flask
RUN pip install --upgrade pip
#RUN pip install -r /var/www/requirements.txt

# Expose the port that Flask will run on
EXPOSE 8011

# Define the command to run the application
CMD ["python3", "app.py"]