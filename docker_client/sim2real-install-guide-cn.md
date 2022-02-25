# 宿主机操作
## 1. 安装 docker
安装参考连接：[docker install](https://docs.docker.com/engine/install/ubuntu/)

若本地尚未安装docker，先进入docker_server目录:
```
cd ICRA-RM-Sim2Real/docker_server
```
执行:
```
./docker_install.sh  
```
若脚本无法执行，则检查脚本是否有运行权限

验证:
```
docker --version
```
<!-- ![docker_version](./assets/docker_version.png) -->

<img src="./assets/docker_version.png" width="40%">

<!-- chmod -->

## 2. 安装 nvida driver
推荐使用Software & Updates中Additional Drivers安装

创建镜像和容器前需要检查宿主机的显卡驱动是否正常

打开终端，输入nvidia-smi  
<!-- ![nvidia_smi](./assets/nvidia_smi.png) -->
<img src="./assets/nvidia_smi.png" width="80%">

<font color= Red>目前支持的驱动版本为470和510</font>

## 3. 安装 nvidia-docker2
安装参考连接：[nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

### 摘取的主要步骤，可做参考
```
sudo systemctl --now enable docker
```

```
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```

```
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```
验证：
```
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```
<!-- ![nvidia_docker](./assets/nvidia_docker.png) -->
<img src="./assets/nvidia_docker.png" width="80%">

## 4. 注册 dockerhub
注册dockerhub账号：[dockerhub](https://hub.docker.com/)

登录dockerhub账号
```
sudo docker login
```
![docker_login](./assets/docker_login.png)

## 5. 下载 docker image
下载镜像<font color= Red>(tag以最后发布为准)</font>
```
sudo docker pull rmus2022/server:v0.0.2
```
![docker_image](./assets/docker_image.png)

<font color= Red>因为镜像文件较大，需等待较长时间</font>

![image_ok](./assets/image_ok.png)

## 6. 创建 docker container
```
cd ICRA-RM-Sim2Real/docker_server
```
<font color= Red>需要确认create_container_server中的tag为正确版本</font>

![docker_tag_version](./assets/docker_tag_version.png)
```
./create_container_server.sh
```
![create_container_server](./assets/create_container_server.png)

<font color= Red>当本地没有sim2real_server容器时会报错，不影响</font>

<font color= Red>每次运行该脚本，会删除没有docker commit的修改</font>


# docker server操作
## 1. 运行docker
<font color= Red>重启后需要执行一次</font>
```
sudo docker start sim2real_server 
```

```
cd ICRA-RM-Sim2Real/docker_server
```
<font color= Red>密码：123</font>
```
./exec_server.sh
```

## <font color= Red>进入docker环境</font>
## 2. 运行habitat sim例程
```
cd ~/habitat-sim/
```
```
./build/viewer ./data/scene_datasets/habitat-test-scenes/van-gogh-room.glb 
```
<font color= Red>可以通过 w, a, s, d控制机器人移动，通过方向键控制机器人视角。</font>

![habitat_sim](./assets/habitat_sim.png)

## 3. 运行server环境
新建terminal
```
cd ICRA-RM-Sim2Real/docker_server
```
```
./exec_server.sh
```
```
roscore
```
新建terminal
```
cd ICRA-RM-Sim2Real/docker_server
```
```
./exec_server.sh
```
```
cd ~/ros_x_habitat_ws/src/ros_x_habitat/
```
```
python3 src/scripts/roam_with_joy.py --hab-env-config-path ./configs/roam_configs/pointnav_rgbd_roam_mp3d_test_scenes.yaml
```
![ros_x_habitat_rgb](./assets/ros_x_habitat_rgb.png)
![ros_x_habitat_depth](./assets/ros_x_habitat_depth.png)
![ros_x_habitat_third](./assets/ros_x_habitat_third.png)

## 4. 键盘控制运动和抓取
新建terminal
```
cd ICRA-RM-Sim2Real/docker_server
```
```
./exec_server.sh
```
```
rosrun teleop_twist_keyboard teleop_twist_keyboard.py
```

<font color= Red>需要鼠标点击，激活键盘控制程序的terminal</font>

![key ctr](./assets/key.png)

<font color= Red>按键q，z，增大和降低机器人速度</font>

按键i，j，，，l， 控制机器人前进后退和旋转

<font color= Red>按键I，J，<，L，控制机器人横向移动</font>

通过k，停止机器人运动

按键1，移动机械臂到抓取位置

按键2，移动机械臂到放置位置

按键3，抓取矿石

按键4，放置矿石

# docker client操作
## 1. 下载 docker image
下载镜像<font color= Red>(tag以最后发布为准)</font>
```
sudo docker pull rmus2022/client:v0.0.0
```

## 2. 创建 docker container
```
cd ICRA-RM-Sim2Real/docker_client
```
<font color= Red>需要确认create_container_client中的tag为正确版本</font>

<font color= Red>需要根据宿主机的cpu修改create_container_client.sh中的cpu和内存参数</font>

cpu参数计算公式：
```
cpu=（NUC的cpu单核频率 × NUC的cpu个数）/ 宿主机单核频率
```
举例：

宿主机cpu为：Intel® Xeon(R) W-2125 CPU @ 4.00GHz × 8

机器人cpu为：11th Gen Intel® Core i7-1165G7 @ 2.80GHz × 8

则cpu=（2.8 × 8) / 4 = 5.6

机器人内存为：8GB

则M=8192M
```
./create_container_client.sh
```

<font color= Red>当本地没有sim2real_client容器时会报错，不影响</font>

<font color= Red>每次运行该脚本，会删除没有docker commit的修改</font>

## 3. rtab navigation
### 运行server环境（docker server操作步骤3）
正确显示rgb、depth、third_rgb画面

<font color= Red>如果出现错误，重启启动一次</font>

### 运行client环境
<font color= Red>重启后需要执行一次</font>
```
sudo docker start sim2real_client
```
新建terminal
```
cd ICRA-RM-Sim2Real/docker_client
```
```
./exec_client.sh
```

```
cd ~
```
```
roslaunch habitat_navigation rtab_navigation.launch
```
通过rviz发送2D Nav Goal

![rtab_nav_demo](./assets/rtab_nav_demo.png)


## 4. cartographer navigation
### 运行server环境（docker server操作步骤3）
正确显示rgb、depth、third_rgb画面

<font color= Red>如果出现错误，重启启动一次</font>

### 运行client环境

新建terminal
```
cd ICRA-RM-Sim2Real/docker_client
```
```
./exec_client.sh
```
```
cd ~
```
```
roslaunch carto_navigation env.launch
```

新建terminal
```
cd ICRA-RM-Sim2Real/docker_client
```
```
./exec_client.sh
```
```
cd ~
```
```
roslaunch carto_navigation navigation.launch
```
通过rviz发送2D Nav Goal

![rtab_nav_demo](./assets/carto_nav_demo.png)


## 4. 抓取矿石（待补充）

## 4. 放置矿石（待补充）

# 上传client镜像

## 1. 新建privtate repo
参赛队伍在自己注册的dockerhub上新建一个private repo，名字为rmus2022

![create_repo](./assets/create_repo.png)

![create_repo_detail](./assets/create_repo_detail.png)

## 2. 将client镜像push到private repo
将下载的client镜像打上tag(tag名称，参赛队伍可以自定义)，dockerhub_name为dcokerhub的账号名字
```
sudo docker tag rmus2022/client:v.0.1.0 dockerhub_name/rmus2022:tag
```
![change_docker_tag](./assets/change-docker_tag.png)

将新tag的client镜像push到private repo
```
sudo docker push dockerhub_name/rmus2022:tag
```

![docker_push](./assets/docker_push.png)

## 2. 开发比赛任务
根据private repo和tag名字，修改create_client里的镜像名和tag

![change_create_para](./assets/change_create_para.png)

运行create_client.sh，创建新容器

运行exec_client.sh，进入client镜像进行开发

推荐使用git工具管理好代码版本

在docker中可以通过vscode进行开发

![use_vscode](./assets/use_vscode.png)

## 3. docker commit
本地保存镜像修改内容，使用原有的tag会覆盖之前tag版本的内容
```
sudo docker commit sim2real_client dockerhub_name/rmus2022:new_tag
```

![docker_commit](./assets/docker_commit.png)

## 4. docker push
通过docker push到private repo保存当前docker镜像到dockerhub
```
sudo docker push dockerhub_name/rmus2022:tag
```

![docker_push_new](./assets/docker_push_new.png)

## 5，生成访问token
参考连接：[docker token](https://docs.docker.com/docker-hub/access-tokens/)

在需要提交测试的版本时，
将dockerhub用户名、docker token由比赛系统提交。

![enter_account_setting](./assets/enter_account_setting.png)

![create_token_pos](./assets/create_token_pos.png)

![create_token](./assets/create_token.png)

![token_created](./assets/token_created.png)






