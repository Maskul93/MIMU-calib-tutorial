%% Supplementary material for MIMUs calibration tutorial %%
% Creator: Guido Mascia, MSc, PhD Student at University of Rome "Foro Italico"
% Last Modified: 09/11/21

% clear all
% close all
% clc

% Global Variables
Fs = 1200;  % Sampling frequency
g = 9.81; % Gravity acceleration

load('./acc_triax.mat');  % Load accelerometer calibration trial
load('./gyr_static.mat'); % Load static gyroscope trial
load('./mag_sphere.mat'); % Load sphere magnetometer trial

%% Compute gyroscope STATIC bias
bias_gyr = get_gyr_bias(static_gyr);
static_gyr_unbiased = static_gyr - bias_gyr;    % Remove bias

% Integrate one axis to get orient (drift/no-drift)
t_gyr = linspace(0, length(static_gyr)/Fs, length(static_gyr));
theta = cumtrapz(t_gyr, static_gyr(:,1));
theta_unbiased = cumtrapz(t_gyr, static_gyr_unbiased(:,1));

figure
subplot(211); plot(t_gyr, static_gyr(:,1)); hold; plot(t_gyr, static_gyr_unbiased(:,1));
ylabel('Angular velocity (rad/s)')
subplot(212); plot(t_gyr, theta); hold; plot(t_gyr, theta_unbiased);
ylim([min(theta), 0.1]);
ylabel('Angle (rad)')
sgtitle('Biased (blue) vs. Unbiased (red) gyroscope')

%% Compute accelerometer offset and cross-axis sensitivity
[offs, sens] = get_acc_calib(static_acc, Fs);
static_acc_unbiased = ((static_acc(:,1)/g - offs(1)) * sens(1)) * g;

t_acc = linspace(0, length(static_acc)/Fs, length(static_acc));
figure
plot(t_acc, static_acc(:,1));
hold
plot(t_acc, static_acc_unbiased);
ylabel('Acceleration (m/s^2)'); xlabel('Time (s)');
sgtitle('Uncalibrated (blue) vs. Calibrated (red) accelerometer')

%% Compute magnetometer bias and scale factor
[bias, scalef] = get_mag_calib(static_mag);
N = length(static_mag);

kmest = diag(scalef); % scale factor
bmest = repmat(bias,N,1); % bias
static_mag_unbiased = kmest \ (static_mag - bmest)';    
static_mag_unbiased = static_mag_unbiased';

figure
plot3(static_mag(:,1), static_mag(:,2), static_mag(:,3), 'LineWidth', 1.3)
hold
plot3(static_mag_unbiased(:,1), static_mag_unbiased(:,2), static_mag_unbiased(:,3), 'LineWidth', 1.3)
xlabel('Hx (μT)'); ylabel('Hy (μT)'); zlabel('Hz (μT)');
sgtitle('Uncalibrated (blue) vs. Calibrated (red) magnetometer');
