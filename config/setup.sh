# ******************************************************
#	Scripts for setup linux OS
#	 by Gunjae Koo (gunjae.koo@gmail.com)
# ******************************************************

# global variables
CONFIG_PATH=~/config

# functions
function confirm() {
	# call with a prompt string or use a default
	read -r -p "Will you install $1? [y/N] " response
	case $response in
		[yY][eE][sS]|[yY])
			true
			;;
		*)
			false
			;;
	esac
}

echo "***************************************************"
echo " bashrc"
confirm ".bashrc" && \
	rm -f ~/.bashrc && \
	ln -s ${CONFIG_PATH}/bash/.bashrc ~/.bashrc
echo ""

echo "***************************************************"
echo " Vim"
confirm "vim" && \
	sudo apt-get install vim ctags cscope && \
	rm -f ~/.vim && \
	rm -f ~/.vimrc && \
	ln -s ${CONFIG_PATH}/vim ~/.vim && \
	ln -s ${CONFIG_PATH}/vim/.vimrc ~/.vimrc
echo ""
