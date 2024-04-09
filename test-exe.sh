#! /bin/bash

# vars
back_to_start=false
ENV=dev
HEADLESS=headless

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

go_back() {
	echo -e ".\n.\n.\n\nGoing back..."
	back_to_start=true
	sleep 0.5
}

choose_env() {
	echo -e "\nChoose environment: \n\n1. DEV \n2. STAGE\n"
	read -p "Enter number: " option 

	case $option in
		1)
			echo -e "\nDEV env selected...\n"
			ENV=dev
			;;
		2)
			echo -e "\nSTAGE env selected...\n"
			ENV=stage
			;;
	esac
}

headfull_mode() {
	echo -e "\nChoose mode: \n\n1. HEADLESS \n2. HEADFULL\n"
	read -p "Enter number: " option 

	case $option in
		1)
			echo -e "\HEADLESS mode selected...\n"
			HEADLESS=true
			;;
		2)
			echo -e "\nHEADFULL mode selected...\n"
			HEADLESS=false
			;;
	esac
}

smoke_test() {
		while [[ "$back_to_start" = false ]]; do	
			echo -e ".\n.\n.\n\tSMOKE TEST OPTIONS\n-------------------------------------------------------------------------------------------\n"
			echo -e "\nTest groups: \n\n1. Full Smoke test\n2. Metamask Smoke\n3. Home page Smoke\n4. Guest Smoke\n5. User Smoke\n0. Back\n"
			read -p "Enter number: " option

			case $option in 
				1)
					headfull_mode
					choose_env
					echo -e "\nExecuting Full Smoke...\nENV=$ENV, HEADLESS=$HEADLESS"
					exit
					# ./scripts/smoke.sh $ENV $HEADLESS
					;;
				2)
					headfull_mode
					choose_env
					echo -e "\nExecuting Metamask Smoke..."
					exit
					# ./scripts/metamask.sh $ENV $HEADLESS
					;;
				3)
					headfull_mode
					choose_env
					echo -e "\nExecuting Home page Smoke..."
					exit
					# ./scripts/homepage.sh $ENV $HEADLESS
					;;
				4)
					headfull_mode
					choose_env
					echo -e "\nExecuting Guest Smoke..."
					exit
					# ./scripts/guest.sh $ENV $HEADLESS
					;;
				5)
					headfull_mode
					choose_env
					echo -e "\nExecuting User Smoke..."
					exit
					# ./scripts/user.sh $ENV $HEADLESS
					;;
				0) 
					go_back
					;;
				*)
					wrong_input
					;;
			esac
	    done
}

#Main script - Test execution
while true; do
  	if [ "$back_to_start" = false ]; then
		sudo echo -e "\n\tMAIN MENU:\n-------------------------------------------------------------------------------------------\n\n1. Smoke\n2. Regression\n3. API\n"
		read -p "Enter number: " option
    
	    if [[ "$option" -eq 1 ]]; then 
			smoke_test
	   	elif [[ "$option" -eq 2 ]]; then
			echo -e "\nExecuting Regression test script...\n"
			exit
		elif [[ "$option" -eq 3 ]]; then
			echo -e "\nExecuting API test script...\n"
			exit
		elif ! [[ "$option" -eq 1 || "$option" -eq 2 || $option -eq 3 ]]; then
			wrong_input
	   	else
	     	back_to_start=false
	  	fi
		back_to_start=false
 	fi
done