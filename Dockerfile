# Use the official Ubuntu image as the base image
FROM ubuntu:latest

# Update the package repository and install Python 3 and pip

RUN apt install python3 python3-pip -y

# Set the working directory
WORKDIR /var/www

# Copy the requirements file into the container at /var/www
COPY ./requirements.txt /var/www/requirements.txt

# Install Flask and other dependencies
RUN pip install --no-cache-dir -r requirements.txt && \
    pip install --upgrade pip

# Expose the port that Flask will run on
# EXPOSE 8011

# Define the command to run the application
CMD ["python", "app.py"]
