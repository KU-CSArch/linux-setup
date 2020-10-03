#!/bin/bash
# *****************************************
#  A script for configuring Linux
#	by Gunjae Koo (gunjae.koo@gmail.com)
# *****************************************

OS="Linux Mint 17.3"
GIT_NAME="Gunjae Koo"
GIT_EMAIL="gunjae.koo@gmail.com"
ITEM=""

###############################
## Functions 
###############################
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
echo " Script for setting up ${OS}"
echo "	Designed by Gunjae Koo (gunjae.koo@gmail.com)"
echo "	(NO WARRANTY, EXECUTE AT YOUR OWN RISKS)"
echo "***************************************************"

echo "***************************************************"
echo " git and subversion"
sudo apt-get install git subversion curl
git config --global user.name "${GIT_NAME} (@$HOSTNAME)"
git config --global user.email "${GIT_EMAIL}"
git config --global core.editor "vi"
echo "You can find git golbal configuration file ~/.gitconfig"
echo ""

echo "***************************************************"
echo " making some folders"
confirm "making bin folder" && mkdir ~/bin
confirm "making workspace folder" && mkdir ~/workspace
confirm "making cloud folder" && mkdir ~/cloud
confirm "making mount folder" && mkdir ~/mount
confirm "adding sshusers group" && sudo addgroup --gid 901 sshusers

echo "***************************************************"
confirm "making config folder (required for setting up bash and vim)" && \
	ln -s $PWD/config ~/config
	#(cd && git clone https://gitlab.com/gunjae/linux-config.git) && \
	#(cd && mv linux-config config)
echo ""

echo "***************************************************"
echo " Replace .bashrc"
confirm ".bashrc" && \
	#(cd ~/config && git clone https://gunjae@bitbucket.org/gunjae/config_bash.git) && \
	#(cd ~/config && mv config_bash bash) && \
	rm -f ~/.bashrc && \
	ln -s ~/config/bash/.bashrc ~/.bashrc
echo ""

echo "***************************************************"
echo " Configuring VIM"
confirm "vim" && \
	sudo apt install vim ctags cscope fonts-powerline && \
	#(cd ~/config && git clone git@github.com:gunjae/config_vim.git) && \
	#(cd ~/config && mv config_vim vim) && \
	rm -f ~/.vim && \
	rm -f ~/.vimrc && \
	ln -s ~/config/vim ~/.vim && \
	ln -s ~/config/vim/.vimrc ~/.vimrc && \
	curl -fLo ~/.vim/autoload/plug.vim --create-dirs https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	#git submodule init && git submodule update
	#git clone https://github.com/gmarik/Vundle.vim.git ~/.vim/bundle/Vundle.vim
echo ""

echo " End of setup..."
