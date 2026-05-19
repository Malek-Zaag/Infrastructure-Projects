#!/bin/sh


set -euo

minikube status 
minikube delete
minikube start --cpus 6 --memory 8192