# AUTONOMOUS DRIVING OF TURTLEBOT3

![_msr-peng_Self-Driving-Turtlebot3_blob_master_pictures_turtlebot-3](https://user-images.githubusercontent.com/62597513/145625174-0cad437b-5282-46da-a499-9244b2de4d8d.jpg)



# Problem Statement 
This project focuses on elementary turtlebot3 self-driving, which follows the lane detected lines. The project is to solve an autonomous driving lane tracking challenge, and all steps taken which have been described in https://emanual.robotis.com/docs/en/platform/turtlebot3/autonomous_driving_autorace/ were executed accordingly to carry out the goal of the project.


# Requirement 
- Turtlebot3: It is the newest generational mobile robot. It is a basic model to use AutoRace packages for autonomous driving on ROS. For this project, the TurtleBot3 Burger (with packages installed on it) was  provided by our university https://condorcet.u-bourgogne.fr/en.  The main components are shown below; 

![3](https://user-images.githubusercontent.com/62597513/145630186-4da6bcb0-b4aa-4c0d-b006-39453fabb56b.png)
source : https://www.robotis.us/turtlebot-3-burger-us/

- Ubuntu 18.04
- Camera - Raspberry Pi ‘fish-eye’ camera
- ROS-kinetic_Autorace_2020 and dependent ROS packages were installed on the system by cloning this github link https://github.com/ROBOTIS-GIT/turtlebot3_autorace 


# Project Architecture 
- Camera calibration:
  - Camera Imaging Calibration 
  - Instinct Camera Calibration
  - Extrinsic Camera Calibration
- Lane Detection.


# 1. Camera Calibration 
Geometric camera calibration estimates the parameters of a lens and image sensor of an image or video camera. These parameters could be used to correct lens distortion, measure the size of an object in world units, or determine the location of the camera in the scene.
Therefore, the camera mounted on our turtlebot3 is Raspberry Pi ‘fish-eye’ camera, thus, it has very large distortion. But the images needed for this project should have little distortion so as not to affect the image processing steps. To rectify the distortion, we mainly use the Ros-Kinetic Camera Imaging Calibration from https://emanual.robotis.com/docs/en/platform/turtlebot3/autonomous_driving_autorace/. The following describes how to simply calibrate the camera step by step;

   ## 1.1 Camera Imaging Calibration
   The camera imaging calibration was done using the rqt_reconfigure package to modify parameter values and enable the turtlebot3 mounted camera to see clear images. the contrast, brightness, sharpness, and saturation parameters for clarity of the system camera.
Thus, the modified parameters were overwritten in the camera.yaml file located in turtlebot3autorace_traffic_light_camera/calibration/camera_calibration folder. This will make the camera set its parameters for the next launch. Here is the result of the modified parameters;

  ## 1.2 Intrinsic Camera Calibration
  The Intrinsic parameters of a camera deals with the camera's internal characteristics like its focal length, skew, distortion, and image center. For this project, the intrinsic calibration was done using a 6x8 printed checkerboard. 
  ![Calibration](https://user-images.githubusercontent.com/62597513/145639462-6dd9fe60-accd-419f-ba43-865664e03ebc.jpeg)

  After the calibration, the **calibrationdata.tar.gz** folder was created at /tmp folder. We then extract the data from the ost.yalm file and save it in **turtlebot3_autorace_camera/calibration/intrinsic_calibration/camerav2_320x240_30fps.yaml**. The result is shown below; 
    ![Calparam](https://user-images.githubusercontent.com/62597513/145639716-aa910eb4-1fcf-4872-bca0-d34437297eab.jpeg)


  ## 1.3 Extrinsic Camera Calibration
The Extrinsic Camera calibration was done in order to acquire the robot pose and orientation. Firstly, the intrinsic modified calibration parameters were executed as such in **action mode** before running the Extrinsic calibration packages. The images below shows the **default image** and the **corrected image**;


# Lane Detection 



