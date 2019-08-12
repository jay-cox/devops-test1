#!/bin/bash

set -e

export PROJECT_ID='devops-test1-1420'
export SERVICE_NAME='hello-evite'
export GCLOUD_REGION='us-central1'

echo "Setting region to ${GCLOUD_REGION}..."
gcloud config set run/region $GCLOUD_REGION

echo "Setting project ID to ${PROJECT_ID}..."
gcloud config set project $PROJECT_ID

echo 'Enabling API services...'
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com

echo 'Building...'
gcloud builds submit --tag gcr.io/${PROJECT_ID}/${SERVICE_NAME}

if [ $? -eq 0 ]
then
  echo "Image built. Deploying..."
  gcloud beta run deploy ${SERVICE_NAME} --image gcr.io/${PROJECT_ID}/${SERVICE_NAME} --platform managed --allow-unauthenticated
  exit 0
else
  echo "Image failed to build." >&2
  exit 1
fi