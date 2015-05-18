#!/bin/bash

echo "currently in directory $PWD"
help="[-a ] for appengine [-t] for tornado"

PS3="select the platform no from above: "


appengine(){
   #creating a directory structure
   mkdir "$PWD/$1"
   mkdir "$PWD/$1/app"
   mkdir "$PWD/$1/app/Static"
   mkdir "$PWD/$1/app/View"
   touch "$PWD/$1/README.md"
   touch "$PWD/$1/app/app.yaml"
   touch "$PWD/$1/app/app.py"
   wget -P "$PWD/$1/app/" https://github.com/plasmashadow/Appengine-Generics/archive/master.zip   
   unzip "$PWD/$1/app/master.zip" -d "$PWD/$1/app/"
   mv "$PWD/$1/app/Appengine-Generics-master/" "$PWD/$1/app/Generics/"
   rm "$PWD/$1/app/Generics/.gitignore"
   rm "$PWD/$1/app/Generics/README.md"
   rm "$PWD/$1/app/master.zip"
}


tornado(){
	#need to update tornado generics
	sudo pip install tornado
	mkdir "$PWD/$1"
	mkdir "$PWD/$1/server"
	mkdir "$PWD/$1/server/static"
	mkdir "$PWD/$1/server/templates"
    touch "$PWD/$1/README.md"
    cd  "$PWD/$1/server" && wget https://www.dropbox.com/s/etux2s86m6msry4/main.py?dl=0 -O main.py
}


pipy(){
	echo "$1"
	mkdir "$PWD/$1"
	mkdir "$PWD/$1/$1"
	touch "$PWD/$1/$1/__init__.py"
	mkdir "$PWD/$1/tests/"
	mkdir "$PWD/$1/doc/"
	mkdir "$PWD/$1/setup.py"
	mkdir "$PWD/$1/README.md"
	mkdir "$PWD/$1/.travis.yml"
	exit
}

select platform in appengine tornado pypi exit
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
	if [ $platform == pypi ]
	then
	    pipy $1
	    exit;
	fi
done
