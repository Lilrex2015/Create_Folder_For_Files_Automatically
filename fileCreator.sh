

#Prompt the user for the directory
# look in the folder
#find all files not in folders
#Get the file name without the extension
#create a folder with that name
#Cut and paste the file into the folder


read -p "Enter the directory please: " folderPath


#check to see if the provided input is a folder or not

if [ -d "$folderPath" ] ; then
    cd "$folderPath"


    #loop over all the directory contents and create the folders

    for item in *; do
        if [ -f "$item" ]; then
            
            #split the file name and retain the stuff to the left

            IFS='.' read -r base_name _ <<< "$item"

         
        fi

        #check if the folder exists with the file name already

        if [ ! -d "$base_name" ]; then
            mkdir "$base_name"
        fi

        #move the file into the directory

        mv "$item" "$base_name/"

    done

else
    echo "The path you provided is not a directory"
fi