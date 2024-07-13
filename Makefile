# Variables
DOCKER_IMAGES = auth-svc comment-svc post-svc user-svc frontend
K8S_MANIFEST_DIRS = /Users/sagars01/Desktop/Projects/kube-gcp-tut/auth-svc/k8s \
                    /Users/sagars01/Desktop/Projects/kube-gcp-tut/comment-svc/k8s \
                    /Users/sagars01/Desktop/Projects/kube-gcp-tut/post-svc/k8s \
                    /Users/sagars01/Desktop/Projects/kube-gcp-tut/user-svc/k8s \
                    /Users/sagars01/Desktop/Projects/kube-gcp-tut/frontend/k8s

# Default target
.PHONY: all
all: use-minikube-docker build-images start-minikube deploy

# Use Minikube's Docker daemon
.PHONY: use-minikube-docker
use-minikube-docker:
	@eval $$(minikube docker-env)

# Build Docker images for all services using Minikube's Docker daemon
.PHONY: build-images
build-images:
	@for image in $(DOCKER_IMAGES); do \
		echo "Building $$image..."; \
		docker build -t $$image:latest ./$$image; \
	done

# Start Minikube
.PHONY: start-minikube
start-minikube:
	@echo "Starting Minikube..."
	minikube start

# Deploy all Kubernetes manifests
.PHONY: deploy
deploy:
	@for dir in $(K8S_MANIFEST_DIRS); do \
		for file in $$(ls $$dir/*.yaml); do \
			echo "Applying $$file..."; \
			kubectl apply -f $$file; \
		done \
	done

# Stop Minikube
.PHONY: stop-minikube
stop-minikube:
	@echo "Stopping Minikube..."
	minikube stop

# Clean up Docker images, Kubernetes resources, and Minikube cluster
.PHONY: clean
clean:
	# Remove Docker images
	@for image in $(DOCKER_IMAGES); do \
		echo "Removing Docker image $$image..."; \
		docker rmi $$image:latest; \
	done
	# Delete Kubernetes resources
	@for dir in $(K8S_MANIFEST_DIRS); do \
		for file in $$(ls $$dir/*.yaml); do \
			echo "Deleting Kubernetes resources from $$file..."; \
			kubectl delete -f $$file; \
		done \
	done
	# Delete Minikube cluster
	@echo "Deleting Minikube cluster..."
	minikube delete
