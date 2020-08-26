
#工程名称
TARGET_NAME="CPush"
#本地路径
PROPATH=/Users/andy_ybcao/Documents/GitHubAndyYB/
#proj库地址
GITHUBPATH=https://github.com/AndyYB/$TARGET_NAME.git
#spec地址
#GITEESPEC=https://gitee.com/andycyb/YBRepoSpec.git
GITEESPEC=https://github.com/AndyYB/YBPodSpec.git
#Example路径
EXAMPLEPATH=${PROPATH}$TARGET_NAME/Example
echo "---repo---输入1创建 pod项目"
echo "---repo---输入2 git init/push master"
echo "---repo---输入3提交 验证 push sepc"
echo "---repo---输入4 pod -install Proj"

echo "------输入5 git add Push-------"
echo "------输入6 删除tag-------"
echo "------输入7 pod push trunk-------"
function podInstall() {
    echo "tips-pod install"
    
    cd ${EXAMPLEPATH}
    pod install
}

function gitaddPush() {
    echo "tips-gitaddPush"
    
    cd ${PROPATH}$TARGET_NAME
    git add .
    read -p "Please input your commit:" commit
    git commit -m "$commit"
    git push origin master
    
    read -p "Please input your tags-(eg:0.1.0):" TagName
    git tag -m "$TagName" $TagName
    git push --tags
}

function removetag() {
    echo "tips-removetag"
    
    cd ${PROPATH}$TARGET_NAME
    read -p "Please input your'll remove tags:" TagName
    git push origin :refs/tags/$TagName
}

function createPods() {
    echo "tips-创建pod项目"
    # cd ~/.cocoapods/repos
    pod repo remove $TARGET_NAME
    #1
    pod repo add $TARGET_NAME $GITEESPEC


    cd ${PROPATH}
    pod lib create $TARGET_NAME
    podInstall
}

function libPushPods() {
    echo "tips-验证push项目"
    cd ${PROPATH}$TARGET_NAME/
    
#    pod spec lint --sources='私有仓库repo地址,https://github.com/CocoaPods/Specs'
#    pod repo push 本地repo名 podspec名   --sources='私有仓库repo地址,https://github.com/CocoaPods/Specs'
#    7.如果私有库添加了静态库或者dependency用了静态库
#    那么执行pod lib lint还有pod spec lint时候需要加上—use-libraries选项

#引用自己或第三方的framework或.a文件时
#在podsepc中应该这样写:
#s.ios.vendored_frameworks = "xxx/**/*.framework"
#s.ios.vendored_libraries = "xxx/**/*.a”

#在私有库引用了私有库的情况下，在验证和推送私有库的情况下都要加上所有的资源地址，不然pod会默认从官方repo查询。
#pod spec lint --sources='私有仓库repo地址,https://github.com/CocoaPods/Specs'
#pod repo push 本地repo名 podspec名 --sources='私有仓库repo地址,https://github.com/CocoaPods/Specs'
    pod spec lint --sources=''${GITEESPEC}',https://github.com/CocoaPods/Specs' --allow-warnings --verbose
    pod repo push $TARGET_NAME $TARGET_NAME.podspec --sources=''$GITEESPEC',https://github.com/CocoaPods/Specs' --allow-warnings --verbose
    
#    pod lib lint $TARGET_NAME.podspec --allow-warnings
#    pod repo push $TARGET_NAME $TARGET_NAME.podspec --allow-warnings

#注册
#pod trunk register 'caoyanbin0426@sina.com' 'AndyYB'
#可查看注册信息
#pod trunk me
#接下来就可以把工程推到trunk上了
#pod trunk push PrivatePod.podspec --allow-warnings
#pod search 库名字
}

function podPushTrunk() {
    echo "podPush-git项目到Trunk"
#    read -p "需要注册吗？ input y/n:" isSig
#    if [ "$isSig" = "y" ];then
#    echo "[ 注册 ]"
#    pod trunk register 'caoyanbin426@163.com' 'AndyYB'
#    pod trunk me
#    fi
    pod trunk push $TARGET_NAME.podspec --allow-warnings
    pod search $TARGET_NAME
}

function initGit() {
    echo "tips-创建git项目"
    echo "# $TagName" >> README.md
    cd ${PROPATH}$TARGET_NAME
    git init
    git add .
    git commit -m "create repo commit"
    git remote add origin $GITHUBPATH
    git push -u origin master

    read -p "Please input your tags-(eg:0.1.0):" TagName
    git tag -m "first tags $TagName" $TagName
    git push --tags
}

read -p "Please input your choice(1|2|3|4|5|6|7):" methodd
case $methodd in
        "1")
                createPods;
                echo "end-1-";
                ;;
        "2")
                initGit;
                echo "end-2-";
                ;;
        "3")
                libPushPods;
                echo "end-3-";
                ;;
        "4")
                podInstall;
                echo "end-4-";
                ;;
        "5")
                gitaddPush;
                echo "end-5-";
                ;;
        "6")
                removetag;
                echo "end-6-";
                ;;
        "7")
                podPushTrunk;
                echo "end-7-";
                ;;
                
esac

