# excluded types
omit_type='.o$|.o.d$|.so$|.a$|.class$|.jar$|.dll|.DS_Store'

#如果path存在'/'结尾，就去掉
genFolderPath()
{
	path=$1
	length=${#path} #获取length
	tmp=${path:length-1:1} #获取最后一个byte
	if [ $tmp == '/' ]; then
		path=${path:0:length-1}

	fi
	echo $path #返回string的方式
}

getChanges()
{
	str="a"
	# 注意格式[ "$3" == "" ] 都要有空格
	# string的比较只能用 == ， 不能用-eq
	if [ "$1" == "" ] || [ "$2" == "" ] || [ "$3" == "" ]; then 
		echo "format should be \"exec src_path timestamp_file dst_path\""
		return
	else
		echo "format ok"
	fi

	# init the vars
	path_src=`genFolderPath $1`
	length_src_folder=${#path_src}
	path_ts=$2
	path_dst=`genFolderPath $3`

	# -vE 反向＋扩展表达式，获取排除后的结果。获取的文件路径貌似有问题，有的文件名字里面居然有\n !!!!
	cmd=`find $path_src -newer $path_ts -type f | grep -vE $omit_type` 

	# create a dest folder, the folder name will be the same as the dest
	folder_name=${path_src##*/} # 从左边截去最多的匹配，得到folder名字
	echo $folder_name
	path_dst=${path_dst}"/"${folder_name} #gen the dest folder path
	echo $path_dst

	# do cp
	for file in $cmd
	    do
	        # echo $file
	        # echo $path_src
	        # 1. prepare dest all folder path
	        length_src_file=${#file} # 得到总的原文件路径的长度
	        dest=${file:length_src_folder:length_src_file-length_src_folder} # 得到相对的路径
	        dest=${path_dst}${dest} # 目标路径和相对路径合并

	        # 2. create the dest new folder
			new_folder=${dest%/*} # 从右边截去最多的匹配，得到folder path
			`mkdir -p $new_folder` # 一路创建下去
			# echo $new_folder

			# 3. copying
	        `cp $file $dest` 
	        # echo $file
	        # echo $dest
	        # return
	    done
}

getChanges $1 $2 $3