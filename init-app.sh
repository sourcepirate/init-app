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
touch "$PWD/$1/tests/__init__.py"
mkdir "$PWD/$1/doc/"
touch "$PWD/$1/setup.py"
touch "$PWD/$1/README.md"
touch "$PWD/$1/.travis.yml"
echo ".idea" >> "$PWD/$1/.gitignore"
echo "*.pyc" >> "$PWD/$1/.gitignore"
cat > $PWD/$1/.travis.yml <<END_TRAVIS
language: python
python:
  - '2.6'
  - '2.7'
  - '3.2'
install:
  - pip install six
script: nosetests
END_TRAVIS
cat > $PWD/$1/setup.py <<END_SETUPPY
from setuptools import setup
import os


def readme():
    return open(os.path.join(os.path.dirname(__file__), 'README.md'), 'r').read()

setup(name='$1',
      packages=['$1'],
      version='0.0.5',
      description='',
      long_description=Readme(),
      author='plasmashadow',
      author_email='plasmashadowx@gmail.com',
      url='https://github.com/plasmashadow/pytorrent.git',
      classifiers=['Programming Language :: Python',
      'Programming Language :: Python :: 2',
      'Intended Audience :: Developers'],
      install_requires=['six'],
      include_package_data=True,
      license='BSD License')
 END_SETUPPY
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
