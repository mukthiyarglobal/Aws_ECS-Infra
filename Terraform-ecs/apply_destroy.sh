#!/bin/bash

# Prompt user for input
read -p "Do you want to apply or destroy infrastructure? (apply/destroy): " choice

# Convert user input to lowercase
choice=$(echo "$choice" | tr '[:upper:]' '[:lower:]')

# Validate user input
if [[ "$choice" == "apply" ]]; then
    echo "Applying infrastructure..."
    terraform apply -auto-approve ./Terraform-ecs
elif [[ "$choice" == "destroy" ]]; then
    echo "Destroying infrastructure..."
    terraform destroy -auto-approve ./Terraform-ecs
else
    echo "Invalid choice. Please enter 'apply' or 'destroy'."
    exit 1
fi
