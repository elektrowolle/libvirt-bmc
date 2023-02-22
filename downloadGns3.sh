declare CACHE=./cache
declare VERSION=2.2.37
declare FILENAME=GNS3.VM.KVM.$VERSION.zip
declare URL=https://github.com/GNS3/gns3-gui/releases/download/v$VERSION/$FILENAME
#Download if not yet downloaded
if [[ ! -s "$CACHE/$FILENAME" ]]; then
    wget -O $CACHE/$FILENAME $URL
fi
echo "Currently downloaded:"
ls -anh $CACHE/$FILENAME

unzip -o -d $CACHE $CACHE/$FILENAME
