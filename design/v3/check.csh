#!/bin/tcsh
set i = $1
while ( $i <= $2)
    set file1_name = ./mem_files/mem_test${i}.txt
    set file2_name = ./mem_files/mem_test${i}_result.txt
    tkdiff $file1_name $file2_name
    @ i++
end