# nginx-blue-green-deployment
This project sets up a blue-green deployment on Kubernetes with Nginx Ingress, routing 75% of traffic to the blue app and 25% to the green app. It uses Terraform for automation, with application configurations stored in a JSON file specifying the image, arguments, port, traffic weight, and replicas.
