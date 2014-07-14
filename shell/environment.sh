DOTRC=~/.dotrc

#Nice Exports
export EDITOR="vim"
export SVN_EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
export EC2_PRIVATE_KEY=~/.ec2/access.pem
export EC2_CERT=~/.ec2/cert.pem
export PATH="$PATH:$HOME/scripts" # include home-grown tools
export LACONIC="false"
UNIVERSE=$(echo "~/.dotrc ~/.vimrc ~/scripts ~/.emacs.d" | sed "s;~;$HOME;g")

## My own man page viewer. If I need to remap K, add also:
#-c 'nmap K :Man <C-R>=expand(\\\"<cword>\\\")<CR><CR>' -\"\
## or
#export PAGER="/bin/sh -c \"unset PAGER;col -b -x | \
#    vim -R -c 'set ft=man nomod modified nonumber nolist autoread' -c 'map q :q<CR>' \
#    -c 'map <SPACE> <C-D>' -c 'map b <C-U>' -\" \
export MANPAGER="/bin/sh -c \"unset PAGER;col -b -x | \
  vim -R -c 'set ft=man nomod nonumber nolist' -c 'noremap q ZQ' \
  -c 'map <SPACE> <C-D>' -\" \
  "

HOSTNAME=`hostname`
if [[ "$HOSTNAME" == 'nv' ]]; then # fluxbox home
  export JDK_HOME="/usr/lib/jvm/jdk1.6.0_26/";
  export HADOOP_HOME=/usr/local/hadoop
  export CDPATH="/media/w7/Projects/"
  export PATH="/home/nikos/.cabal/bin:$PATH"
  # Named directories
  code=/media/w7/Projects/UPenn
  safe=$code/UPenn/Research/CRASH/safe
  # Run only once
  if [[ "$ONCE" != "true" ]]; then
    # Let fluxbox grab gnome theme and change global keyboard bindings
    gnome-settings-daemon
    # Set desktop background
    fbsetbg /media/w7/Users/nikos/Dbox/Dropbox/Photos/Wallpapers/aetherea.jpg
    # Configure wifi
    nm-applet 
    ONCE="true"
  fi
# Nice Exports
elif [[ "$HOSTNAME" == 'cis555-vm' ]] ; then # virtual machine
  export PATH=$PATH:/home/cis555/555/.tools
  export JAVA_HOME=/usr/lib/jvm/java-6-openjdk
#  xrandr --newmode "1920x1080" 172.80 1920 2040 2248 2576 1080 1081 1084 1118
#  xrandr --addmode VBOX0 "1920x1080"
#  # xrandr -s 1920x1080
#  # fbsetbg ~/Downloads/1680x1050.jpg
#  # vim .inputrc
#  # mv X.defaults .Xdefaults
#  # vim .Xdefaults
#   xrandr --newmode "1280x800@60" 83.46 1280 1344 1480 1680 800 801 804 828
#   xrandr --addmode VBOX0 "1280x800@60"
#   xrandr -s 1280x800@60
  set meta-flag on
  set convert-meta off
  set output-meta on
  xrdb -load ~/.Xdefaults
elif [[ "$HOSTNAME" == 'ape' ]] ; then # mac book air
  export PATH="$PATH:/usr/local/bin" # homebrew
  code="/Users/nv/Projects/UPenn"
  safe=$code/Research/CRASH
  nets=$code/Research/safe-nets
  lab="$code/Research/"
  cv="/Users/nv/Projects/my/cv"
  sf="$code/500/software-foundations/"
  rosa="/Users/nv/Projects/my/rosalind"
elif [[ "$HOSTNAME" == 'squirrel' ]] ; then # mac book air, linux
  code=/home/nikos/Documents
  lab=/home/nikos/Documents
  safe="/home/nikos/Projects/crash/"
  alias m31="cd ~lab/universe"
  export URBIT_HOME=/home/nikos/Documents/urbit/urb
elif [[ "$HOSTNAME" == 'giraffe' ]] ; then # penn machine
  . /home/nikos/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  penn=/home/nikos/Projects/UPenn/
  my=/home/nikos/my
  rosa=$my/rosalind
  sf=$penn/500/software-foundations/
  lab=$penn/Research
  safe=$lab/CRASH/safe
  nets=$lab/CRASH/safe-nets/users/nvas/nets
  isca=$lab/ISCA
  gem5=$isca/gem5
  alias seas='ssh nvas@eniac.seas.upenn.edu -X "google-chrome"'
  PATH=$PATH:$HOME/.rvm/bin # Add RVM to PATH for scripting
  export URBIT_HOME=/home/nikos/Documents/urbit/urb
elif [[ "$HOSTNAME" == 'quark' ]] ; then # penn machine
  export PATH=$PATH:/scratch/safe/usr/Bluespec-2013.05.beta2/lib/bin
  export CHICKEN_BUILD=/home/nvas/chicken-4.9.0.1/
  export PATH=$PATH:/home/nvas/chicken-4.9.0.1/build/bin
  export XILINX_DIR=/scratch/safe/usr/Xilinx_ISE_14.6
  export PATH=$PATH:$XILINX_DIR/ISE_DS/ISE/bin/lin64
elif [[ "$HOSTNAME" == 'harlie' ]] ; then # penn machine
  source /home/nvas/safe/isa/fpga/platform/host_interface/Lib/ocpi_env_linux_x86_64.sh > /dev/null 2>&1
  export PATH=$PATH:/scratch/safe/usr/Bluespec-2013.05.beta2/lib/bin
  export OCPI_BASE_DIR=~/safe/isa/fpga/platform/host_interface/ocpi_bit
  export PATH=/home/nvas/.cabal/bin:$PATH
  export PATH=/home/nvas/ghc/bin:$PATH
  export CHICKEN_BUILD=/home/nvas/chicken-4.9.0.1/
  export PATH=$PATH:/home/nvas/chicken-4.9.0.1/build/bin
  export XILINX_DIR=/scratch/safe/usr/Xilinx_ISE_14.6
  export PATH=$PATH:$XILINX_DIR/ISE_DS/ISE/bin/lin64
  export FPGA_SLOT="02"
  #export LM_LICENSE_FILE=$LM_LICENSE_FILE:1717@potato.cis.upenn.edu:2100@potato.cis.upenn.edu
  export BLUESPECDIR=/scratch/safe/usr/Bluespec-2013.05.beta2/lib/
  export LM_LICENSE_FILE="2100@potato.cis.upenn.edu:1709@potato.cis.upenn.edu:1717@potato.cis.upenn.edu:27010@potato.cis.upenn.edu:27009@potato.cis.upenn.edu"
else  # Others, like eniac machines
  MANPAGER="less"
  #Less Colors for Man Pages
  export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
  export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
  export LESS_TERMCAP_me=$'\E[0m'           # end mode
  export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
  export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
  export LESS_TERMCAP_ue=$'\E[0m'           # end underline
  export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
  isca=/scratch/safe/nvas/isca/testcases
fi;

# Adding export for KLEE in order to run
# *.cde files only by invoking their name
# TODO: ADD a lib folder in programs
if [[ -d  "$HOME/Programs/klee-cde-package/bin/" ]]; then
  export PATH=$HOME/Programs/klee-cde-package/bin/:$PATH;
fi
