FROM python:3.9-slim-buster
WORKDIR /app

# Create a non-root user
RUN useradd -ms /bin/bash dockeruser

# Set the user as the active user
USER dockeruser

RUN python -m venv venv
RUN . venv/bin/activate

RUN pip install --upgrade pip

COPY ./requirements.txt /app
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
ENV FLASK_APP=my_flask.py
CMD ["flask", "run", "--host", "0.0.0.0"]