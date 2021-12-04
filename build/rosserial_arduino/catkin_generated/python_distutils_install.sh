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

echo_and_run cd "/home/dawid/robotic_arm/src/rosserial/rosserial_arduino"

# ensure that Python install destination exists
echo_and_run mkdir -p "$DESTDIR/home/dawid/robotic_arm/install/lib/python2.7/dist-packages"

# Note that PYTHONPATH is pulled from the environment to support installing
# into one location when some dependencies were installed in another
# location, #123.
echo_and_run /usr/bin/env \
    PYTHONPATH="/home/dawid/robotic_arm/install/lib/python2.7/dist-packages:/home/dawid/robotic_arm/build/rosserial_arduino/lib/python2.7/dist-packages:$PYTHONPATH" \
    CATKIN_BINARY_DIR="/home/dawid/robotic_arm/build/rosserial_arduino" \
    "/usr/bin/python2" \
    "/home/dawid/robotic_arm/src/rosserial/rosserial_arduino/setup.py" \
     \
    build --build-base "/home/dawid/robotic_arm/build/rosserial_arduino" \
    install \
    --root="${DESTDIR-/}" \
    --install-layout=deb --prefix="/home/dawid/robotic_arm/install" --install-scripts="/home/dawid/robotic_arm/install/bin"
