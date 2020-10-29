#!/bin/bash
sudo mkdir /app_data /frontend /backend

# Replace us-west-2 with reference to provider.region
cat <<EOT>> /app_data/base_config.env
AWS_ROOT="/rds/"
AWS_REGION="us-west-2" 
EOT