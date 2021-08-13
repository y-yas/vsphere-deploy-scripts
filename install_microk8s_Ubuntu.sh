#!/bin/bash

sudo apt update
sudo snap install microk8s --classic

sudo usermod -a -G microk8s $USER
sudo chown -f -R $USER ~/.kube

sudo snap alias microk8s.kubectl kubectl