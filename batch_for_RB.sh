#!/bin/bash
#December 8, 2021.
#Jimoh Olarinde Fatai and Aderinoye Olalekan Lateef
#Batch file to call our RB_Project launch files

#echo "Bringing up our turtlebot3 for movement...."

#stap 1
#roscore&

#step2
#gnome-terminal -- sh -c "ssh ubuntu@192.168.0.200; bash"

#step3
roslaunch turtlebot3_autorace_traffic_light_camera turtlebot3_autorace_camera_pi.launch; bash&

#step4
gnome-terminal -- sh -c "export AUTO_IN_CALIB=action;export GAZEBO_MODE=false;roslaunch turtlebot3_autorace_traffic_light_camera turtlebot3_autorace_intrinsic_camera_calibration.launch; bash"

#step5
gnome-terminal -- sh -c "export AUTO_EX_CALIB=action;export GAZEBO_MODE=false;roslaunch turtlebot3_autorace_traffic_light_camera turtlebot3_autorace_extrinsic_camera_calibration.launch; bash"

#step6
gnome-terminal -- sh -c "export AUTO_DT_CALIB=action;export GAZEBO_MODE=false;roslaunch turtlebot3_autorace_traffic_light_detect turtlebot3_autorace_detect_lane.launch; bash"

gnome-terminal -- sh -c "rqt; bash"
#step7
gnome-terminal -- sh -c "roslaunch turtlebot3_autorace_traffic_light_control turtlebot3_autorace_control_lane.launch; bash"

#step8
#gnome-terminal -- sh -c "roslaunch turtlebot3_bringup turtlebot3_robot.launch; bash"

#END
#start /wait cmd /k CALL
#start /wait cmd /k CALL
#start /wait cmd /k CALL
#start /wait cmd /k CALL
#start /wait cmd /k CALL
#start /wait cmd /k CALL
#start /wait cmd /k CALL
#start /wait cmd /k CALL
