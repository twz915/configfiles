# WeizhongTu 2016-09-25
# just tested on CentOS 7

# https://github.com/robbyrussell/oh-my-zsh
sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"

# change default shell
chsh -s /bin/zsh

# install python pip
sudo yum install python-pip -y

# cp pip.conf
mkdir -p ~/.config/pip/
cp pip.conf ~/.config/pip/

# upgrade pip
sudo pip install -U pip

# set pip auto complete
sudo pip completion --zsh >> .zshrc

# install virtualenv
sudo pip instal -U virtualenvwrapper

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
yum install bpython ipython
