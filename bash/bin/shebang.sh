#!/data/data/com.termux/files/usr/bin/sh

export LOCPATH='#!'$PREFIX
if [ "$#" -lt 2 ]; then
	echo "\033[31m[!] Syntax error"
	echo "  _       "
	echo "  \033[94m|Usage :"
	echo "  \033[96m|shebang [program_name] [file_name] "
	echo "  |(program_name : python, ruby etc)"
else if [ -f $PREFIX/bin/$1 ]; then
	export PDOG=$LOCPATH/$1
	echo $PDOG > $2
	echo "\033[96msheband created in $2 for $1"
else 
	echo "\033[31merror!"
	echo "No program called "$1" found!"
	echo "Make sure it is installed"
fi
fi
