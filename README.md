# AUTONOMOUS DRIVING OF TURTLEBOT3

<img align="left" width="200" height="100" src="https://user-images.githubusercontent.com/62597513/145659645-9ab35c4d-694e-499d-8fad-6bf1091d32ec.jpeg">
<img align="right" width="180" height="100" src="https://user-images.githubusercontent.com/62597513/150416328-160de66a-30b7-4a78-960b-b74db8ab4096.jpeg">




### Prepared by:
#### Lateef Olalekan Aderinoye and Olarinde Fatai Jimoh

<p align="center">
   Supervised by: 
   Duverne Raphaek,
   Seulin Ralph,
   Rodriguez J. Joaquin,
   Martins Renato.   
</p>


![_msr-peng_Self-Driving-Turtlebot3_blob_master_pictures_turtlebot-3](https://user-images.githubusercontent.com/62597513/145625174-0cad437b-5282-46da-a499-9244b2de4d8d.jpg)



# Problem Statement 
This project focuses on elementary turtlebot3 self-driving, which drives between two detected lanes. The project is to solve an autonomous driving lane tracking challenge, and all steps taken which have been described in [Turtlebot3 E-Manual Robotics](https://emanual.robotis.com/docs/en/platform/turtlebot3/autonomous_driving_autorace/) were executed accordingly to carry out the goal of the project.

https://user-images.githubusercontent.com/62597513/150421051-bb5bd40e-cd7a-4a18-870d-ed67f65a056b.mov



# Requirement 
- **Turtlebot3**: It is the newest generational mobile robot. It is a basic model to use AutoRace packages for autonomous driving on ROS. For this project, the TurtleBot3 Burger (with packages installed on it) was  provided by our [university](https://condorcet.u-bourgogne.fr/en).  The main components are shown below: 

![3](https://user-images.githubusercontent.com/62597513/145630186-4da6bcb0-b4aa-4c0d-b006-39453fabb56b.png)

source : https://www.robotis.us/turtlebot-3-burger-us/

- The system was run through a **stationary PC**, connected to the TurtleBot3 running **Ubuntu 18.04**
- Camera - **Raspberry Pi ‘fish-eye’** camera
- **ROS-Autorace_2020** and **dependent ROS packages** were installed on the system by cloning this github link [TurtleBot3 AutoRace](https://github.com/ROBOTIS-GIT/turtlebot3_autorace) 


# Project Architecture 
- Camera calibration:
  - Camera Imaging Calibration 
  - Instinct Camera Calibration
  - Extrinsic Camera Calibration
- Lane Detection.


# 1. Camera Calibration 
Geometric camera calibration estimates the parameters of a lens and image sensor of an image or video camera. These parameters could be used to correct lens distortion, measure the size of an object in world units, or determine the location of the camera in the scene.
Therefore, the camera mounted on our turtlebot3 is Raspberry Pi ‘fish-eye’ camera, thus, it has very large distortion. But the images needed for this project should have little distortion so as not to affect the image processing steps. To achieve this, we followed the description to run the **commands** from [Turtlebot3 E-Manual Robotics](https://emanual.robotis.com/docs/en/platform/turtlebot3/autonomous_driving/) for the  **Camera Imaging Calibration**, **Intrinsic Camera Calibration** and **Extrinsic Camera Calibration**. 

   ## 1.1 Camera Imaging Calibration
The camera imaging calibration was done by executing the **rqt_reconfigure** to modify the camera parameter values and enable the turtlebot3 mounted camera to see clear images as such, the contrast, brightness, sharpness, and saturation parameters for clarity of the system camera.
Thus, the modified parameters were overwritten in the **camera.yaml** file located in **turtlebot3autorace_traffic_light_camera/calibration/camera_calibration** folder. This will make the camera set its parameters for the next launch. Here is the result of the modified image and parameters:

![clear_image](https://user-images.githubusercontent.com/62597513/145644291-e0759511-8460-455e-88c7-f2727d1429b2.jpeg) 

![Clearimageparam](https://user-images.githubusercontent.com/62597513/145644866-494950ef-4c39-4e47-8af6-533b4a35513d.jpeg)


  ## 1.2 Intrinsic Camera Calibration
The Intrinsic parameters of a camera deals with the camera's internal characteristics like its focal length, skew, distortion, and image center. For this project, the intrinsic calibration was done using a **6x8** printed checkerboard. The checkerboard was moved vertically on the x axis and horizontally on the y axis, well oriented in different directions for the skew and was moved farther and closer for the size. The GUI variables turn green after getting enough translation and orientation which as such means it's ready to be calibrated. 

  ![calib](https://user-images.githubusercontent.com/62597513/145724660-7f41fb6e-d65a-4d10-983d-992b7f921158.jpeg)

  
  After the calibration, the **calibrationdata.tar.gz** folder was created at /tmp folder. We then extract the data from the ost.yalm file and save it in **turtlebot3_autorace_camera/calibration/intrinsic_calibration/camerav2_320x240_30fps.yaml**. The result is shown below: 
  
  ![intrinsic](https://user-images.githubusercontent.com/62597513/145728099-b0191d35-2319-472d-a93d-040b2c7cd0f0.jpeg)


  ## 1.3 Extrinsic Camera Calibration
The Extrinsic Camera calibration was done in order to acquire the robot pose and orientation. To get these done, we launched the intrinsic modified calibration parameters as such in **action mode** before running the Extrinsic calibration packages. The Extrinsic Camera Calibration launch file basically runs two source code **image_compensation.py** and **image_projection.py**. It then published **/camera/image_extrinsic_calib/compressed** which is the default image showing the unaligned red border according to 4 image coordinates and **/camera/image_projected_compensated** “birds-eye view” image showing the scale of the image brightness contrast of the compressed image according to the **clip_hist_percent** parameter defined after running the **rqt**. The images below shows the **default image** and **compensated image**:

![Default and compensated](https://user-images.githubusercontent.com/62597513/145770057-71554f32-dfe2-45f1-bd91-8abfcc32a3b5.jpeg)


Then we excuted **rqt_reconfigure** to adjust the parameters and the modifed parameters were saved in **turtlebot3_autorace_camera/calibration/extrinsic_calibration/projection.yaml** and **turtlebot3_autorace_camera/calibration/extrinsic_calibration/compensation.yaml files**.

![Extrinsic_para](https://user-images.githubusercontent.com/62597513/145728490-523fb317-8ae6-4d97-b6f6-7b3c958adb77.jpeg)

Below shows the image of the **modified image**: 

![extrinsic_modified](https://user-images.githubusercontent.com/62597513/145769260-2cd0bdf2-8303-4f9f-916d-d8010605e4a7.jpeg)



# 2. Lane Detection 
The Lane detection package allows Turtlebot3 to drive between two lanes without external influence. The robot was placed on the lane whereby the **yellow line** was on the left side of the robot, and the **white line** was placed on the right side of the robot. Here, the lane detection packages [Turtlebot3 E-Manual Robotics](https://emanual.robotis.com/docs/en/platform/turtlebot3/autonomous_driving/) were executed and the launch file basically runs the lane detection source code **detect_lane.py**. The nodes publishes the below topics after running the **rqt**:   
- **/detect/image_white_lane_marker/compressed**
- **/detect/image_yellow_lane_marker/compressed**
- **/detect/image_lane/compessed** which contains the reference line for the turtlebot3  trajectory.  

From here, we adjust the filter parameters by doing the **thresholding** of the **HSL** (hue, saturation and lightness) using the **rqt_reconfigure** to fine-tune the lines and the direction as such, the red line was overlaid on the yellow line while the blue line was overlaid on the white line. To achieve this, we followed the description to run the commands from 

![Detect_lane_rqt](https://user-images.githubusercontent.com/62597513/145726782-9479f51c-ba69-4f9b-9baa-bd35f3cd3ee6.jpeg)

The **HSL** (hue, saturation and lightness) is a cylindrical color model that remaps the RGB primary colors into dimensions. It is important to note that the three dimensions of the HSL color model are interdependent. If the value dimension of a color is set to 0%, the amount of hue and saturation does not matter as the color will be black. Likewise, if the saturation of a color is set to 0%, the hue does not matter as there is no color used. [source](https://programmingdesignsystems.com/color/color-models-and-color-spaces/index.html)

Prior to our **specific goal** i.e turtlebot3 passing through a **Big Tunnel**, we placed the turtlebot3 close to the **Big Tunnel** to fine-tune the parameters value. We had the idea that if the turtlebot3 can detect the lanes in a darker environment  then it will easily detect the lanes in a lightning environment. 

![lane_D](https://user-images.githubusercontent.com/62597513/145658830-e65d4af2-d79d-45e4-b165-ba2b25b01b1a.jpeg)

After the fine-tuning,  we then write the modified values of the **lane.yaml** file located in **turtlebot3autorace_traffic_light_detect/param/lane/**.


# 3. Result with Commented Demo
As seen in the Demo, the goal of the project was achieved. The Turtlebot3 drives by detecting the lanes perfectly and successfully passed through the Big Tunnel on different occasions. 

https://user-images.githubusercontent.com/62597513/145721528-159b6d89-24ba-46d6-98df-98c78fc33d83.mp4


# 4. Limitation/Stretch goal
The workflow seems not much complicated other than some external constraints such as the environment light intensity. This has a great effect on the camera projection which makes it difficult for the turtlebot3 to maintain consistency, specifically passing through the big tunnel.  

We started the traffic light detection but couldn't complete it because of time constraints and  the thresholding process seems to be the biggest challenge. 

Our longtime goal is to complete the traffic light detection and work further on other missions on the Turtlebot3 Autorace challenge for personal development. Therefore, we tend to edit this project after  the implementation of the other Turtlebot3 Autorace tasks. 

# 5. Conclusion
This project focuses on driving the robot without external force by detecting two lanes as such, colour detection. The project was achieved  following the steps on https://emanual.robotis.com/docs/en/platform/turtlebot3/autonomous_driving/.  

[Powerpoint](https://docs.google.com/presentation/d/1Ll4vH2Ak7FGH3H24J7C4lTwDl5MHA5EaLxJSeM-wxW8/edit#slide=id.gfb1d192b96_0_13)
