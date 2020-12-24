#!/bin/bash
terraform init -backend-config=backend.hcl
terraform apply -auto-approve