```
git clone https://github.com/vivekbhadra/docker_microservices_demo_python.git
cd ~/docker_microservices_demo_python
unzip microservices-demo.zip
vbhadra@vbhadra-DQ77MK:~/docker_microservices_demo_python$ tree
.
├── microservices-demo
│   ├── app.py
│   ├── docker-compose.yml
│   ├── Dockerfile
│   ├── mnt
│   │   └── user-data
│   │       └── outputs
│   │           └── microservices-demo
│   │               └── data-service
│   │                   ├── app.py
│   │                   └── Dockerfile
│   └── README.md
├── microservices-demo.zip
├── README.md
└── setup_microservices.sh

7 directories, 9 files

source setup_microservices.sh

vbhadra@vbhadra-DQ77MK:~/docker_microservices_demo_python$ source setup_microservices.sh 

✅ All files created. Structure:
.
├── api-service
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── app.py
├── data-service
│   ├── app.py
│   ├── Dockerfile
│   └── requirements.txt
├── docker-compose.yml
├── Dockerfile
├── mnt
│   └── user-data
│       └── outputs
│           └── microservices-demo
│               └── data-service
│                   ├── app.py
│                   └── Dockerfile
└── README.md

8 directories, 12 files

▶  To run:  docker compose up --build
▶  To test: curl http://localhost:5000/api/data

vbhadra@vbhadra-DQ77MK:~/docker_microservices_demo_python/microservices-demo$ docker compose up --build 
#1 [internal] load local bake definitions
#1 reading from stdin 1.22kB done
#1 DONE 0.0s

#2 [api-service internal] load build definition from Dockerfile
#2 transferring dockerfile: 260B done
#2 DONE 0.1s

#3 [data-service internal] load build definition from Dockerfile
#3 transferring dockerfile: 214B done
#3 DONE 0.1s

#4 [data-service internal] load metadata for docker.io/library/python:3.11-slim
#4 DONE 1.1s

#5 [api-service internal] load .dockerignore
#5 transferring context: 2B done
#5 DONE 0.1s

#6 [data-service internal] load .dockerignore
#6 transferring context: 2B done
#6 DONE 0.1s

#7 [data-service 1/5] FROM docker.io/library/python:3.11-slim@sha256:4057d02a202f69bfbfe10f65300519f612eb00fc595b8499f77d3cfe5b1b9fd4
#7 DONE 0.0s

#8 [api-service internal] load build context
#8 transferring context: 923B done
#8 DONE 0.1s

#9 [data-service internal] load build context
#9 transferring context: 816B done
#9 DONE 0.1s

#10 [api-service 3/5] COPY requirements.txt .
#10 CACHED

#11 [api-service 4/5] RUN pip install --no-cache-dir -r requirements.txt
#11 CACHED

#12 [api-service 5/5] COPY app.py .
#12 CACHED

#13 [data-service 2/5] WORKDIR /app
#13 CACHED

#14 [data-service 4/5] RUN pip install --no-cache-dir -r requirements.txt
#14 CACHED

#15 [data-service 3/5] COPY requirements.txt .
#15 CACHED

#16 [data-service 5/5] COPY app.py .
#16 CACHED

#17 [api-service] exporting to image
#17 exporting layers done
#17 writing image sha256:180dc22a2c33dac8a673da113789eb58be3685c8b8cd7e6ad22a510744e3d241 0.0s done
#17 naming to docker.io/library/microservices-demo-api-service 0.0s done
#17 DONE 0.1s

#18 [data-service] exporting to image
#18 exporting layers done
#18 writing image sha256:6336360ba898e741c070bbc0abf4f4bc1d73ed5fab03eaaf598e0eda49898a3d 0.0s done
#18 naming to docker.io/library/microservices-demo-data-service 0.0s done
#18 DONE 0.1s

#19 [api-service] resolving provenance for metadata file
#19 DONE 0.0s

#20 [data-service] resolving provenance for metadata file
#20 DONE 0.0s
[+] Running 4/4
 ✔ microservices-demo-data-service  Built                                                                                                                               0.0s 
 ✔ microservices-demo-api-service   Built                                                                                                                               0.0s 
 ✔ Container data-service           Recreated                                                                                                                           0.2s 
 ✔ Container api-service            Recreated                                                                                                                           0.2s 
Attaching to api-service, data-service
data-service  |  * Serving Flask app 'app'
data-service  |  * Debug mode: off
data-service  |  * Serving Flask app 'app'
data-service  |  * Debug mode: off
data-service  | 2026-03-04 08:45:07,353 [INFO] werkzeug: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
data-service  |  * Running on all addresses (0.0.0.0)
data-service  |  * Running on http://127.0.0.1:5001
data-service  |  * Running on http://172.19.0.2:5001
data-service  | 2026-03-04 08:45:07,354 [INFO] werkzeug: Press CTRL+C to quit
data-service  | 2026-03-04 08:45:07,353 [INFO] werkzeug: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
data-service  |  * Running on all addresses (0.0.0.0)
data-service  |  * Running on http://127.0.0.1:5001
data-service  |  * Running on http://172.19.0.2:5001
data-service  | 2026-03-04 08:45:07,354 [INFO] werkzeug: Press CTRL+C to quit
api-service   |  * Serving Flask app 'app'
api-service   |  * Debug mode: off
api-service   |  * Serving Flask app 'app'
api-service   |  * Debug mode: off
api-service   | 2026-03-04 08:45:07,658 [INFO] werkzeug: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
api-service   |  * Running on all addresses (0.0.0.0)
api-service   |  * Running on http://127.0.0.1:5000
api-service   |  * Running on http://172.19.0.3:5000
api-service   | 2026-03-04 08:45:07,658 [INFO] werkzeug: Press CTRL+C to quit
api-service   | 2026-03-04 08:45:07,658 [INFO] werkzeug: WARNING: This is a development server. Do not use it in a production deployment. Use a production WSGI server instead.
api-service   |  * Running on all addresses (0.0.0.0)
api-service   |  * Running on http://127.0.0.1:5000
api-service   |  * Running on http://172.19.0.3:5000
api-service   | 2026-03-04 08:45:07,658 [INFO] werkzeug: Press CTRL+C to quit


Request via Browser 
data-service  | 2026-03-04 08:45:58,073 [INFO] werkzeug: 172.19.0.3 - - [04/Mar/2026 08:45:58] "GET /health HTTP/1.1" 200 -
data-service  | 2026-03-04 08:45:58,073 [INFO] werkzeug: 172.19.0.3 - - [04/Mar/2026 08:45:58] "GET /health HTTP/1.1" 200 -
api-service   | 2026-03-04 08:45:58,075 [INFO] werkzeug: 172.19.0.1 - - [04/Mar/2026 08:45:58] "GET /health HTTP/1.1" 200 -
api-service   | 2026-03-04 08:45:58,075 [INFO] werkzeug: 172.19.0.1 - - [04/Mar/2026 08:45:58] "GET /health HTTP/1.1" 200 -
data-service  | 2026-03-04 08:45:59,198 [INFO] werkzeug: 172.19.0.3 - - [04/Mar/2026 08:45:59] "GET /health HTTP/1.1" 200 -
data-service  | 2026-03-04 08:45:59,198 [INFO] werkzeug: 172.19.0.3 - - [04/Mar/2026 08:45:59] "GET /health HTTP/1.1" 200 -
api-service   | 2026-03-04 08:45:59,199 [INFO] werkzeug: 172.19.0.1 - - [04/Mar/2026 08:45:59] "GET /health HTTP/1.1" 200 -
api-service   | 2026-03-04 08:45:59,199 [INFO] werkzeug: 172.19.0.1 - - [04/Mar/2026 08:45:59] "GET /health HTTP/1.1" 200 -
data-service  | 2026-03-04 08:46:01,239 [INFO] werkzeug: 172.19.0.3 - - [04/Mar/2026 08:46:01] "GET /health HTTP/1.1" 200 -
data-service  | 2026-03-04 08:46:01,239 [INFO] werkzeug: 172.19.0.3 - - [04/Mar/2026 08:46:01] "GET /health HTTP/1.1" 200 -
api-service   | 2026-03-04 08:46:01,240 [INFO] werkzeug: 172.19.0.1 - - [04/Mar/2026 08:46:01] "GET /health HTTP/1.1" 200 -
api-service   | 2026-03-04 08:46:01,240 [INFO] werkzeug: 172.19.0.1 - - [04/Mar/2026 08:46:01] "GET /health HTTP/1.1" 200 -
api-service   | 2026-03-04 08:46:05,516 [INFO] api-service: Request received: GET /api/data
api-service   | 2026-03-04 08:46:05,516 [INFO] api-service: Request received: GET /api/data

data-service  | 2026-03-04 08:46:05,519 [INFO] data-service: Data requested
data-service  | 2026-03-04 08:46:05,519 [INFO] data-service: Data requested/Mar/2026 08:46:05] "GET /data HTTP/1.1" 200 -
data-service  | 2026-03-04 08:46:05,520 [INFO] werkzeug: 172.19.0.3 - - [04/Mar/2026 08:46:05] "GET /data HTTP/1.1" 200 -


api-service   | 2026-03-04 08:46:05,521 [INFO] werkzeug: 172.19.0.1 - - [04/Mar/2026 08:46:05] "GET /api/data HTTP/1.1" 200 -
```
