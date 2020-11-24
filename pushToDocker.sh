#! /bin/sh

set -e

if [ $# -lt 2 ]; then
    echo "Correct Input <<USERNAME>> <<TAG REF>> not present, exiting script execution"
    exit 1
fi

echo "Building Image"
docker build -t neo73/kube-go:$1 .

echo "Pushing Tag :$1"
docker push neo73/kube-go:$1

echo "Listing Images"
docker images

echo "Tagging Image as latest"
#docker tag neo73/kube-go:$1 neo73/kube-go:latest

echo "Push Tag :latest"
#docker push neo73/kube-go:latest
