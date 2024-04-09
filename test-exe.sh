#! /bin/bash

# vars
ENV=dev
HEADLESS=true
back_to_start=false
wrong_mode_input=true
wrong_env_input=true

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
	while [[ "$wrong_env_input" = true ]]; do
		echo -e "\nChoose environment: \n\n1. DEV \n2. STAGE\n"
		read -p "Enter number: " option 

		case $option in
			1)
				echo -e "\nDEV env selected...\n"
				ENV=dev
				wrong_env_input=false
				;;
			2)
				echo -e "\nSTAGE env selected...\n"
				ENV=stage
				wrong_env_input=false
				;;
			*)
				wrong_input
				;;
		esac
	done
}

headfull_mode() {
	while [[ "$wrong_mode_input" = true ]]; do
		echo -e "\nChoose mode: \n\n1. HEADLESS \n2. HEADFULL\n"
		read -p "Enter number: " option 

		case $option in
			1)
				echo -e "\nHEADLESS mode selected...\n"
				HEADLESS=true
				wrong_mode_input=false
				;;
			2)
				echo -e "\nHEADFULL mode selected...\n"
				HEADLESS=false
				wrong_mode_input=false
				;;
			*)
				wrong_input
				;;
		esac
	done
}

smoke_test() {
	headfull_mode
	choose_env
	echo -e "\nExecuting Smoke test script...ENV=$ENV, HEADLESS=$HEADLESS"
	exit
	# ./scripts/smoke-test.sh $ENV $HEADLESS
}

api_test() {
	headfull_mode
	choose_env
	echo -e "\nExecuting API test script...ENV=$ENV, HEADLESS=$HEADLESS"
	exit
	# ./scripts/api-test.sh $ENV $HEADLESS
}

regression_test() {
	while [[ "$back_to_start" = false ]]; do	
		echo -e ".\n.\n.\n\tREGRESSION TESTS\n-------------------------------------------------------------------------------------------\n"
		echo -e "\nTest groups: \n\n1. First test group\n2. Second test group\n3. Third test group\n0. Back\n"
		read -p "Enter number: " option
		
		case $option in 
			1)
				headfull_mode
				choose_env
				echo -e "\nExecuting First test group...\nENV=$ENV, HEADLESS=$HEADLESS"
				exit
				# ./scripts/first-group.sh $ENV $HEADLESS
				;;
			2)
				headfull_mode
				choose_env
				echo -e "\nExecuting Second test group...\nENV=$ENV, HEADLESS=$HEADLESS"
				exit
				# ./scripts/second-group.sh $ENV $HEADLESS
				;;
			3)
				headfull_mode
				choose_env
				echo -e "\nExecuting Third test group...\nENV=$ENV, HEADLESS=$HEADLESS"
				exit
				# ./scripts/third-group.sh $ENV $HEADLESS
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

### Main script - Test execution ### 
while true; do
  	if [ "$back_to_start" = false ]; then

		sudo echo -e "\n\tMAIN MENU:\n-------------------------------------------------------------------------------------------\n\n1. Smoke\n2. Regression\n3. API\n"
		read -p "Enter number: " option
    
	    if [[ "$option" -eq 1 ]]; then 
				smoke_test
				exit
	   	elif [[ "$option" -eq 2 ]]; then
				regression_test				
				exit
			elif [[ "$option" -eq 3 ]]; then
				api_test
				exit
			elif ! [[ "$option" -eq 1 || "$option" -eq 2 || $option -eq 3 ]]; then
				wrong_input
	  	 	else
	     	back_to_start=false
	  	fi
		back_to_start=false
 	fi
done