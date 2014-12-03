
changePythonVersion()
{
	if [ "$1" == "" ]; then
		echo "give me the version"
		return
	fi

	python --version
	echo "then link to " $1
	ver=""
	if [ "$1" != "2.7" ]; then
		ver=$1
		# echo "not 2.7"
	fi


	# echo "version is " $ver
	# remove the old folder shorcut
	sudo rm /System/Library/Frameworks/Python.framework/Versions/Current

	# link to the new folder shorcut
	sudo ln -s /System/Library/Frameworks/Python.framework/Versions/$1 /System/Library/Frameworks/Python.framework/Versions/Current
	
	# remove old bin shorcut
	sudo rm /usr/bin/pydoc
	sudo rm /usr/bin/python
	if [ "$1" != "2.7" ]; then # only 2.7 has pythonw
		sudo rm /usr/bin/pythonw
	fi
	sudo rm /usr/bin/python-config

	# link new bin shorcut
	sudo ln -s /System/Library/Frameworks/Python.framework/Versions/$1/bin/pydoc$ver /usr/bin/pydoc
	sudo ln -s /System/Library/Frameworks/Python.framework/Versions/$1/bin/python$ver /usr/bin/python
	if [ "$1" == "2.7" ]; then # only 2.7 has pythonw
		sudo ln -s /System/Library/Frameworks/Python.framework/Versions/$1/bin/pythonw$ver /usr/bin/pythonw
	fi
	sudo ln -s /System/Library/Frameworks/Python.framework/Versions/$1/bin/python${ver}m-config /usr/bin/python-config

}

changePythonVersion $1

