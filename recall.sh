#!/bin/bash
#
# '1') break;;
# '2') printline ; break;;
# '3') printline ; break;;
# '4') printline ; break;;


# not sure why, but test is broken or something, anyways if you plan on programming in shell get a very good understanding of the test command
# This super advanced function can judge how wide your terminal is so words don't get teleported in two when they are outputted
# The reason I think it is broken is because it is impossible for the if statement to work without the -ge part. I could not use == or >, I tried for like 6 hours to get that method to work.
function printline() {
    WIDTH=$(tput cols)
    PRINT=""
    for WORD in $1
    do
        if [ $(( ${#WORD} + ${#PRINT} )) -ge $WIDTH ]
        then
            echo $PRINT
            PRINT=""
        fi
        PRINT+="$WORD "
    done
    echo $PRINT
}

function main() {
    case $REPLY in
        '1')
            Directory='GoBack cd pwd ls mkdir grep locate find'
            select option in $Directory; do
                case $REPLY in
                    '1') break;;
                    '2') printline "cd is used to change directories, the usage is 'cd directory/' type 'cd ~' to go home and 'cd ..' to go back one directory."; break;;
                    '3') printline "prints your working directory."; break;;
                    '4') printline "ls lists files and directories, '-a' shows hidden files as well 'ls -alhps' can be used as a default."; break;;
                    '5') printline "creates a directory 'mkdir videos'."; break;;
                    '6') printline "grep filters through an output a command gives by using '|'. 'ls -alh | grep file.txt' or just 'ls -alh | grep .txt'"; break;;
                    '7') printline "locate searches for a file typing 'locate file' will automatically recursively search through your current directory and list everything that contains the word file, use in conjunction with grep for better results 'locate file | grep .txt'"; break;;
                    '8') printline "find by far has the best and most diverse features 'find -type f -name file.txt -size 0 -group ethien -user ethien' as you can see there are there are a lot of options, '-type f' means it is searching for files, use '-type d' to search for directories, '-group ethien' means it is searching for files that are owned by that group, and '-user ethien' means find is searching for files owned by the user ethien, you can use grep with this 'find -type f -name file | grep .txt'"; break;;
                esac
            done;;
        '2')
            File_Manipulation="GoBack cat touch cp mv rm chmod chown"
            select option in $File_Manipulation; do
                case $REPLY in
                    '1') break;;
                    '2') printline "touch creates a file 'touch file.txt'"; break;;
                    '3') printline "cp copies a file to a specified directory 'cp file.txt /home/files/' leaving the directory blank will put it in your current directory."; break;;
                    '4') printline "mv moves a file to a specified directory 'mv file.txt /home/files'."; break;;
                    '5') printline "rm removes a file 'rm file.txt', it also can remove a directory when all of the files are deleted from it 'rm DoNotDelete/ -R' use with caution."; break;;
                    '6') printline "cat is a command that prints the contents of a file"; break;;
                    '7') printline "chmod can be used to change permissions of a file the best method is this, 'chmod 762 file.txt'. It operates off of 3 sets of 3 bits execute=1, write=2, read=4. The placement is important the first describes owner privileges, the second your group's privileges, the third is all users' privileges. All digits must be filled in and make the permissions equal to what number is entered. 'chmod 001 file.txt' gives everyone execution privileges. Add the bits together to give multiple permissions to the owner, group, or all. 'chmod 000 file.txt' takes away everyone's permissions. 'chmod 777 file.txt' gives everyone all permissions."; break;;
                    '8') printline "chown changes the owner of a file 'chown ethien file.txt'."; break;;
                esac
            done;;
        '3')
            printline "Press ctrl+c to end a process, like this program. Press tab to autocomplete fi + [tab] = file.txt. Sudo can be used to give root privileges to any command. '.' can be used to refer to your active directory and '..' to the preceding current directory. '-r' or '-R' generally means to do recursively. When listing options just put one dash '-alhs'. You can direct information into a txt file with '>' this is a stream, use it like this 'echo 'hello' > file.txt' or with command that has an output. Type 'sudo bash' to login as the root user.";;
    esac
}

function reprint2 () {
    choice='Directories File_Manipulation Tips Info Users System_Info My_Website'
    select option in $choice; do
# $1 calls the function main
        $1
        return 2
    done
}

    if [ $1 == 'list' ]
    then
        echo "To advance just hit enter. Also every command listed has a whatis entry 'whatis cd' and a manual entry 'man cd'"
        while [ '1' == '1' ]
        do
            reprint2 main
        done
else
    echo "type 'recall list' to show available categories"
fi
