#!/bin/bash
sudo mkdir /app_data /frontend /backend

cat <<EOT>> /app_data/base_config.env
AWS_ROOT=${root}
AWS_REGION=${region}
EOT