#!/bin/bash

srclist2paths () {
    srclist=$1
    base_path="`dirname ${srclist} | xargs dirname`"
    #echo "list ${srclist}"
    #echo "src base $base_path"
    for srcfile in `cat $srclist`; do
        #echo "file ${srcfile}"
        if [[ "`basename ${srcfile}`" =~ ".srclist" ]] ; then
            srclist2paths "${base_path}/${srcfile}"
            #list="${list} $retval"
        else 
            if [[ ! "${list}" =~ "${base_path}/${srcfile}" ]] ; then
                #echo "Skeeping ${base_path}/${srcfile} already included in file list!"
            #else
                list="${list} ${base_path}/${srcfile}"
            fi
        fi    
    done
    #echo "final list ${list}"
    #retval=${list}
}

list=""
srclist2paths $@
echo ${list}