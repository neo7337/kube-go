# kube-go

a go server to be deployed to kubernetes

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
Port forward the running service in order to test the running pod
Get the pod name from the kubectl get pods
kubectl port-forward <pod_name> new_port:pod's port

## Deleting the pods and services
```
kubectl delete deployment <deployment_name>
kubectl delete service <service_name>
```

