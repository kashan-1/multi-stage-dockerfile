# Stage 1: Build Python application
FROM python:3.9-slim-buster as pybuilder
WORKDIR /app
COPY requirements.txt /app/requirements.txt
RUN pip install --target=/app/dependencies -r requirements.txt
#--no-cache-dir
COPY app.py /app/app.py
# Stage 2: Build Node.js frontend
FROM node:16-alpine as nodebuilder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY src/ /app/src/
COPY public/ /app/public/
RUN npm run build
# Stage 3: Final image
FROM python:3.9-slim-buster
WORKDIR /app
#COPY --from=pybuilder /app /app
COPY --from=pybuilder	/app .
ENV PYTHONPATH="${PYTHONPATH}:/app/dependencies"
#RUN pip install --no-cache-dir -r requirements.txt
COPY --from=nodebuilder /app/build /app/static
EXPOSE 5000
CMD [ "python", "-m" , "flask", "run", "--host=0.0.0.0"]