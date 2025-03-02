# Image API

## Summary

Image API is an image storage and retrieval service written in node that can be accessed using APIs

## Features

### Upload new images

You can issue a `POST /api/images` that includes an images within a multi-part payload, the name of the multi-part field should be `images`.

### Retrieve existing image

You can request an existing image using `GET /api/images?id=IMAGE_ID_HERE` to receive the image

## Building and running

1. Run `npm install` to install dependencies
1. Run `npm i -g typescript` to install typescript
1. Run `tsc` to build the source
1. Run `node .` to run the compiled source

## Configuration

Configurations for the application as under `/config`.
Requests are logged using [morgan](https://www.npmjs.com/package/morgan).
Linting and Prettier are enabled, please refer to `scripts` in `package.json`.




#########################################

# Image API - Deployment with Helm & AWS ECR

This project contains an API that is containerized using Docker, stored in **AWS ECR**, and deployed to **AWS EKS** using Helm.

---

## **Project Structure**

```
.
├── helm-chart/         # Helm Chart for Kubernetes deployment
├── index.js            # Main server script
├── package.json        # Node.js package config
├── values.yaml         # Helm values for deployment
├── Dockerfile          # Docker configuration
├── .github/workflows/  # GitHub Actions for CI/CD
└── README.md           # Documentation
```

---

## **Installation & Setup**

### **1. Install Dependencies**

Make sure you have **Node.js** installed. Then run:

```sh
npm install
```

### **2. Build & Start the Application**

To build and start the application, use:

```sh
npm run build
npm start
```

- `` → Compiles the project (if required).
- `` → Runs `index.js` and starts the API server.

### **3. Run in Development Mode**

For development mode with live reload:

```sh
npm run dev
```

---

## **Docker Build & Push to AWS ECR**

To build and push the Docker image to AWS ECR, run:

```sh
aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com
docker build -t <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/image-api:latest .
docker push <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/image-api:latest
```

---

## **Deploying to Kubernetes with Helm**

### **1. Update **``

Modify `values.yaml` to set your ECR image repository:

```yaml
image:
  repository: <AWS_ACCOUNT_ID>.dkr.ecr.us-east-1.amazonaws.com/image-api
  tag: latest
```

### **2. Deploy using Helm**

Deploy the application to your Kubernetes cluster:

```sh
helm upgrade --install image-api ./helm-chart -n image-api-ns --create-namespace -f values.yaml
```

---

## **Checking Application Status**

### **Check Pods**

```sh
kubectl get pods -n image-api-ns
```

### **Check Logs**

```sh
kubectl logs -f deployment/image-api -n image-api-ns
```

---

## **Contributing**

1. Fork the repository.
2. Create a feature branch (`git checkout -b feature-branch`).
3. Commit your changes (`git commit -m "Add new feature"`).
4. Push to the branch (`git push origin feature-branch`).
5. Open a pull request.

---

## **License**

This project is licensed under the MIT License.

