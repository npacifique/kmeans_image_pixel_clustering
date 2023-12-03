# Use the official Alpine Linux image as the base image
FROM python:3.10-alpine

# Set the working directory
WORKDIR /var/www

# Copy the requirements file into the container at /var/www
COPY ./requirements.txt /var/www/requirements.txt

# Install required packages
RUN apk update && \
    apk add --no-cache build-base python3-dev libffi-dev openssl-dev

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
