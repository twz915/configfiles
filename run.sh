# WeizhongTu 2016-09-25
# just tested on CentOS 7

# install zsh
yum makecache && yum install zsh -y

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
yum install bpython ipython
