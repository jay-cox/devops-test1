#!/bin/bash

export PROJECT_ID='devops-test1-1051'
export SERVICE_NAME='helloevite'
export GCLOUD_REGION=us-central1

echo 'Setting region...'
gcloud config set run/region $GCLOUD_REGION

echo 'Setting project...'
gcloud config set project ${PROJECT_ID}

echo 'Enabling API services...'
gcloud services enable run.googleapis.com
gcloud services enable cloudbuild.googleapis.com


echo 'Building...'
gcloud builds submit --tag gcr.io/${PROJECT_ID}/${SERVICE_NAME}

echo 'Deploying...'
#gcloud beta run deploy ${PROJECT_ID} --image gcr.io/${PROJECT_ID}/app --platform managed --allow-unauthenticated
gcloud beta run deploy ${SERVICE_NAME} --image gcr.io/${PROJECT_ID}/${SERVICE_NAME} --platform managed --allow-unauthenticated