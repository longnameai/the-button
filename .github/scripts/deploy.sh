#!/bin/bash
set -e

IMAGE_NAME=$1
TAG=$2
EC2_HOST=$3
EC2_USER=$4
ENV_NAME=$5

echo "Deploying $IMAGE_NAME:$TAG to $ENV_NAME on $EC2_HOST..."

ssh -i ~/.ssh/deploy_key $EC2_USER@$EC2_HOST << EOF
  docker pull $IMAGE_NAME:$TAG
  docker stop the-button || true
  docker rm the-button || true
  docker run -d --name the-button -p 80:80 $IMAGE_NAME:$TAG
EOF

echo "Deployment finished!"
