# WeizhongTu 2016-09-25
# just tested on CentOS 7

# Fedora Project EPEL(Extra Packages for Enterprise Linux)
# for detail:  http://fedoraproject.org/wiki/EPEL
sudo yum install epel-release -y
sudo yum install git -y

# common used packages from http://www.codeghar.com/blog/install-latest-python-on-centos-7.html
sudo yum install -y rpm-build
sudo yum install -y redhat-rpm-config
sudo yum install -y yum-utils
sudo yum groupinstall -y "Development Tools"

# common libs
sudo yum install readline-devel sqlite-devel bzip2-devel freetype-devel libpng-devel openjpeg-devel libxslt-devel libxml2-devel -y
sudo yum install cmake -y

# install zsh
sudo yum install zsh -y

# https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# change default shell
chsh -s /bin/zsh

# install python pip
sudo yum install python-pip -y

# pip.conf

# linux  : ~/.config/pip/pip.conf
# windows: $HOME/pip/pip.ini
# macOs  : ~/.pip/pip.conf
# more see: https://pip.pypa.io/en/stable/user_guide/#config-file

mkdir -p ~/.config/pip/

echo '''
[global]
timeout = 60
index-url = http://mirrors.aliyun.com/pypi/simple
#index-url = http://pypi.douban.com/simple

[install]
trusted-host = mirrors.aliyun.com
#trusted-host = pypi.douban.com
''' > ~/.config/pip/pip.conf

# upgrade pip
sudo pip install -U pip

# set pip auto complete
sudo pip completion --zsh >> .zshrc

# install virtualenv
sudo pip install -U virtualenvwrapper

# setup virtualenv
echo '''
# virtualenv
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/workspace
source /usr/bin/virtualenvwrapper.sh
#source /usr/local/bin/virtualenvwrapper.sh
''' >> ~/.zshrc

# change ZSH_THEME to gentoo
sed -i "s|ZSH_THEME=\".*\"|ZSH_THEME=\"gentoo\"|g" ~/.zshrc

# make it work in current context
source ~/.zshrc

#pip install bpython ipython, they are better than python default shell
sudo yum install bpython ipython -y


# vim
sudo yum install vim -y

git clone https://github.com/amix/vimrc.git ~/.vim_runtime
sh ~/.vim_runtime/install_awesome_vimrc.sh

# basic version
#git clone git://github.com/amix/vimrc.git ~/.vim_runtime
#sh ~/.vim_runtime/install_basic_vimrc.sh

# https://github.com/davidhalter/jedi-vim
# for python auto-complete
cd ~/.vim_runtime/sources_non_forked
git clone https://github.com/davidhalter/jedi-vim.git


echo '''
" set number
" http://vi.stackexchange.com/a/5
set number                     " Show current line number
"set relativenumber             " Show relative line numbers
''' >> ~/.vimrc


# install tmux
sudo yum install tmux -y

# too long, don't read!
sudo pip install tldr -y
# now you can use `tldr tmux` to see how to use tmux

