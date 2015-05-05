#!/bin/bash

echo "currently in directory $PWD"
help="[-a ] for appengine [-t] for tornado"

PS3="select the platform no from above: "


appengine(){
   #creating a directory structure
   mkdir "$PWD/app"
   mkdir "$PWD/app/Static"
   mkdir "$PWD/app/View"
   touch "$PWD/README.md"
   touch "$PWD/app/app.yaml"
   touch "$PWD/app/app.py"
   wget -P "$PWD/app/" https://github.com/plasmashadow/Appengine-Generics/archive/master.zip   
   unzip "$PWD/app/master.zip" -d "$PWD/app/"
   mv "$PWD/app/Appengine-Generics-master/" "$PWD/app/Generics/"
   rm "$PWD/app/Generics/.gitignore"
   rm "$PWD/app/Generics/README.md"
   rm "$PWD/app/master.zip"
}


tornado(){
	#need to update tornado generics
	sudo pip install tornado
	mkdir "$PWD/server"
	mkdir "$PWD/server/static"
	mkdir "$PWD/server/templates"
    touch "$PWD/README.md"
    touch "$PWD/server/main.py"
}

select platform in appengine tornado
do
	if [ $platform == appengine ]
	then 
		appengine
		exit
	fi
	if [ $platform == tornado ]
	then
	    tornado
	    exit
	fi
	if [ $platform == exit ]
	then
	    exit;
	fi
done
