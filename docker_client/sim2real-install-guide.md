# 1. Host operation
<!-- <font color= Red>(在安装前，须将docker_habitat完全移至~路径下)</font> -->
## 1.1 Docker

Reference for docker installation on Ubuntu: 
- [docker install](https://docs.docker.com/engine/install/ubuntu/)

If docker local installation hasn't been done, switch to the docker_server folder first:

```
cd ./ICRA-RM-Sim2Real/docker_server
```

Execution: 

```bash
./docker_install.sh  
```

Evaluation

```bash
docker --version
```
<!-- ![docker_version](./assets/docker_version.png) -->

<img src="./assets/docker_version.png" width="40%">

<!-- chmod -->

If the shell script cannot be run, check if there is permission for the script. Otherwise change the mode with `chmod`

## 1.2 Nvidia driver

Check the version of host GPU driver before creating the docker and container, carefully keeping the same with the version inside docker. Currently the NVIDIA driver version inside the docker repos is 470.86.

In Ubuntu, `Software & Updates > Additional Drivers` is recommanded to update the Nvidia driver.

Open the terminal, input nvidia-smi and press enter to get the driver version:

<!-- ![nvidia_smi](./assets/nvidia_smi.png) -->
<img src="./assets/nvidia_smi.png" width="80%">

Know issue:
- If your OS is Ubuntu21.04 or later, please refer to [issue 18](https://github.com/AIR-DISCOVER/ICRA-RM-Sim2Real/issues/18) to fix.

## 1.3 Install the `nvidia-docker2`

Reference link for docker installation: 

[nvidia-docker2](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

### 1.3.1 Main stages for docker installation reference

```bash
sudo systemctl --now enable docker
```

```bash
distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
   && curl -s -L https://nvidia.github.io/nvidia-docker/gpgkey | sudo apt-key add - \
   && curl -s -L https://nvidia.github.io/nvidia-docker/$distribution/nvidia-docker.list | sudo tee /etc/apt/sources.list.d/nvidia-docker.list
```


```bash
sudo apt-get update
sudo apt-get install -y nvidia-docker2
sudo systemctl restart docker
```

```bash
# test
sudo docker run --rm --gpus all nvidia/cuda:11.0-base nvidia-smi
```
<!-- ![nvidia_docker](./assets/nvidia_docker.png) -->
<img src="./assets/nvidia_docker.png" width="80%">

## 1.4 docker login

Register the dockerhub account: 
- [dockerhub](https://hub.docker.com/)

And get access token for late use: 
- https://docs.docker.com/docker-hub/access-tokens/

login the docker account

```
sudo docker login
```

![docker_login](./assets/docker_login.png)

## 1.5 Download the docker image

Download the docker image:

<!-- sudo docker pull hpf9017/habitat:add_gate -->

```
sudo docker pull rmus2022/server:v0.0.2
```

![docker_image](./assets/docker_image.png)

Due to the size of the image files, waiting for <font color= Red>minutes to more than an hour</font> to download the files is typical.

![image_ok](./assets/image_ok.png)

## 1.6 Create the docker container

```bash
cd ./ICRA-RM-Sim2Real/docker_server
```
<font color= Red>Please ensure the right `tag` version in `create_container_server.sh`</font>

![docker_tag_version](./assets/docker_tag_version.png)

```bash
./create_container_server.sh
```

![create_container_server](./assets/create_container_server.png)

<font color= Red>An `Error` will be reported while there is no  `sim2real_server` container. No need to worry.</font>

<font color= Red>Changes without `docker commit` will be deleted after each time the script run.</font>

# 2. Docker `Server` operation


## 2.1 To start the docker

<font color= Red>Run this line again after reset</font>

```bash
sudo docker start sim2real_server 
```

```bash
cd ./ICRA-RM-Sim2Real/docker_server
```

password: `123`

```bash
./exec_server.sh
```

<font color= Red>Enter the docker</font>

## 2.2 Start the Habitat sim

```bash
cd ~/habitat-sim/
```

```bash
./build/viewer ./data/scene_datasets/habitat-test-scenes/van-gogh-room.glb 
```
<!-- ./habitat-viewer ./sim_test/scene_datasets/habitat-test-scenes/van-gogh-room.glb   -->

There should be a window created and scene showed in the window, use W, A, S, D to control agent move.


![habitat_sim](./assets/habitat_sim.png)

## 2.3 Start the `server` simulator
<!-- 
<font color= Red>Set the environment variables while starting the docker for the first time</font>

```bash
echo "export PYTHONPATH=$PYTHONPATH:/home/sim2real/test/src" >> ~/.bashrc
```

```
echo "source /home/sim2real/test/devel/setup.bash" >> ~/.bashrc
``` -->

Start a new terminal.

```bash
cd ./ICRA-RM-Sim2Real/docker_server
```

```bash
./exec_server.sh
```

```
roscore
```

Create a new terminal

```bash
cd ./ICRA-RM-Sim2Real/docker_server
```

```bash
./exec_server.sh
```

```bash
cd ~/ros_x_habitat_ws/src/ros_x_habitat/
```

```bash
python3 src/scripts/roam_with_joy.py --hab-env-config-path ./configs/roam_configs/pointnav_rgbd_roam_mp3d_test_scenes.yaml
```

 <!-- --episode-id -1 --scene-id ./data/scene_datasets/mp3d/2t7WUuJeko7/2t7WUuJeko7.glb --video-frame-period 30 -->


![ros_x_habitat_rgb](./assets/ros_x_habitat_rgb.png)
![ros_x_habitat_depth](./assets/ros_x_habitat_depth.png)
![ros_x_habitat_third](./assets/ros_x_habitat_third.png)

## 2.4 Control the movement via the keyboard

Create a new terminal

```bash
cd ./ICRA-RM-Sim2Real/docker_server
```
```bash
./exec_server.sh
```
```
rosrun teleop_twist_keyboard teleop_twist_keyboard.py
```

<font color= Red>Mouse click to activate the terminal of keyboard control</font>

![key ctr](./assets/key.png)

<font color= Red>Press `q`, `z`, increase or decrease the speed of the robot.</font>

- Press `i`， `j`， `，` ， `l`， to control forward/backward/rotation.
- Press `I`， `J`， `<`， `L`， to control the horizontal movement.
- Press `k`, stop the robot moving.
- Press `1`, to move the robotic arm to the place to grab up.
- Press `2`， to move the robotic arm to the place to place down.
- Press `3`， to pick the ore.
- Press `4`， to place the ore.

# 3. Docker `Client` operation

## 3.1 Download the  docker image

Download the image <font color= Red>(according to the last released version)</font>.

```bash
sudo docker pull rmus2022/client:v0.0.0
```

## 3.2 Creator the `client` container
```
cd ./ICRA-RM-Sim2Real/docker_client
```
<font color= Red>Confirm the `tag` in `create_container_client` is the right version.</font>

<font color= Red>Change the CPU and RAM parameter from the `create_container_algo.sh` according to the host machine, to meet the performance of robot on board NUC unit.
</font>  

For example:   
> the host CPU: Intel® Xeon(R) W-2125 CPU @ 4.00GHz * 8  
> NUC onboard cpu: 11th Gen Intel® Core i7-1165G7 @ 2.80GHz * 8  
> 
> then:
> `cpu = (2.8 * 8) / 4 = 5.6`
>
> NUC onboard RAM: 8GB  
>
> then:
> `M=8192M`

```bash
./create_container_client.sh
```

<font color= Red>for the first time of execution there will be "Error: No such container: sim2real_algo", no need to worry.</font>

<font color= Red>Changes without `docker commit` will be deleted after each time the script run.</font>

<!-- ![avatar](./assets/docker_container_sim2real.png) -->

## 3.3 rtab navigation

### 3.3.1 Start the `server` (follow the [step 3](./sim2real-install-guide.md#23-start-the-server-simulator) in docker server)

The `RGB`, `depth`, `third_rgb` monitor should be correct.

<font color= Red>If there is error, start it again.</font>

### 3.3.2 Start the `client`

<font color= Red>Running again after restart.</font>

```ssh
sudo docker start sim2real_client
```

Start a new terminal

```bash
cd ICRA-RM-Sim2Real/docker_client
```

```bash
./exec_client.sh
```

```bash
cd ~
```

```bash
roslaunch habitat_navigation rtab_navigation.launch
```

Send `2D Nav Goal` through `rviz`

![rtab_nav_demo](./assets/rtab_nav_demo.png)


## 3.4 cartographer navigation

### 3.4.1 Start the `server` (follow the [step 3](./sim2real-install-guide.md#23-start-the-server-simulator) in docker server)

The `RGB`, `depth`, `third_rgb` monitor should be correct.

<font color= Red>If there is error, start it again.</font>

### 3.4.2 Start the `client`

Start a new terminal

```bash
cd ./ICRA-RM-Sim2Real/docker_client
```

```bash
./exec_client.sh
```

```bash
cd ~
```

```bash
roslaunch carto_navigation env.launch
```

Start a new terminal

```bash
cd ICRA-RM-Sim2Real/docker_client
```

```bash
./exec_client.sh
```

```bash
cd ~
```

```bash
roslaunch carto_navigation navigation.launch
```

Send `2D Nav Goal` through `rviz`

![rtab_nav_demo](./assets/carto_nav_demo.png)


## 3.5 Pick the ore (TBD)

## 3.6 Place the ore (TBD)

<!-- 
## 4. Visual navigation

Download the docker for the competition:

```
sudo docker pull hpf9017/sim2real:nav_demo
```
![avatar](./assets/docker_image_sim2real.png)

<font color= Red>several minutes to half an hour might be in need due to the internet connectivity</font>

![avatar](./assets/image_ok_sim2real.png)

## The docker environment for robot

The sim/real robot onboard computation sharing the same docker system provided here.

Start a new terminal

<font color= Red>for the first time of execution there will be "Error: No such container: sim2real_algo"</font>
![avatar](./assets/docker_container_sim2real.png)
```
./exec_elgo.sh
```
Enter the docker environment for the robot competition

<font color= Red>Maker sure habitat has been started in [2. ros-x-habitat](#2-ros-x-habitat), the RGB and depth monitor work properly</font>

```
cd ~
```
```
roslaunch habitat_navigation rtab_navigation.launch
```
![avatar](./assets/nav_demo.png) -->

