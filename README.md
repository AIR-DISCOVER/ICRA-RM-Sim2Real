# ICRA-RM-Sim2Real

![RoboMasterEP](./assets/RoboMasterEP.gif)

The official website of the competition: 
- https://air.tsinghua.edu.cn/robomaster/sim2real_icra22.html

The gitee mirror of this repo is provided for mainland user:
- https://gitee.com/RMUS/ICRA-RM-Sim2Real/
# ICRA-RM-Sim2Real Tutorials

![arch of the RMUS EP SIM2REAL system](./assets/arch-EP-sim2real.png)

The `RMUS SIM2REAL` system is consist of the Server/Client two parts, seperated the server docker image to deploy the simulation environment and the client docker image to deploy the user algorithm for the EP robot to connect to the environment both for simulation and reality.

Non-Beginners: If you're already familiar enough with Linux+ROS+Habitat or earlier versions and only want to explore the new ICRA-RM-Sim2Real playground, you can go through the detail of installation guide [here](./docker_sim2real/sim2real-install-guide.md). However, going over all basic Beginner Level tutorials is still recommended for all users to get exposed to new features.

If you are new to Linux: You may find it helpful to first do a quick tutorial on common command line tools for linux. A good one is [here](http://www.ee.surrey.ac.uk/Teaching/Unix/).

Hardware requirement: NVIDA GPU 1080+ with driver 470+ in need to support the SIM2REAL environment.

Ubuntu 18.04 or later in need to support more convenient experience.

<!-- # Core Sim2Real Tutorials -->
## Entry Level

- the system architecture
  - hardware introduction
  - [software stack](./Tutorial.md)
    - [Habitat](https://github.com/facebookresearch/habitat-sim)
    - [ROS](http://wiki.ros.org/ROS/Tutorials)
      <!-- - briefly introduction
      - SLAM -->
    - [ROS-X-Habitat](https://github.com/ericchen321/ros_x_habitat)
    - [Getting Started with the RoboMaster SDK - EP](https://robomaster-dev.readthedocs.io/en/latest/python_sdk/beginner_ep.html)
- [Installing the system](./docker_sim2real/sim2real-install-guide.md)
- [Platform introduction](./Tutorial.md#1-platform-introduction)
<!-- - Optional remote control -->
   <!-- log -->
   <!-- Judgement Score -->
<!-- - etc -->

## Intermediate Level

- Hands on the baseline
  - system introduction
    - [System installation](./docker_sim2real/sim2real-install-guide.md)
  - [functional modules](./Tutorial.md)
    - [ROS interface](./Tutorial.md#3-ros-interface)
    - [Map based on cartographer](./Tutorial.md#41-map-based-on-cartographer)
      <!-- RTAB Navi -->
    - [Lidar based navigation cartographer and move_base](./Tutorial.md#42-lider-navigation-based-on-cartographer-and-move_base)
    <!-- Digital CV -->
    <!-- box grasp/put -->
- the Judgement system
  - local
   <!-- blocks Nums in need -->
   <!-- report cpu high -->
   <!-- debug toolchain -->
   <!--     log -->
   <!--     rgb/depth log optional recording -->
  - online

## Other resource

- The [ICRA2022 RoboMaster University Sim2Real Challenge (RMUS)](https://air.tsinghua.edu.cn/robomaster/sim2real_icra22.html)
  - [the RMUS rulebook](https://air.tsinghua.edu.cn/robomaster/RMUS2022_rules_manual.pdf)
- Docker
- welcome to submit Issues
- http://wiki.ros.org/ROS/Tutorials#Core_ROS_Tutorials

<!-- [中文版本](./README_CN.md) -->
Related docker repository
- https://hub.docker.com/repository/docker/rmus2022/server

<!-- [README of the sim2real agent](./docker_sim2real/README.md) -->

# Reference

1. [ROS-X-Habitat: Bridging the ROS Ecosystem with Embodied AI](https://arxiv.org/abs/2109.07703)
   - [Repo](https://github.com/ericchen321/ros_x_habitat)
2. https://nvidia.github.io/nvidia-docker/
3. [How to Train Your [Dragon] Embodied Agent (with AI Habitat)](https://aihabitat.org/tutorial/2020/)
4. https://github.com/facebookresearch/habitat-lab
5. https://github.com/ros/dynamic_reconfigure



