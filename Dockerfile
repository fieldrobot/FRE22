FROM ubuntu:focal

#CUSTOM
ARG DEBIAN_FRONTEND=noninteractive

RUN apt update && \
  apt install -y curl gnupg2 lsb-release

#####   ROS INSTALL
# sources
RUN sh -c 'echo "deb http://packages.ros.org/ros/ubuntu $(lsb_release -sc) main" > /etc/apt/sources.list.d/ros-latest.list' && \
# keys
  apt install curl && \
  curl -s https://raw.githubusercontent.com/ros/rosdistro/master/ros.asc | apt-key add -
#install
RUN apt update -y && \
  apt install -y ros-noetic-ros-base
RUN apt install -y python3-rosdep \
  python3-rosinstall \
  python3-rosinstall-generator \
  python3-wstool build-essential \
  python3-rosdep
RUN apt install -y ros-noetic-gazebo-ros-pkgs \
  ros-noetic-gazebo-ros-control

#####   ROS2 INSTALL
# locale - timezone setup
RUN apt update && \
  apt install -y locales && \
  locale-gen en_US en_US.UTF-8 && \
  update-locale LC_ALL=en_US.UTF-8 LANG=en_US.UTF-8
ENV LC_ALL=en_US.UTF-8
ENV LANG=en_US.UTF-8
# ROS2 directories
RUN apt update && \
  apt install -y curl gnupg2 lsb-release && \
  curl -sSL https://raw.githubusercontent.com/ros/rosdistro/master/ros.key  -o /usr/share/keyrings/ros-archive-keyring.gpg && \
  echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/ros-archive-keyring.gpg] http://packages.ros.org/ros2/ubuntu $(lsb_release -cs) main" | tee /etc/apt/sources.list.d/ros2.list > /dev/null
# ROS2 INSTALL
RUN  apt update && \
  apt install -y ros-foxy-ros-base
ENV ROS_DISTRO foxy
# ROS2 dependencies
RUN apt update && apt install -y \
  build-essential \
  python3-colcon-common-extensions \
  python3-colcon-mixin \
  python3-rosdep \
  python3-vcstool \
  python3-argcomplete
# package dependencies
RUN apt update && \
  apt install -y python3-opencv && \
  apt install -y ros-foxy-vision-opencv && \
  apt install -y ros-foxy-cv-bridge && \
  apt install -y ros-foxy-pcl-ros && \
  apt install -y ros-foxy-robot-localization && \
  apt install -y ros-foxy-behaviortree-cpp-v3
#RUN apt install -y ros-foxy-gazebo-ros-pkgs
RUN apt install -y python3-pip && \
  pip install --upgrade pip && \
  pip install tensorflow-aarch64 -f https://tf.kmtea.eu/whl/stable.html && \
  pip install protobuf==3.20.0
RUN apt install -y \
  ros-foxy-navigation2 \
  ros-foxy-nav2-*

#####   UTILITIES
RUN apt update -y && apt install -y \
  ros-foxy-rviz2
RUN apt update && apt install -y \
  nano \
  git
RUN apt install -y ros-foxy-ros1-bridge

RUN apt install -y ros-noetic-xacro

COPY . /field_robot
# ROS1 build
#RUN bash -c "source /opt/ros/noetic/setup.bash && cd /field_robot/ROS1 && catkin_make"
# ROS2 build
#RUN bash -c "source /opt/ros/foxy/setup.bash && cd /field_robot/field_robot/dev_ws && colcon build"

#####   VOLUMES
#RUN git clone -b navigation https://github.com/fieldrobot/field_robot.git
#/field_robot
#COPY /../field_robot/ /field_robot/
#VOLUME ["/field_robot"]
VOLUME ["/catkin/src/virtual_maize_field/map"]
VOLUME ["/catkin/src/virtual_maize_field/launch"]
VOLUME ["/catkin/src/virtual_maize_field/models"]

#RUN bash l /field_robot/ROS1 && sleep 999999

CMD ["bash", "/field_robot/field_robot/start.bash"]






#additional recommended/necessary packages


# Finalise ROS setup
#RUN rosdep init && rosdep update --rosdistro $ROS_DISTRO

# Project Dependencys
#RUN apt update && apt install -y \
#  python3-opencv \
#  ros-$ROS_DISTRO-vision-opencv \
#  ros-$ROS_DISTRO-cv-bridge \
#  ros-$ROS_DISTRO-pcl-ros \
#  ros-$ROS_DISTRO-robot-localization \
#  ros-$ROS_DISTRO-behaviortree-cpp-v3 \
#  ros-$ROS_DISTRO-navigation2 \
#  ros-$ROS_DISTRO-nav2-bringup \
#  ros-$ROS_DISTRO-slam-toolbox

# Install Gazebo
#RUN apt update && apt install -y ros-$ROS_DISTRO-gazebo-ros-pkgs

# Install Pip
#RUN apt update && apt install -y python3-pip && \
#  pip install --upgrade pip

# Install Tensorflow
#RUN pip install tensorflow-aarch64 -f https://tf.kmtea.eu/whl/stable.html && \
##    pip install protobuf==3.20.0




#RUN cd /field_robot/dev_ws/ && colcon build

#CMD bash




# set up ROS2 source
#RUN echo "source /opt/ros/foxy/setup.bash" >> ~/.bashrc && \
#  echo "source /field_robot/dev_ws/install/setup.bash" >> ~/.bashrc
#additional recommended/necessary packages

#RUN apt update && \
#  apt upgrade -y && \
#  apt install -y xorg xserver-xorg-video-dummy

#####   ROS1 bridge
#ENV ROS_MASTER_URI=http://172.20.0.5:11311
#RUN apt install ros-foxy-ros1-bridge

#####   UTILITIES
#RUN apt install -y nano

#####   VOLUMES
#RUN git clone 
#VOLUME [ "/field_robot" ]

#CMD X

#RUN echo 'Section "Device" \n\
#    Identifier  "Card0" \n\
#    Driver      "dummy" \n\
#    VideoRam    256000 \n\
#EndSection \n\
#Section "Monitor" \n\
#    Identifier  "Monitor0" \n\
#    HorizSync 31.5-48.5 \n\
#    VertRefresh 50-70 \n\
#EndSection \n\
#Section "Screen" \n\
#    Identifier  "Screen0" \n\
#    Monitor     "Monitor0" \n\
#    Device      "Card0" \n\
#    DefaultDepth 24 \n\
#    SubSection "Display" \n\
#    Depth 24 \n\
#    Modes "1024x800" \n\
#    EndSubSection \n\
#EndSection' >> /usr/share/X11/xorg.conf.d/xorg.conf
#ENV DISPLAY=:0