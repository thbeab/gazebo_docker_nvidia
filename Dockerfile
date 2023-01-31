FROM nvidia/cudagl:11.1.1-base-ubuntu20.04
 
# Minimal setup
RUN apt-get update \
 && apt-get install -y locales lsb-release
ARG DEBIAN_FRONTEND=noninteractive
RUN dpkg-reconfigure locales
 
# Install ROS Noetic
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list'
RUN apt-key adv --keyserver 'hkp://keyserver.ubuntu.com:80' --recv-key C1CF6E31E6BADE8868B172B4F42ED6FBAB17C654
RUN apt-get update \
 && apt-get install -y --no-install-recommends ros-noetic-desktop-full
RUN apt-get install -y --no-install-recommends python3-rosdep
RUN rosdep init \
 && rosdep fix-permissions \
 && rosdep update
RUN echo "source /opt/ros/noetic/setup.bash" >> ~/.bashrc
RUN apt-get install -y ros-noetic-ros-control \
  ros-noetic-ros-controllers \
  ros-noetic-gazebo-ros \
  ros-noetic-gazebo-ros-control \
  ros-noetic-joint-state-publisher-gui \
  ros-noetic-rqt-robot-steering \
  ros-noetic-teleop-twist-keyboard xterm \
  git \
  build-essential
RUN mkdir -p inf3995_ws/src && \
  git clone https://github.com/agilexrobotics/ugv_gazebo_sim inf3995_ws/src/ugv_gazebo_sim
WORKDIR /inf3995_ws
RUN rosdep install --from-paths src --ignore-src -r -y
