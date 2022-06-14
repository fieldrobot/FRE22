#!/bin/sh

if [ -n "$DESTDIR" ] ; then
    case $DESTDIR in
        /*) # ok
            ;;
        *)
            /bin/echo "DESTDIR argument must be absolute... "
            /bin/echo "otherwise python's distutils will bork things."
            exit 1
    esac
fi

echo_and_run() { echo "+ $@" ; "$@" ; }

echo_and_run cd "/field_robot/ROS1/src/virtual_maize_field"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/field_robot/ROS1/install/lib/python3/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/field_robot/ROS1/install/lib/python3/dist-packages:/field_robot/ROS1/build/lib/python3/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/field_robot/ROS1/build" \
    "/usr/bin/python3" \
    "/field_robot/ROS1/src/virtual_maize_field/setup.py" \
     \
    build --build-base "/field_robot/ROS1/build/virtual_maize_field" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/field_robot/ROS1/install" --install-scripts="/field_robot/ROS1/install/bin"
