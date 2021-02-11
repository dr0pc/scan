#!/usr/bin/bash                                                                                                
#Autor: Luis Carreto                                                                                           
#Descripcion: Envia una peticion TCP a los 65535 puertos, si el puerto se encuentra cerrado retorna un error, si no llegase a retornar el error se imprime en pantalla que el puerto se encuentra abierto                                                                                                               
                                                                                                               
if [ "$1" == "" ]; then                                                                                        
          echo "Usage: bash `basename $0` <ip> " && echo ""                                                    
          echo "Example: `basename $0` 15.15.15.15" && echo ""                                                 
          exit 0                                                                                               
fi                                                                                                                                                                                                                        
echo
echo "[+]INTENTANDO IDENTIFICAR EL S.O EN BASE AL TTL "
ttl=$(ping -c 1 $1 | grep ttl | sed 's/.*\sttl=\(...\).*/\1/')
  if [[ $ttl -gt 120 && $ttl -le 128  ]];then
          echo "[!] ==POSIBLE SISTEMA WINDOWS=="; echo;
  elif [[ $ttl -gt 60 && $ttl -le 64 ]];then
          echo "[!] ==POSIBLE SISTEMA LINUX=="; echo;
  elif [ $ttl == "" ];then
          echo "[-] SIN RESPUESTA, POSIBLE HOST DOWN O BLOQUEO ICMP!!"; echo;        
  else
          echo "[-] NO FUE POSIBLE IDENTIFICAR EL SISTEMA TTL DE $ttl"; echo;     
fi
echo "[+]Starting scan ports " 
echo "[+]Scan in $1" && echo "[+]Scan in $1" > scanports_$1
for port in $(seq 1 65535); do

        timeout 1 bash -c "echo > /dev/tcp/$1/$port" 2>/dev/null && echo "PORT $port OPEN " && echo "PORT $port OPEN " >> scanports_$1 &
done; wait
