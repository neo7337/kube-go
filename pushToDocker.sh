#! /bin/sh

set -e

if [ $# -lt 3 ]; then
    echo "Correct Input <<USERNAME>> <<TAG REF>> <<EVENT_NAME>> not present, exiting script execution"
    exit 1
fi

if [ $3 == 'pull_request' ]; then
    echo "Building Image"
    docker build -t $1/kube-go:$2 .
else
    echo "Building Image"
    docker build -t $1/kube-go:$2 .

    echo "Pushing Tag :$2"
    docker push $1/kube-go:$2

    echo "Listing Images"
    docker images

    echo "Tagging Image as latest"
    docker tag $1/kube-go:$2 neo73/kube-go:latest

    echo "Push Tag :latest"
    docker push neo73/kube-go:latest
fi
