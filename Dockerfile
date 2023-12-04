FROM python:3.9-slim-buster
# WORKDIR /app
WORKDIR /home/dockeruser
# Create a non-root user
RUN useradd -ms /bin/bash dockeruser
USER dockeruser

#RUN chown -R dockeruser /app
#RUN mkdir /app/venv && chown dockeruser /app/venv

# RUN mkdir venv && chown dockeruser venv



RUN python -m venv venv
RUN . venv/bin/activate

RUN pip install --upgrade pip

COPY ./requirements.txt /home/dockeruser
RUN pip install -r requirements.txt
COPY . .
EXPOSE 5000
ENV FLASK_APP=my_flask.py
CMD ["flask", "run", "--host", "0.0.0.0"]