#!/usr/bin/bash
#Autor: Luis Carreto
#Descripcion: Envia una peticion TCP a los 65535 puertos, si el puerto se encuentra cerrado retorna un error, si no llegase a retornar el error se imprime en pantalla que el puerto se encuentra abierto

if [ "$1" == "" ]; then
          echo "Usage: bash `basename $0` <ip> " && echo ""
          echo "Example: `basename $0` 15.15.15.15" && echo ""
          exit 0
fi

echo "[+]Starting scan ports " 
for port in $(seq 1 65535); do
        timeout 1 bash -c "echo > /dev/tcp/$1/$port" 2>/dev/null && echo "PORT $port OPEN " && echo "PORT $port OPEN " >> scan_ports &
done; wait
