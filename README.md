
# Dangerous-Heartbeat-Classification-MLOps

Deployment of FastAPI API using Docker and Kubernetes for classifying heartbeat signals.

## Table of Contents

- [Overview](#overview)
- [Features](#features)
- [Installation](#installation)
- [Usage](#usage)
- [Kubernetes Details](#kubernetes-details)
  - [Service](#service)
  - [Deployment](#deployment)
  - [ReplicaSet](#replicaset)
  - [Rolling Update](#rolling-update)
- [Contributing](#contributing)
- [License](#license)

## Overview

This project provides a deployment pipeline for a machine learning model that classifies heartbeat signals. The deployment is managed using FastAPI, Docker, and Kubernetes to ensure scalability and ease of use.

## Features

- **FastAPI**: A modern, fast (high-performance), web framework for building APIs with Python 3.6+ based on standard Python type hints.
- **Docker**: Containerization of the application for consistent and isolated environments.
- **Kubernetes**: Orchestration of Docker containers to manage deployment, scaling, and operations of application containers across clusters of hosts.
- **Jupyter Notebooks**: Used for data analysis and model training.

## Installation

### Prerequisites

- [Docker](https://www.docker.com/get-started)
- [Kubernetes](https://kubernetes.io/docs/setup/)
- [Python 3.6+](https://www.python.org/downloads/)
- [FastAPI](https://fastapi.tiangolo.com/)

### Steps

1. **Clone the repository:**

    ```bash
    git clone https://github.com/Ammar-Abdelhady-ai/Dangerous-Heartbeat-Classification-MLOps.git
    cd Dangerous-Heartbeat-Classification-MLOps
    ```

2. **Build the Docker image:**

    ```bash
    docker build -t heartbeat-classification-api .
    ```

3. **Run the Docker container:**

    ```bash
    docker run -p 8000:8000 heartbeat-classification-api
    ```

4. **Deploy on Kubernetes:**

    Ensure your Kubernetes cluster is running, then apply the deployment and service configurations:

    ```bash
    kubectl apply -f k8s/deployment.yaml
    kubectl apply -f k8s/service.yaml
    ```

## Usage

### Local Development

1. **Start the FastAPI server:**

    ```bash
    uvicorn myapi:app --reload
    ```

2. **Access the API documentation:**

    Open your browser and navigate to `http://127.0.0.1:8000/docs` to access the interactive API documentation provided by Swagger UI.

### Docker

Access the API documentation at `http://localhost:8000/docs` after running the Docker container.

### Kubernetes

Access the API through the Kubernetes service endpoint. You can find the endpoint by running:

    ```bash
    kubectl get services
    ```
## Kubernetes Details

### Service

A Kubernetes Service is an abstraction that defines a logical set of Pods and a policy by which to access them. Services are used to expose your application to external traffic or to other services within the cluster.

Example `service.yaml`:

```yaml
apiVersion: v1
kind: Service
metadata:
  name: heartbeat-classification-service
spec:
  selector:
    app: heartbeat-classification
  ports:
    - protocol: TCP
      port: 80
      targetPort: 8000
  type: LoadBalancer
```

### Deployment

A Kubernetes Deployment provides declarative updates to applications. You describe a desired state in a Deployment, and the Deployment Controller changes the actual state to the desired state at a controlled rate.

Example `deployment.yaml`:

```yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: heartbeat-classification-deployment
spec:
  replicas: 3
  selector:
    matchLabels:
      app: heartbeat-classification
  template:
    metadata:
      labels:
        app: heartbeat-classification
    spec:
      containers:
        - name: heartbeat-classification-container
          image: heartbeat-classification-api:latest
          ports:
            - containerPort: 8000
```

### ReplicaSet

A ReplicaSet ensures that a specified number of pod replicas are running at any given time. However, it is recommended to use Deployments instead of directly using ReplicaSets, as Deployments provide additional features like rolling updates.

### Rolling Update

A rolling update allows you to update the Pods instances with new ones. The old Pods are terminated only after new Pods are running.

You can configure rolling updates in your Deployment specification:

```yaml
spec:
  strategy:
    type: RollingUpdate
    rollingUpdate:
      maxUnavailable: 1
      maxSurge: 1
```

- `maxUnavailable`: Specifies the maximum number of Pods that can be unavailable during the update process.
- `maxSurge`: Specifies the maximum number of Pods that can be created over the desired number of Pods.

## Contributing

Contributions are welcome! Please follow these steps to contribute:

1. Fork the repository.
2. Create a new branch (`git checkout -b feature-branch-name`).
3. Make your changes and commit them (`git commit -m 'Add some feature'`).
4. Push to the branch (`git push origin feature-branch-name`).
5. Submit a pull request.

## License

This project is licensed under the MIT License - see the LICENSE file for details.