#!/bin/bash

echo ""

echo -e "\nbuild docker ubuntu base image\n"
docker build -t eric/ubuntu:base .

echo ""