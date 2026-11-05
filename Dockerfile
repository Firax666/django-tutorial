FROM python:3.6.15-slim-buster

WORKDIR /app

COPY requirements.txt .
RUN python -m pip install --no-cache-dir --upgrade "pip==21.3.1" && \
python -m pip install --no-cache-dir -r requirements.txt

COPY . .

RUN useradd --create-home --uid 10001 django && chown -R django:django /app
USER django

EXPOSE 8000
CMD ["sh", "-c", "python manage.py migrate --noinput && exec gunicorn mysite.wsgi:application --bind 0.0.0.0:8000 --workers 2 --access-logfile -"]
