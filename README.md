## Build the Dockerfile
```
docker build -t inf3995-equipe104-nvidia .
```

## Open x server
A faire une fois par session:
```
xhost +
```

## Start a terminal
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

