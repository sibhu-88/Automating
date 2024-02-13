#!/bin/bash
echo -e "Please provide C filename you want to create : \c"
read -r file
touch $file.c
echo '#!/bin/bash' > $file.c
echo '#purpose : ' >> $file.c
echo '#created Date : ' `date` >> $file.c
echo '#Coder : Prabhu' >> $file.c
echo '#START # ' >> $file.c
echo '#include<stdio.h>' >> $file.c
echo '' >> $file.c
echo 'int main()' >> $file.c
echo '{' >> $file.c
echo '' >> $file.c
echo '' >> $file.c
echo '}' >> $file.c
echo '#END # ' >> $file.c
