#!/bin/bash

kubectl create ns jenkins

kubectl apply -f ./script/jenkins.yaml
