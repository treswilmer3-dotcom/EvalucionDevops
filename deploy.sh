#!/bin/bash

# Script de despliegue completo del laboratorio Ansible

set -e

echo "🚀 Iniciando despliegue del laboratorio Ansible..."

# 1. Desplegar infraestructura con Terraform
echo "📦 Desplegando infraestructura AWS con Terraform..."
cd Infra_AWS_Ansible

# Inicializar Terraform
terraform init

# Aplicar infraestructura
terraform apply -auto-approve

# Obtener IPs de salida
echo "📋 Obteniendo IPs de las instancias..."
MASTER_IP=$(terraform output -raw ansible_master_public_ip)
TERMINAL_IPS=$(terraform output -json terminales_private_ips | jq -r '.[]')

echo "✅ Infraestructura desplegada!"
echo "🔹 Ansible Master IP: $MASTER_IP"
echo "🔹 Terminales IPs: $TERMINAL_IPS"

# 2. Actualizar inventario Ansible
echo "📝 Actualizando inventario Ansible..."
cd ../Ansible

# Reemplazar IPs en el inventario
sed -i "s/<IP_PUBLICA_MASTER>/$MASTER_IP/g" inventory.ini

# Actualizar IPs de terminales
i=1
for ip in $TERMINAL_IPS; do
    sed -i "s/<IP_PRIVADA_TERMINAL_$i>/$ip/g" inventory.ini
    sed -i "s/<IP_PUBLICA_MASTER>/$MASTER_IP/g" inventory.ini
    ((i++))
done

echo "✅ Inventario actualizado!"

# 3. Copiar clave SSH y configurar acceso
echo "🔑 Configurando acceso SSH..."
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Si no existe la clave, pedirla
if [ ! -f ~/.ssh/pruebasvale5.pem ]; then
    echo "⚠️  No se encuentra la clave SSH 'pruebasvale5.pem'"
    echo "Por favor, copia la clave a ~/.ssh/pruebasvale5.pem y ejecuta:"
    echo "chmod 400 ~/.ssh/pruebasvale5.pem"
    exit 1
fi

chmod 400 ~/.ssh/pruebasvale5.pem

# 4. Probar conexión al master
echo "🔍 Probando conexión al Ansible Master..."
ssh -i ~/.ssh/pruebasvale5.pem -o StrictHostKeyChecking=no ec2-user@$MASTER_IP "echo '✅ Conexión exitosa al Ansible Master!'"

# 5. Copiar archivos de configuración Ansible al master
echo "📤 Copiando configuración Ansible al master..."
scp -i ~/.ssh/pruebasvale5.pem -o StrictHostKeyChecking=no inventory.ini ec2-user@$MASTER_IP:/home/ec2-user/
scp -i ~/.ssh/pruebasvale5.pem -o StrictHostKeyChecking=no -r playbooks ec2-user@$MASTER_IP:/home/ec2-user/
scp -i ~/.ssh/pruebasvale5.pem -o StrictHostKeyChecking=no -r roles ec2-user@$MASTER_IP:/home/ec2-user/

echo "🎉 ¡Despliegue completado!"
echo ""
echo "📋 Próximos pasos:"
echo "1. Conectar al Ansible Master:"
echo "   ssh -i ~/.ssh/pruebasvale5.pem ec2-user@$MASTER_IP"
echo ""
echo "2. Ejecutar playbook de setup:"
echo "   ansible-playbook -i inventory.ini playbooks/setup.yml"
echo ""
echo "3. Probar conectividad:"
echo "   ansible-playbook -i inventory.ini playbooks/test-connectivity.yml"
echo ""
echo "🔹 Ansible Master: $MASTER_IP"
echo "🔹 KeyPair: pruebasvale5.pem"
