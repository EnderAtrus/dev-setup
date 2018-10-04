#!/bin/bash

yell() { echo -e "$0: $*" >&2; }
die() { yell "$*"; exit 111; }
try() { "$@" || die "cannot $*"; }

# Enable exit on error
set -e

# Define text colors for echo -e output *_l = light variation, *_d = dark variation
red = '\033[0;31m'
red_l = '\033[1;31m'
brown_orange = '\033[0;33m'
yellow = '\033[1;33m'
green = '\033[0;32m'
green_l = '\033[1;32m'
cyan = '\033[0;36m'
cyan_l = '\033[1;36m'
blue = '\033[0;34m'
blue_l = '\033[1;34m'
purple = '\033[0;35m'
purple_l = '\033[1;35m'
black = '\033[0;30m'
gray_l = '\033[0;37m'
gray_d = '\033[1;30m'
white = '\033[1;37m'
no_color = '\033[0m'

# Announce the Running of the script
yell
echo -e "${green}Welcome to Seth's Terminal Development Envrionment Setup Script${no_color}"
echo -e "${cyan}Feel free to opt out of any feature/tool that you want${no_color}"
echo -e "${cyan}Although I recommend each one :)${no_color}"
echo -e "${yellow}NOTE: This requires a working internet connection${no_color}"

# Get Homebrew
echo -e -n "Do you want Homebrew? (y/n)"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  echo -e "Getting Homebrew:"
  /usr/bin/ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
else
  echo -e "${red}Skipping Homebrew!${no_color}"
fi

# Get iTerm2
echo -e -n "Do you want iTerm2? ${yellow}[Requires Homebrew] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  echo -e "Getting iTerm2:"
  brew cask install iterm2
else
  echo -e "${red}Skipping iTerm2!${no_color}"
fi

# Get Zsh
echo -e -n "Do you want Zsh? [Requires Homebrew] (y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  echo -e "Getting zsh:"
  brew install zsh zsh-completions

  # Set Zsh as Default
  chsh -s $(which zsh)
  if [$SHELL =~ *zsh] ;
  then
    # nothing
    echo ""
  else
  echo -e "${yellow}NOTE: You may have to verify Zsh is default shell."
  echo -e "You may be able to fix with 'chsh -s $(which zsh)' ${no_color}"
else
  echo -e "${red}Skipping Zsh!${no_color}"
fi

echo -e -n "Do you want Oh-My Zsh? ${yellow}[Requires Zsh] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Get Oh-My-Zsh
  echo -e "Getting oh-my-zsh:"
  sh -c "$(curl -fsFL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo -e "${red}Skipping oh-my-zsh!${no_color}"
fi

echo -e -n "Do you want zsh-syntax-highlighting? ${yellow}[Requires zsh, Homebrew] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Get zsh-syntax-highlighting
  echo -e "Getting zsh-syntax-highlighting:"
  brew install zsh-syntanx-highlighting
else
  echo -e "${red}Skipping zsh-syntax-highlighting!${no_color}"
fi

echo -e -n "Do you want Nerd Fonts? ${yellow}[Requires Homebrew] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Get nerd fonts
  echo -e "Getting Nerd Fonts:"
  brew tap caskroom/fonts
  brew cask install font-spacemono-nerd-font
  brew cask install font-spacemono-nerd-font-mono
  echo -e "${yellow}NOTE: You may have to select a nerd font in iTerm2 preferences"
  echo -e "Look for font-spacemono-nerdfont ${no_color}"
else
  echo -e "${red}Skipping Nerd Fonts!${no_color}"
fi


echo -e -n "Do you want the Powerlevel 9k Zsh theme? ${yellow}[Requires Zsh, git, nerd font] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Get Powerlevel9k
  echo -e "Getting Powerlevel9k:"
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
  echo -e "POWERLEVEL9K_MODE='nerdfont-complete'" >> ~./zshrc
  echo -e 'ZSH_THEME="powerlevel9k/powerlevel9k" ' >> ~/.zshrc
  echo -e "POWERLEVEL9K_PROMPT_ADD_NEWLINE=true" >> ~/.zshrc
  echo -e "POWERLEVEL9K_PROMPT_ON_NEWLINE=true" >> ~/.zshrc
  echo -e "POWERLEVEL9K_RPROMPT_ON_NEWLINE=true" >> ~/.zshrc
else
  echo -e "${red}Skipping Powerlevel9k!${no_color}"
fi

echo -e -n "Do you want Ruby? ${yellow}[Requires Homebrew]${no_color} (y/n):" ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Get Ruby
  echo -e "Getting Ruby:"
  brew install ruby
else
  echo -e "${red}Skipping Ruby!${no_color}"
fi

echo -e -n "Do you want ColorLS? ${yellow}[Requires Ruby, Zsh] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Get colorls
  echo -e "Getting ColorLS:"
  sudo gem install colorls
  echo "#------------------------------------------" >> ~/.zshrc
  echo "# These were added via the setup script" >> ~/.zshrc
  echo "alias lc='colorls --tree' " >> ~/.zshrc
  echo "alias ls='colorls --sort-dirs' " >> ~/.zshrc
  echo "alias l='colorls -l' " >> ~/.zshrc
  echo "alias ll='colorls -la' " >> ~/.zshrc
else
  echo -e "${red}Skipping ColorLS!${no_color}"
fi

echo -3 -n "Do you want wget? ${yellow}[Requires Homebrew] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Get wget
  echo -e "Getting wget:"
  brew install wget
else
  echo -e "${red}Skipping wget!${no_color}"
fi

echo -e -n "Do you want tmux? ${yellow}[Requires Homebrew] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Install tmux
  echo -e "Getting tmux:"
  brew install tmux
  echo "#------------------------------------------" >> ~/.zshrc
  echo "# These were added via the setup script" >> ~/.zshrc
  echo "alias tls='tmux ls' " >> ~/.zshrc
  echo "alias n='tmux new -s' " >> ~/.zshrc
else
  echo -e "${red}Skipping tmux!${no_color}"
fi

echo -e -n "Do you want oh-my-tmux? ${yellow}[Requires tmux, git] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Install oh-my-tmux
  echo -e "Getting oh-my-tmux:"
  cd
  git clone https://github.com/gpakosz/.tmux.git
  ln -s -f .tmux/.tmux.conf
  cp .tmux/.tmux.conf.local .
else
  echo -e "${red}Skipping oh-my-tmux!${no_color}"
fi

echo -e -n "Do you want Tmuxinator? ${yellow}[Requires tmux, Ruby, wget] ${no_color}(y/n):"
read ans
if [ans = 'y' || ans = 'yes'] ;
then
  # Install tmuxinator
  echo -e "Getting Tmuxinator:"
  gem install tmuxinator

  echo -e "Setting Tmuxinator Completion file"
  mkdir ~/tempo
  cd ~/tempo
  wget https://github.com/tmuxinator/tmuxinator/blob/master/completion/tmuxinator.zsh
  mv ~/tempo/tmuxinator.zsh ~/
  rm -rf ~/tempo
  echo -e "source ~/tmuxinator.zsh" >> ~/.zshrc
  if [-z $EDITOR];
  then
    echo -e "${yellow} NOTE: Tmuxinator requires a default text editor be set;"
    echo -e" You have the option of the script setting one later on ${no_color}"
  fi
else
  echo -e "${red}Skipping Tmuxinator!${no_color}"
fi

read -p "Do you want VIM set as default terminal text editor? (y/n):" ans
if [ans ='y' || ans= 'yes'] ;
then
  echo -e "export EDITOR='vim' " >> ~/.zshrc
else
  echo -e "${red}NOT setting VIM as default${no_color}"
fi

echo -e -n "Do you want short aliases for exiting and clearing? ${yellow}[Requires Zsh] ${no_color}(y/n):"
read ans
if [ans ='y' || ans= 'yes'] ;
then
  # Add alias to .zshrc
  echo "#------------------------------------------" >> ~/.zshrc
  echo "# These were added via the setup script" >> ~/.zshrc
  echo "alias c='clear' " >> ~/.zshrc
  echo "alias e='exit' " >> ~/.zshrc
else
  echo -e "${red}NOT creating aliases!${no_color}"
fi


echo -e "${green}Done, enjoy the new terminal environment!${no_color}"
