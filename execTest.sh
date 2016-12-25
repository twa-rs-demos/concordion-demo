#########################################################################
# File Name: refreshDB.sh
# Author: Afar
# mail: 550047450@qq.com
# Created Time: Thursday, December 22, 2016 AM11:24:40 CST
#########################################################################
#!/bin/bash

# 初始化测试执行环境

run_container(){
	pwd
	cd ~/twars/assembly/
	docker-compose kill && docker-compose up -d paper-api mongo
}

refreshDB() {
	pwd
	cd ~/twars/paper-api/
	./gradlew flywayclean && ./gradlew flywaymigrate && ./gradlew flywayinfo
}

# TODO: kill web-api if it is start already
start_web_api() {
	pwd
	cd ~/twars/web-api/
	export NODE_ENV=test; node app.js & 
}

run_test() {
	cd ~/workspace/working-directory/concordion-demo
	./gradlew test
}

# 初始化环境
initialize() {
	run_container && refreshDB && start_web_api  
}

init() {
	initialize && run_test
}

run() {
	refreshDB && run_test
}

action=$1

case $action in 
	init)
		echo "initialize execution environment..."
		init
		;;
	run)
		echo "run test..."
		run
		;;
	*)
		echo "用法: (init|run)"
		echo "- command: "
		echo "init 初始化环境并运行测试"
		echo "run 运行测试"
		;;
esac
		

