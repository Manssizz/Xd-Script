#!/bin/bash
dir_user="/userDIR"
dir="/etc/adm-lite"
name=$(cat < /bin/ejecutar/autt)
bc="$HOME/$name"
arquivo_move="$name"
fun_ip () {
MEU_IP=$(ip addr | grep 'inet' | grep -v inet6 | grep -vE '127\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | grep -o -E '[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}' | head -1)
MEU_IP2=$(wget -qO- ipv4.icanhazip.com)
[[ "$MEU_IP" != "$MEU_IP2" ]] && echo "$MEU_IP2" || echo "$MEU_IP"
}
removeonline(){
i=1
    [[ -d /var/www/html ]] && [[ -e /var/www/html/$arquivo_move ]] && rm -rf /var/www/html/$arquivo_move > /dev/null 2>&1
    [[ -e /var/www/$arquivo_move ]] && rm -rf /var/www/$arquivo_move > /dev/null 2>&1
    echo -e "${cor[5]}Extraxion Exitosa Exitosa"
    echo -e "$barra"
echo "SUBIENDO"
subironline
}   
subironline(){
[ ! -d /var ] && mkdir /var
[ ! -d /var/www ] && mkdir /var/www
[ ! -d /var/www/html ] && mkdir /var/www/html
[ ! -e /var/www/html/index.html ] && touch /var/www/html/index.html
[ ! -e /var/www/index.html ] && touch /var/www/index.html
chmod -R 755 /var/www
cp $HOME/$arquivo_move /var/www/$arquivo_move
cp $HOME/$arquivo_move /var/www/html/$arquivo_move
service apache2 restart
IP="$(fun_ip)"
echo -e "\033[1;36m http://$IP:81/$arquivo_move\033[0m"
echo -e "$barra"
echo -e "${cor[5]}Carga Exitosa!"
echo -e "$barra"
}

function backup_de_usuarios(){
clear
i=1
[[ -e $bc ]] && rm $bc
echo -e "\033[1;37mHaciendo Backup de Usuarios...\033[0m"
for user in `awk -F : '$3 > 900 { print $1 }' /etc/passwd |grep -v "nobody" |grep -vi polkitd |grep -vi systemd-[a-z] |grep -vi systemd-[0-9] |sort`
do
if [ -e $dir$dir_user/$user ]
then
pass=$(cat $dir$dir_user/$user | grep "senha" | awk '{print $2}')
limite=$(cat $dir$dir_user/$user | grep "limite" | awk '{print $2}')
data=$(cat $dir$dir_user/$user | grep "data" | awk '{print $2}')
data_sec=$(date +%s)
data_user=$(chage -l "$user" |grep -i co |awk -F ":" '{print $2}')
data_user_sec=$(date +%s --date="$data_user")
variavel_soma=$(($data_user_sec - $data_sec))
dias_use=$(($variavel_soma / 86400))
if [[ "$dias_use" -le 0 ]]; 
then
dias_use=0
fi
sl=$((dias_use + 1))
i=$((i + 1))
 if [ -z "$limite" ]; then
 limite="5"
 fi
else
echo -e "\033[1;31mNo fue posible obtener la contraseña del usuario\033[1;37m ($user)"
#read -p "Introduzca la contraseña manualmente o pulse ENTER: " pass
 if [ -z "$pass" ]; then
pass="$user"
 fi
fi
echo "$user:$pass:$limite:$sl" >> $bc
echo -e "\033[1;37mUser $user Backup [\033[1;31mOK\033[1;37m]\033[0m"
done
echo " "
echo -e "\033[1;31mBackup Completado !!!\033[0m"
echo " "
echo -e "\033[1;37mLa informacion de los usuarios $i se encuentra en el archivo \033[1;31m $bc \033[1;37m"
}
backup_de_usuarios
removeonline
rm $HOME/$arquivo_move
