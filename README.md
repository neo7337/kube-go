# kube-go

a go server to be deployed to kubernetes\
kubernetes commands

## Creating a deployment on kubernetes
```
kubectl apply -f kubernetes/deployments/app-deployment.yaml
```
## Check the running pods
```
kubectl get pods
```
## Describe the deployemt 
```
kubectl describe deployment <deployment name>
```
Once we have the pods running we expose those pods using a service
## Creating a service on kubernetes
```
kubectl apply -f kubernetes/services/app-services.yaml
```
## Checking the status of running services
```
kubectl get services
```
## Testing the running pods
Port forward the running service in order to test the running pod\
Get the pod name from the kubectl get pods
```
kubectl port-forward <pod_name> new_port:pod's port
```
## Deleting the pods and services
```
kubectl delete deployment <deployment_name>
kubectl delete service <service_name>
```
## Testing the exposed Service
```
minikube service <serviceName> --url
```
# Deployment using Helm Charts
- Create helm chart
```
helm create <chartName>
```
- Define the values.yaml according to the specification
- Define the deployment and services yaml files according to the needs
- Configure the Chart.yaml file according to the details given in the file

## Deploying using Helm
```
helm install <releaseName> ./<chartBaseDirectory>
```

## Uninstalling the helm chart
This removes the complete deployment that we did in the K8s cluster\
```
helm uninstall <chartName>
```

## Upgrade the helm charts in case of change in the values.yaml file

In this way by providing all such installing, uninstalling, upgrade functions helm becomes a package manager for teh kubernetes environment.
