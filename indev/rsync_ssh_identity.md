
# 
`rsync -Pav -e "ssh -i $HOME/.ssh/somekey" username@hostname:/from/dir/ /to/dir/`

`rsync -Pav /from/dir/ -e "ssh -i $HOME/.ssh/somekey" username@hostname:/to/dir/`

##### -P shows progress
##### -a archive - save permissions
##### -v verbose
##### -e Specify remote shell to use
