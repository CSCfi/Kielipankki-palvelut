# get and extract tar file
FILE=kielipankki_tools.tar.lz4
wget -P /tmp https://korp.csc.fi:/download/.mylly/$FILE
cat /tmp/$FILE | lz4 -d | tar xfv - -C /appl
