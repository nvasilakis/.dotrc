#TODO: These should already be in the base, but not global
alias -g prj='/media/w7/Projects/'
alias -g cv='/media/w7/Projects/cv/'
# not sure if I need these
alias -g mam='nv@150.140.90.86' 
alias -g etp='etp@150.140.91.13'
alias -g is='root@vasilak.is'
alias -g diogenis='basilakn@diogenis.ceid.upatras.gr'
alias -g zenon='basilakn@zenon.ceid.upatras.gr'

# I shoud add functionality for go seas, ceid, rdesktop
# if [[ $n -eq 'seas']]; then echo "ssh seas.." fi;
# implement go
alias go='dirs -v ; echo -n "..>" ; read n ; cd ~$n'

# Should be made global
alias -g dbox="/media/w7/Documents\ and\ Settings/nikos/Dbox/Dropbox/"

# Suffix aliases -- maybe write an open function a la OS X?
alias -s xlx=libreoffice
alias -s xls=libreoffice
alias -s doc=libreoffice
alias -s docx=libreoffice
alias -s tex=vim
alias -s pdf=evince
alias -s html=w3m
alias -s org=w3m