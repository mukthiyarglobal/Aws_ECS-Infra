 #!/bin/bash

# Prompt user for input
echo "Do you want to apply or destroy infrastructure? (apply/destroy)"
read -r choice

# Check user's choice and execute corresponding Terraform command
if [ "$choice" = "apply" ]; then
    terraform apply -auto-approve
elif [ "$choice" = "destroy" ]; then
    terraform destroy -auto-approve
else
    echo "Invalid choice. Please enter 'apply' or 'destroy'."
    exit 1
fi
