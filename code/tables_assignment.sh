#!/bin/bash
#Tables assignment | Mark Bates(20088639) | Applied Computing(IoT)

#Variables
NUMBER=0
LIVES=0
CHOICE=0
ARITHMETIC_OP=0
NUM_QUESTIONS=20
USER="sJobs"
Pass=""
LEVEL=2 #student is lvl 2


declare -A STORE_RESULTS # assosicative array
for((i=0; i<NUM_QUESTIONS; i++))
do
	for((j=0; j<6; j++))
	do
		STORE_RESULTS[${i},${j}]=0 #initalize array, making all elements = 0
	done
done


makeChoice(){

	#dialog --title "Menu" --msgbox "choose from below" 10 50

	if [ $LEVEL -eq 2 ] #student
	then
		until [ $CHOICE -ge 2 -a $CHOICE -le 3 ] #until choice is one of the numbers below
		do
			echo "Choose from the following below:"
			echo "1) Learn Tables"
			echo "2) take Quiz"
			echo "3) Exit"
			read CHOICE #read the input and set it as the new $CHOICE

			if [ $CHOICE -lt 1 -o $CHOICE -gt 3 ]
			then
				echo "Choice must be 1,2 or 3"
			fi
			if [ $CHOICE -eq 1 ]
			then
				learnTables
			fi
			if [ $CHOICE -eq 2 ]
			then
				takeQuiz
			fi
		done

	elif [ $LEVEL -eq 1 ] #teacher
	then
		until [ $CHOICE -ge 1 -a $CHOICE -le 2 ]
		do
			echo "Choose from the following below:"
			echo "1) Student Results"
			echo "2) Manage Students"
			read CHOICE

			if [ $CHOICE -lt 1 -o $CHOICE -gt 2 ]
			then
				echo "Choice must be 1 or 2"
			fi
		done
	else
		echo "$LEVEL not found"
	fi
}

chooseNumber(){
	clear
	until [ $NUMBER -ge 1 -a $NUMBER -le 20 ]
	do
		echo "enter number between 1 and 20"
		read NUMBER

		if [ $NUMBER -lt 1 -o $NUMBER -gt 20 ]
		then
			echo "number must be between 1 and 20"
		fi
	done
}

chooseArithmetic(){
	clear
	until [ $ARITHMETIC_OP -ge 1 -a $ARITHMETIC_OP -le 4 ]
	do
		echo "Choose an Arithmetic Operation below:"
		echo "1) Addition"
		echo "2) Subtraction"
		echo "3) Multiplication"
		echo "4) Division"
		read ARITHMETIC_OP

		if [ $ARITHMETIC_OP -lt 1 -o $ARITHMETIC_OP -gt 4 ]
		then
			echo "number must be between 1 and 4"
		fi
	done
}

learnTables(){
	chooseNumber
	chooseArithmetic
}

takeQuiz(){
	#clear
	echo "Take Tables Quiz"
	chooseNumber
	local R X=1 Y=4 R2 OPERAND1 OPERAND2
	for((i=0; i<NUM_QUESTIONS; i++))
	do
		R=$(($RANDOM%Y+X))
		echo "$R"

		case $R in
			1)
				echo "1) Addition"
				R2=$(($RANDOM%13))
				echo "what is $NUMBER + $R2?"
				read USER_ANS
				CORRECT_ANS=$(($NUMBER+$R2))
				OPERAND1=$NUMBER
				OPERAND2=$R2
				;;
			2)
				echo "2) Subtraction"
				#R2=
				#echo "$R2"
				;;
			3)
				echo "3) Multiplication"
				R2=$(($RANDOM%13))
                		echo "what is $R2 x $NUMBER?"
				read USER_ANS
				CORRECT_ANS=$(($R2*$NUMBER))
				OPERAND2=$NUMBER
				OPERAND1=$R2
				if [ $USER_ANS -eq $CORRECT_ANS ]
				then
					CORRECT=1
				else
					CORRECT=0
				fi
				;;
			4)
				echo "4) Division"
				#R2=$(($RANDOM%()))
				;;
			*)
				echo "number must be one of the following above"
				;;
		esac

		#STORE_RESULTS
	done

	writeToFile
}

writeToFile(){
	local file=$USER"-"$(date "+%Y%m%d%H%M%S")"-"$((RANDOM%999+1)).txt

	if [ ! -f "file" ] #if file exists
	then
		touch "$file" #create file if it doesn't exist
	fi

	>$file #clear contents

	for((i = 0; i < NUM_QUESTIONS; i++))
	do
		for((j = 0; j < 6; j++))
		do
			echo  "${STORE_RESULTS[${i},${j}]}\t" >> "$file"
		done
	done
	echo "\n" >> "$file"
	echo "$file"
}

#makeChoice
takeQuiz
#writeToFile
