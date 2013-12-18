#!/bin/bash
echo "copying to EC2 instance..."

scp -i ../keyPair.pem EC2setup.sh ubuntu@"$1":EC2setup.sh
scp -i ../keyPair.pem data.sql ubuntu@"$1":data.sql

ssh -i ../keyPair.pem ubuntu@"$1" bash EC2setup.sh

