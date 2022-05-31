
# 
`rsync -Pav -e "ssh -i $HOME/.ssh/somekey" username@hostname:/from/dir/ /to/dir/`

##### -P shows progress
##### -a archive - save permissions
##### -v verbose
##### -e Specify remote shell to use
