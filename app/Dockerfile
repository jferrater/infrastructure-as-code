FROM python:3-alpine

COPY requirements.txt .
RUN pip install -r requirements.txt

COPY app.py app.py

EXPOSE 8080
ENTRYPOINT [ "python3", "app.py" ]