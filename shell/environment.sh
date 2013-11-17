DOTRC=~/.dotrc

#Nice Exports
export EDITOR="vim"
export SVN_EDITOR="vim"
export PYTHONSTARTUP=~/.pythonrc
export EC2_PRIVATE_KEY=~/.ec2/access.pem
export EC2_CERT=~/.ec2/cert.pem
export PATH="$PATH:$HOME/scripts" # include home-grown tools
export LACONIC="false"

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
  safe=$code/UPenn/Research/SAFE
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
  code="/Users/nv/Projects/UPenn"
  safe=$code/Research/SAFE
  cv=/Users/nv/Projects/my/cv
  sf="$code/500/software-foundations/"
  rosa=/Users/nv/Projects/my/rosalind
elif [[ "$HOSTNAME" == 'antikythera' ]] ; then # mac book air
  penn=/home/nikos/Projects/UPenn/
  my=/home/nikos/my
  rosa=$my/rosalind
  sf=$penn/500/software-foundations/
  lab=$penn/Research
  safe=$lab/SAFE
  isca=$lab/ISCA
  gem5=$isca/gem5
  alias seas='ssh nvas@eniac.seas.upenn.edu -X "google-chrome"'
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
