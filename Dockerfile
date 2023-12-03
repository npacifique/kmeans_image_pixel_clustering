# Use the official Alpine Linux image as the base image
FROM ubuntu:latest

# Update the package repository and install Python 3 and pip
RUN apt-get update && \
    apt-get python3.6 && \
    python3 -m ensurepip && \
    rm -r /usr/lib/python*/ensurepip && \
    apt-get py3-pip && \
    if [ ! -e /usr/bin/pip ]; then ln -s pip3 /usr/bin/pip ; fi && \
    if [[ ! -e /usr/bin/python ]]; then ln -sf /usr/bin/python3 /usr/bin/python; fi 

# Set the working directory
WORKDIR /var/www

# Copy the requirements file into the container at /var/www
COPY ./requirements.txt /var/www/requirements.txt

# Install Flask and other dependencies
RUN pip3 install --no-cache-dir Flask && \
    pip install --upgrade pip 

# Expose the port that Flask will run on
#EXPOSE 8011

# Define the command to run the application
CMD ["python3", "app.py"]