#! /bin/sh

if [ $# -lt 1 ]; then
    echo "invalid arguments"
    echo "usage createk8sDeployment.sh <namespace>"
    exit 1
fi

namespace=$1
echo "Creating deployment in namespace: $namespace"
# check if a namespace exist
count=`kubectl get namespaces | grep $namespace | awk '{ print $(NF-1) }' | awk '{print NR}'`
if [ $count -gt 0 ]; then
    IS_EXIST=true
else
    IS_EXIST=false
fi

# creating a namespace
if [ "$IS_EXIST" == "false" ]; then
    kubectl create namespace $namespace
fi

#deploying app in namespace using Helm Chart
helm install goApp ./kubernetes/k8schart/appChart --namespace $namespace

#deploying Grafana using Helm Chart
grafanaCheck=`kubectl get namespaces | grep grafana | awk '{ print $(NF-1) }' | awk '{print NR}'`

if [ $grafanaCheck -gt 0 ]; then
    echo "Grafana namespace present already"
    checkGrafanaStatus=`kubectl get po -n grafana | awk '{if(NR>1)print}' | awk '{ print$(NF-2) }' | awk '{print NR}'`
    if [ $checkGrafanaStatus -gt 0 ]; then
        echo "Grafana Deployment already present"
    else
        echo "Deploying Grafana Helm Chart"
        helm install grafana ./kubernetes/k8schart/grafana --namespace grafana
    fi
else
    echo "Creating namespace: Grafana"
    kubectl create namespace grafana

    echo "deploying grafana Helm Chart"
    helm install grafana ./kubernetes/k8schart/grafana --namespace grafana
fi

#deploying Prometheus using Helm Chart
prometheusCheck=`kubectl get namespaces | grep monitoring | awk '{ print $(NF-1) }' | awk '{print NR}'`

if [ $prometheusCheck -gt 0 ]; then
    echo "Monitoring namespace present already"
    checkPrometheusStatus=`kubectl get po -n monitoring | awk '{if(NR>1)print}' | awk '{ print$(NF-2) }' | awk '{print NR}'`
    if [ $checkPrometheusStatus -gt 0 ]; then
        echo "Prometheus Deployment already present"
    else
        echo "Deploying Prometheus Helm Chart"
        helm install prometheus ./kubernetes/k8schart/prometheus --namespace monitoring
    fi
else
    echo "Creating namespace: monitoring"
    kubectl create namespace monitoring

    echo "Deploying Prometheus Helm Chart"
    helm install prometheus ./kubernetes/k8schart/prometheus --namespace monitoring
fi