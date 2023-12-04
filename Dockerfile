FROM python:3.9-slim-buster

WORKDIR /app

# Copy just the requirements file first to leverage Docker cache
COPY ./requirements.txt /app/

# Upgrade pip and install required packages
RUN pip install --upgrade pip \
    && pip install --root-user-action=ignore -r requirements.txt

# Copy the rest of the application code
COPY . /app/

EXPOSE 5000

ENV FLASK_APP=my_flask.py

CMD ["flask", "run", "--host", "0.0.0.0"]
