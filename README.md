## 1. Installer NVIDIA container toolkit
[NVIDIA container toolkit install guide](https://docs.nvidia.com/datacenter/cloud-native/container-toolkit/install-guide.html)

## 2. Build the Dockerfile
```
docker build -t inf3995-equipe104-nvidia .
```

## 3. Open x server
A faire une fois par session:
```
xhost +
```

## 4. Start a terminal
```
docker run -it --net=host --gpus all \
    --env="NVIDIA_DRIVER_CAPABILITIES=all" \
    --env="DISPLAY" \
    --env="QT_X11_NO_MITSHM=1" \
    --volume="/tmp/.X11-unix:/tmp/.X11-unix:rw" \
    inf3995-equipe104-nvidia \
    bash
```

Apres cela il est possible de lancer la simulation :
```
catkin_make && source devel/setup.bash
roslaunch limo_gazebo_sim limo_ackerman.launch &
python3 /opt/ros/noetic/lib/teleop_twist_keyboard/teleop_twist_keyboard.py # you can drive around
```
PS: Des WARNING apparaitront dans la console, pour y remedier, fermez la fenetre rviz.

