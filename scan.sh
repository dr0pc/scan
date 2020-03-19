#!/usr/bin/bash
#Envia una peticion TCP a los 65535 puertos, si el puerto se encuentra cerrado retorna un error, si no llegase a retornar el error se imprime en pantalla que
#el puerto se encuentra abierto

for port in $(seq 1 65535); do
        timeout 1 bash -c "echo > /dev/tcp/$1/$port" 2>/dev/null && echo "PORT $port OPEN " &
done; wait
