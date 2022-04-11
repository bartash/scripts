if [[ $# -ne 1 ]] ; then
    echo "usage: $0 xxx.bz2"
    exit 1
fi

XFILE=$1
if [[ ! -f $XFILE ]] ; then
    echo "cannot open $XFILE"
    exit 1
fi
echo "file is $XFILE"

echo "backup /opt/firefox to /opt/firefox.$$"
sudo mv /opt/firefox /opt/firefox.$$
sudo tar xjf $XFILE -C /opt/
sudo rm -f /usr/lib/firefox/firefox
sudo ln -s /opt/firefox/firefox /usr/lib/firefox/firefox