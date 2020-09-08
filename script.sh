
#!/bin/bash
#Este script tem por finalidade acesso massivo a dispositivos de rede ou servidores via ssh, e execução de comandos concatenados.
#Data 03/08/2019
#Developed By PR3770X
echo "Insira o usuário com permissão Full no dispositivo:"
read usuario
export user=$usuario
stty -echo
echo "Forneça a senha de autenticação para o usuário com permissão:"
read senha
export pass=$senha
export port=[alterar caso não seja padrão]
for hosts in $(cat devices.txt); do
        teste=$(ping -w 1 $hosts | grep 'received' | awk -F',' '{ print $2 }'| awk '{ print $1 }')
        if [ $teste -eq 0 ];
                then
                        echo "O dispositivo $hosts esta OFFLINE em $(date)!"
                else
                        export host=$hosts
                        sshpass -p $pass ssh -t -o StrictHostKeyChecking=no $user@$host -p $port '/user print; /user add name=teste password=teste group=full;
                        /
                        quit'
                        echo "O comando no dispositivo $host foi executado com sucesso em $(date)!"
                        echo "Checando próximo host"
        fi
done
echo "Não há mais dispositivos para serem verificados!!"
