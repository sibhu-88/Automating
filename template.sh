#!/bin/bash

# Function to check if a file already exists
file_exists() {
    if [ -e "$1" ]; then
        echo "Error: File '$1' already exists."
        exit 1
    fi
}

# Prompt user for file type
echo -e "Which filename do you want to create? Enter 1 for C or 2 for C++: \c"
read -r op

# Check user input and create file accordingly
if [[ $op == 1 ]]; then
    # Create C file
    echo -e "Please provide the C filename you want to create: \c"
    read -r file
    file_exists $file.c
    touch $file.c
    {
        echo '//#purpose : '
        echo '//#created Date : ' "$(date '+%d-%m-%Y')"
        echo '//#Coder : SIBHU'
        echo '//#######--------START------########## '
        echo ''
        echo '#include<stdio.h>'
        echo ''
        echo 'int main() {'
        echo ''
        echo '}'
        echo ''
        echo '//#####---------END-------######### '
    } >> $file.c
    open_file=$file.c
else
    # Create C++ file
    echo -e "Please provide the C++ filename you want to create: \c"
    read -r file
    file_exists $file.cpp
    touch $file.cpp
    {
        echo '//#purpose : '
        echo '//#created Date : ' "$(date '+%d-%m-%Y')"
        echo '//#Coder : SIBHU'
        echo '//#######--------START------##########'
        echo ''
        echo '#include<iostream>'
        echo 'using namespace std;'
        echo ''
        echo 'int main() {'
        echo ''
        echo '}'
        echo ''
        echo '//#####---------END-------######### '
    } >> $file.cpp
    open_file=$file.cpp
fi

# Open the file in the nano editor
nano $open_file

#chmod 777 template
#sudo mv template /bin/
