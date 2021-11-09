# MIMU-calib-tutorial
Supplementary material for Internship lectures about MIMUs calibration procedures. 

- ```./do_show_something.m``` Main script
- ```./data``` Folder containing the trials for MIMU calibration
  - ```./data/acc_triax.mat``` Accelerometer tri-axes trial
  - ```./data/gyr_static.mat``` Gyroscope static trial (60 seconds)
  - ```./data/mag_spheere.mat``` Magnetometer sphere drawing trial
- ```./functions``` Folder containing all the routines required for sensors calibration
  - ```./functions/accSolver.m``` Core solver for the optimization problem aiming at estimating offset and cross-axis sensitivity for the three accelerometer axes
  - ```./functions/get_acc_calib.m``` Routine that allows to select the static windows in which each of the axes points towards the positive gravity direction
  - ```./get_gyr_bias.m``` Self-explanatory
  - ```./get_mag_calib.m``` Routine allowing magnetometer bias and scale factor computation from the sphere trial
  - ```./get_static_acc_windows.m``` Self-explanatory

# Contacts
Guido Mascia: mascia.guido@gmail.com
