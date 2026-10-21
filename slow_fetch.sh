# slow git fetch
# https://unix.stackexchange.com/questions/235217/is-there-a-way-to-throttle-git-while-its-cloning-a-repo
trickle -sd 100 git fetch origin
