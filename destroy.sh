#!/bin/bash

# Script para destruir toda la infraestructura

set -e

echo "🔥 Destruyendo infraestructura del laboratorio Ansible..."

cd Infra_AWS_Ansible

# Destruir infraestructura
terraform destroy -auto-approve

echo "✅ Infraestructura destruida correctamente!"
