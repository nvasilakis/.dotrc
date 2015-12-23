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

# TODO: Make it distribution-specific
HOSTNAME=`hostname`
if [[ `uname` == 'Linux' ]]; then
  # OCaml
  . /home/$(whoami)/.opam/opam-init/init.zsh > /dev/null 2> /dev/null || true
  # emacs on Gnome
  alias emacs='XLIB_SKIP_ARGB_VISUALS=1 emacs'
else
  # Tempest
  alias tfail='terminal-notifier {} -title "Tempest"  -message "Compilation failed!" -sound "default"'
  alias tsuccess='terminal-notifier {} -title "Tempest"  -message "Compilation done!" -sound "default"'
  # Haskell
  export PATH="$PATH:/Users/$(whoami)/Library/Haskell/bin"
  export PATH="/usr/local/bin:$PATH"
  export PATH="$PATH:/Library/TeX/texbin/"
  # Golang
  # mkdir $HOME/go
  export GOPATH=$HOME/go
  export PATH="$PATH:$GOPATH/bin"
  # Java
  export JAVA_HOME="/Library/Java/JavaVirtualMachines/jdk1.8.0_60.jdk/Contents/Home"
fi

if [[ "$HOSTNAME" == 'harlie' || "$HOSTNAME" == icsaf* || "$HOSTNAME" == 'quark' ]] ; then
  export XILINX_DIR=/scratch/safe/usr/Xilinx_ISE_14.6 # S
  export VIVADO_DIR=/opt/Xilinx/Vivado_HLS/2012.2 # S
  export BLUESPECDIR=/scratch/safe/usr/Bluespec-2013.05.beta2/lib/ #S
  export PATH=$PATH:$XILINX_DIR/ISE_DS/ISE/bin/lin64:$XILINX_DIR/ISE_DS/PlanAhead/bin #S
  export PATH=$PATH:$BLUESPECDIR/bin:$JEDI:$CABALDIR #S
  export PATH=$PATH:$VIVADO_DIR/bin:$XILINX_BASE/ISE/bin/lin64 #S
  export LM_LICENSE_FILE="2100@potato.cis.upenn.edu:1709@potato.cis.upenn.edu:1717@potato.cis.upenn.edu:27010@potato.cis.upenn.edu:27009@potato.cis.upenn.edu" #S
  export LM_SYNPLIFY="1709@potato.cis.upenn.edu" #S
  LM_LICENSE_FILE=$LM_LICENSE_FILE:1717@potato.cis.upenn.edu:2100@potato.cis.upenn.edu:$LM_SYNPLIFY #S
  export SYNPLCTYD_LICENSE_FILE=$LM_SYNPLIFY #S
  alias synplify_pro="export LM_LICENSE_FILE=$LM_SYNPLIFY; synplify_pro" # S

  pushd . > /dev/null # S+
  #export SVNROOT=/tmp/crash # S+
  export SVNROOT=/home/$(whoami)/crash-harlie # S+
  cd $SVNROOT/isa/fpga/platform/host_interface/Lib #S
  . $SVNROOT/isa/fpga/platform/host_interface/Lib/ocpi_env_linux_x86_64.sh > /dev/null 2>&1 #S

  export LD_LIBRARY_PATH=$OCPI_BASE_DIR/lib/$OCPI_BUILD_HOST-bin:$OCPI_GTEST_DIR/lib:$LD_LIBRARY_PATH #S
  export FPGA_SLOT=`lspci -v|grep Xilinx|head -1|cut -d":" -f1` #S
  #export FPGA_SLOT="02" # Above command gives 3!
  #export FPGA_PCI_ADDRESS=`lspci -v|grep Xilinx|head -1|cut -d " " -f1` #S
  #export SWCTL_REGION_0=0x`setpci -s 0000:$FPGA_PCI_ADDRESS BASE_ADDRESS_0` #S
  #export SWCTL_REGION_1=0x`setpci -s 0000:$FPGA_PCI_ADDRESS BASE_ADDRESS_1` #S
  #export OCPI_DMA_MEMORY=512M\$0x5f700000 #S

  # Force GHC 7.6.3
  export PATH=/home/$(whoami)/.cabal/bin:$PATH
  export PATH=/home/$(whoami)/ghc/bin:$PATH

  popd > /dev/null #S+
  MORE_OUT="$MORE_OUT$(tput bold ; tput setaf 8)SVN  ROOT SET TO: $SVNROOT $(tput sgr0)\n"
  MORE_OUT="$MORE_OUT$(tput bold ; tput setaf 8)OCPI BASE SET TO: $OCPI_BASE_DIR $(tput sgr0)\n"
  MORE_OUT="$MORE_OUT$(tput bold ; tput setaf 8)GHC   VERSION IS: $(ghc --version) $(tput sgr0)\n"

# else  # Others, like eniac
#   MANPAGER="less"
#   #Less Colors for Man Pages
#   export LESS_TERMCAP_mb=$'\E[01;31m'       # begin blinking
#   export LESS_TERMCAP_md=$'\E[01;38;5;74m'  # begin bold
#   export LESS_TERMCAP_me=$'\E[0m'           # end mode
#   export LESS_TERMCAP_se=$'\E[0m'           # end standout-mode
#   export LESS_TERMCAP_so=$'\E[38;5;246m'    # begin standout-mode - info box
#   export LESS_TERMCAP_ue=$'\E[0m'           # end underline
#   export LESS_TERMCAP_us=$'\E[04;38;5;146m' # begin underline
fi;

lab=$HOME/lab

# Safe
safe=$lab/SAFE
nets=$lab/safe-nets/users/nvas/

# Andromeda
m31=$lab/andromeda
alias m31=$m31/m31/src/shell.js

# DCP
dcp=$lab/dcp
alias lh="http://localhost:8000/"
l="http://localhost:8000/"
