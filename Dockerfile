# Use the official Ubuntu image as the base image
FROM ubuntu


# Set environment variables to avoid debconf warnings
ENV DEBIAN_FRONTEND=noninteractive
ENV TERM=linux

# Update the package repository and install Python 3 and pip
RUN apt-get update && \
    apt-get install -y wget



RUN apt-get update && \
    apt-get install -y python3 python3-pip 


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
