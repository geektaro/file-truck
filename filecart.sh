#!/bin/bash
source $(dirname $0)/filecart.cnf
if [ $# -eq 0 ]; then
    echo "No map file."
    exit 1
fi

while IFS=" " read remote_ip remote_dir; do
    DATE=`date +'%Y%m%d'`
    cmd="cd ${remote_dir}; tar -zcf bak.${DATE}.tar.gz ${FILE};"
    ssh -n -i $KEY ${USER}@${remote_ip} $cmd
    files=`for f in $FILE; do echo "${DIR}${f} "; done;`
    rsync -e "ssh -i ${KEY}" ${files} ${USER}@${remote_ip}:$remote_dir
done < $1
