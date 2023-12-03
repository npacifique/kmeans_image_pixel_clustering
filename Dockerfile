# Use the official Ubuntu image as the base image
FROM ubuntu

# Update the package repository and install Python 3 and pip
RUN apt-get update && \
    apt-get install -y python3 python3-pip 

RUN apt-get install -y apt-utils

# Install python3-venv package
RUN apt-get install -y python3.10-venv

# Set the working directory
WORKDIR /var/www

# Copy the requirements file into the container at /var/www
COPY ./requirements.txt /var/www/requirements.txt

# Create and activate a virtual environment
RUN python3 -m venv venv
RUN . venv/bin/activate

# Upgrade pip and install dependencies
RUN pip install --upgrade pip && \
    pip install -r requirements.txt

# Expose the port that Flask will run on
EXPOSE 8011

# Define the command to run the application
CMD ["venv/bin/python", "app.py"]
