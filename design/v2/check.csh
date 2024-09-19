#!/bin/tcsh
set i = 0
while ( $i < 40)
    set file1_name = ./mem_files/mem_test${i}.txt
    set file2_name = ./mem_files/mem_test${i}_result.txt
    tkdiff $file1_name $file2_name
    @ i++
end