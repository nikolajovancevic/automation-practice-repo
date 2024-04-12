#! /bin/bash

back_to_start=false

# Methods 
basic_setup_exe() {
	#Update package list
	echo -e "\nUpdate package list\n-------------------------------------------------------------------------------------------\n"
	sudo apt update
	#Install snap
    echo -e "\nInstalling snap package system\n-------------------------------------------------------------------------------------------\n" 
	#Install Telegram
	echo -e "\nInstalling Telegram\n-------------------------------------------------------------------------------------------\n"
	sudo snap install telegram-desktop
	#Install Slack
	echo -e "\nInstalling Slack\n-------------------------------------------------------------------------------------------\n"
	sudo snap install slack
}

advanced_setup_exe() {
	basic_setup_exe
	#Install Brave
  	echo -e "\nInstalling Brave\n-------------------------------------------------------------------------------------------"
  	sudo curl -fsSLo /usr/share/keyrings/brave-browser-archive-keyring.gpg https://brave-browser-apt-release.s3.brave.com/brave-browser-archive-keyring.gpg
  	sudo apt install brave-browser

  	#Install VS Code
  	echo -e "\nInstalling VS code\n-------------------------------------------------------------------------------------------"
  	sudo snap install --classic code

  	#Install Postman
  	echo -e "\nInstalling Postman\n-------------------------------------------------------------------------------------------"
  	sudo snap install postman

  	#Install Node LTS
 	echo -e "\nInstalling Node LTS\n------------------------------------------------------------------------------------------"
  	# Installs NVM (Node Version Manager)
	sudo curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
  	# Download and install Node.js
  	nvm install 20
		nvm use 20
}

wrong_input() {
	echo -e "\nPlease enter valid option!\n.\n.\n."
	sleep 0.5
}

return_to_start() {
	echo -e ".\n.\n.\n\nBack to menu..."
	back_to_start=true
	sleep 0.5
}

basic_setup() {
	while [[ "$back_to_start" = false ]]; do	
		echo -e ".\n.\n.\n\tBASIC SETUP\n-------------------------------------------------------------------------------------------\n"
		echo -e "Basic setup will install: \n- Telegram\n- Slack\n\nProceed? (y/n)"
		read -p "" option
		
		if [[ "$option" =~ ^[Yy](es)?$ ]]; then
			basic_setup_exe   
			echo -e "\n\t --- Finished basic setup! ---\n"
			exit        
        elif [[ "$option" =~ ^[Nn]o?$ ]]; then
			return_to_start
        else    
			wrong_input
		fi
    done
}

advanced_setup() {
	while [[ "$back_to_start" = false ]]; do	
		echo -e ".\n.\n.\n\tADVANCED SETUP\n-------------------------------------------------------------------------------------------\n"
	    echo -e "Advanced setup will install: \n- Telegram\n- Slack\n- Brave\n- VS Code\n- Postman\n- Node LTS\n\nProceed? (y/n)"
	    read -p "" option
		
		if [[ "$option" =~ ^[Yy](es)?$ ]]; then
			advanced_setup_exe 
			echo -e "\n\t --- Finished advanced setup! ---\n"   
			exit       
        elif [[ "$option" =~ ^[Nn]o?$ ]]; then
			return_to_start
        else    
			wrong_input
		fi	
    done
}

#Main script - Installation setup
while true; do
  	if [ "$back_to_start" = false ]; then
		sudo echo -e "\n\tMAIN MENU:\n-------------------------------------------------------------------------------------------\n\n1. Basic setup\n2. Advanced setup\n"
		read -p "Enter number: " option
    
	    if [[ "$option" -eq 1 ]]; then 
			basic_setup
	   	elif [[ "$option" -eq 2 ]]; then
			advanced_setup
		elif ! [[ "$option" -eq 1 || "$option" -eq 2 ]]; then
			wrong_input
	   	else
	     	back_to_start=false
	  	fi
		back_to_start=false
 	fi
done
