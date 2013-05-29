DOTRC=/Users/nv/.dotrc

#Nice Exports
export EDITOR="vim"
export SVN_EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
export EC2_PRIVATE_KEY=~/.ec2/access.pem
export EC2_CERT=~/.ec2/cert.pem
export PATH="$PATH:$HOME/scripts" # include home-grown tools

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
  # Let fluxbox grab gnome theme and change global keyboard bindings
  gnome-keyboard-properties &
  fbsetbg /media/w7/Users/nikos/Dbox/Dropbox/Photos/Wallpapers/aetherea.jpg
  # Named directories
  code=/media/w7/Projects
  safe=$code/UPenn/Research/SAFE
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
  code=/Users/nv/Projects
  safe=$code/UPenn/Research/SAFE
else  # Others, like eniac machines
  MANPAGER="less"
fi;

# Adding export for KLEE in order to run
# *.cde files only by invoking their name
# TODO: ADD a lib folder in programs
if [[ -d  "$HOME/Programs/klee-cde-package/bin/" ]]; then
  export PATH=$HOME/Programs/klee-cde-package/bin/:$PATH;
fi
