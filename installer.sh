#!/bin/bash
#******************************
#	Created By Md. Saifur Rahman
#	Knock me md.saifurrahmann029@gmail.com or saifur@saifur.xyz
#******************************

echo "Welcome to Saifur's tech library!"
echo "Bangla fonts download and Installation Proccess Initiated!"
echo "-----------------------------------------------------------------"

# Var
targetUrl=("http://lib.saifur.ml/fonts/bFonts.tar.gz" "https://raw.githubusercontent.com/mdsaifurrahmann/Linux-Bangla-Font-Installer/master/lib/bFonts.tar.gz")
targeted=""
# it will choose the most leastimal server

clause=()
conClause=()
utmost=()
# Get the latancy and urls of arrays.

for i in ${targetUrl[@]};do 
  getSetUrl=$(echo $i | sed 's|http://||g' | sed 's|https://||g' | cut -d '/' -f -1)
  pingUrl=$(ping -c 5 "$getSetUrl" | tail -1 | awk '{print $4}' | cut -d '/' -f 2)
  chosen=${pingUrl%.*}
  clause+=("$chosen")
  conClause+=("$chosen,$getSetUrl")
  utmost+=("$chosen,$i")
done

# Latency
most=${clause[0]}
least=${clause[0]}
echo "Minimum Latancy: "$least "ms"
echo -e "\n"

# Loop through all elements in the array
for i in "${utmost[@]}"
do
    mOrL=$(echo $i | cut -d ',' -f 1)
    # Update most if applicable
    if [[ "$mOrL" -gt "$most" ]]; then
        most="$i"
    fi

    # Update least if applicable
    if [[ "$mOrL" -lt "$least" ]]; then
        least="$i"
    fi
done
targeted=$(echo $least | cut -d ',' -f 2)


if [ $USER = "root" ]; then
  fDir="/root/.fonts/bFonts"
fi
if [ $USER != "root" ]; then
  fDir="/home/$USER/.fonts/bFonts"
fi

if [ ! -d "$fDir" ]; then
  mkdir -p $fDir
else
  echo -e "Reading Bangla fonts library!\n";
  rm -r $fDir;
fi

echo -e "Font archive downloading from the library!\n"
echo -e "From:" $targeted
wget -v -P $fDir"/" $targeted

cd $fDir"/"
tar -zxvf bFonts.tar.gz
rm bFonts.tar.gz

cd
echo -e "\n"
echo "Fonts refreshment step initiated!"
echo -e "\n"
fc-cache -f -v

echo "------------------------------------"
echo "All processes are finised! Consider to restart your device!"
echo -e "Thanks Mr./Mrs." $USER "to execute me! \n"
echo -e "---Md. Saifur Rahman"
echo -e "Website: http://saifur.xyz\n"