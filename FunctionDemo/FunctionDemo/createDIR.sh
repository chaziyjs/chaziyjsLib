#!/bin/bash

echo "项目文件夹创建开始"

eval "mkdir -p $(pwd)/MainFile/BaseUILib";
eval "mkdir -p $(pwd)/MainFile/MainUI";
eval "mkdir -p $(pwd)/MainFile/UI-DOM";
eval "mkdir -p $(pwd)/ToolFile/Category";
eval "mkdir -p $(pwd)/ToolFile/DefaultFiles";
eval "mkdir -p $(pwd)/ToolFile/ThirdLib";
eval "mkdir -p $(pwd)/IMGAssets"

page=1;

buildSubDir () {
	read -p "请输入项目类别名称, 结束请输入n:" filename;
	echo "$filename"
	if [[ "$filename" == "n" ]]; then
		#输入n结束函数运行
		return
	else 
		eval "mkdir -p $(pwd)/MainFile/MainUI/$filename/DataModel";
		eval "mkdir -p $(pwd)/MainFile/MainUI/$filename/ViewModel";
		eval "mkdir -p $(pwd)/MainFile/MainUI/$filename/CustomModels";
		eval "mkdir -p $(pwd)/MainFile/MainUI/$filename/SubViews";
		eval "mkdir -p $(pwd)/MainFile/MainUI/$filename/CustomViews";
		buildSubDir
	fi
	
}

buildSubDir

echo "文件夹创建完成"

eval "ls -a"