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


# docker_server操作
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











