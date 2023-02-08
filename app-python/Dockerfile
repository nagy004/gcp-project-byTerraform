FROM python:3.9

RUN mkdir /app

ADD . /app

WORKDIR /app

RUN pip install -r requirements.txt
    
CMD ["python", "hello.py"]
