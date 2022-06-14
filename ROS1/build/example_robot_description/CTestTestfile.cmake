# CMake generated Testfile for 
# Source directory: /field_robot/ROS1/src/example_robot_description
# Build directory: /field_robot/ROS1/build/example_robot_description
# 
# This file includes the relevant testing commands required for 
# testing this directory and lists subdirectories to be tested as well.
add_test(_ctest_example_robot_description_roslaunch-check_launch_description.launch "/field_robot/ROS1/build/catkin_generated/env_cached.sh" "/usr/bin/python3" "/opt/ros/noetic/share/catkin/cmake/test/run_tests.py" "/field_robot/ROS1/build/test_results/example_robot_description/roslaunch-check_launch_description.launch.xml" "--return-code" "/usr/bin/cmake -E make_directory /field_robot/ROS1/build/test_results/example_robot_description" "/opt/ros/noetic/share/roslaunch/cmake/../scripts/roslaunch-check -o \"/field_robot/ROS1/build/test_results/example_robot_description/roslaunch-check_launch_description.launch.xml\" \"/field_robot/ROS1/src/example_robot_description/launch/description.launch\" ")
set_tests_properties(_ctest_example_robot_description_roslaunch-check_launch_description.launch PROPERTIES  _BACKTRACE_TRIPLES "/opt/ros/noetic/share/catkin/cmake/test/tests.cmake;160;add_test;/opt/ros/noetic/share/roslaunch/cmake/roslaunch-extras.cmake;66;catkin_run_tests_target;/field_robot/ROS1/src/example_robot_description/CMakeLists.txt;8;roslaunch_add_file_check;/field_robot/ROS1/src/example_robot_description/CMakeLists.txt;0;")
