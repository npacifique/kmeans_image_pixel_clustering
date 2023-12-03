# Use the official Ubuntu image as the base image
FROM ubuntu

# Update the package repository and install Python 3 and pip
RUN apt-get update 

RUN apt install python3 python3-pip -y && \
    ln -s /usr/bin/python3 /usr/bin/python

# RUN apt-get update && \
#     apt-get install -y python3.6 python3-pip && \
#     ln -s /usr/bin/python3.6 /usr/bin/python && \
#     ln -s /usr/bin/pip3 /usr/bin/pip

# Set the working directory
WORKDIR /var/www

# Copy the requirements file into the container at /var/www
COPY ./requirements.txt /var/www/requirements.txt

# Install Flask and other dependencies
RUN  pip install --upgrade pip &&\
    pip install -r requirements.txt

# Expose the port that Flask will run on
EXPOSE 8011

# Define the command to run the application
CMD ["/usr/bin/python", "app.py"]
