
clear all;
close all;

%% Static Test Fire Rig - (3/26/18 Test)

L = 'linewidth';
D = 'displayname';
nheaderlines = 21;

% Import: Booster Data
enginedatabooster = xlsread('test_booster.xlsx');
xb = enginedatabooster(9:5008,1) - 4.53; % time
yb = enginedatabooster(9:5008,2); % V

% Import: Sustainer Data
enginedatasustainer = xlsread('test_sustainer.xlsx');
xs = enginedatasustainer(9:5008,1) - 1.02; % time
ys = enginedatasustainer(9:5008,2); % V

% Load Cell Calibration (used to find load cell sensitivity)
mass    = [   0 2212 4130 5536 ]*10^-3; % kg
voltage = [ 320  477  620  724 ]*10^-3; % V

p = polyfit(mass,voltage,1);
bestfit = p(1)*mass + p(2);
figure
plot(mass,bestfit,'r--',D,'Bestfit Line',L,1)
title('Load Cell Calibration')
xlabel('Mass (kg)')
ylabel('Voltage (V)')
hold on
plot(mass,voltage,'b*',D,'Data Points',L,1)
legend('show','location','northwest')
grid minor

% Load Cell Sensitivity (used to convert load cell output to N)
sens = p(1); % V/kg
ylbboost = (yb/p(1))*2.20462262; % lb (convert from kg to lb)
ylbsust  = (ys/p(1))*2.20462262; % lb (convert from kg to lb)
yNboost  = ylbboost*4.4482216;   % N  (convert from lb to N)
yNsust   = ylbsust*4.4482216;    % N  (concert from lb to N)
yNboost  = yNboost - 50;
yNsust   = yNsust  - 50.7;

% Booster Thrust Response
figure
plot(xb,yNboost,'b',L,1)
title('Booster Thrust Response')
xlabel('Time (s)')
ylabel('Thrust (N)')
axis([-0.5 1.5 -50 600]);
grid minor

% Sustainer Thrust Response
figure
plot(xs,yNsust,'r',L,1)
title('Sustainer Thrust Response')
xlabel('Time (s)')
ylabel('Thrust (N)')
axis([-0.5 2.5 -150 1200])
grid minor

% Booster - Sustainer Subplot
figure
subplot(2,1,1)
plot(xb,yNboost,'b',L,1)
title('Thrust Response: Booster')
xlabel('Time (s)')
ylabel('Thrust (N)')
axis([-0.5 1.5 -50 600]);
grid minor
subplot(2,1,2)
plot(xs,yNsust,'r',L,1)
title('Thrust Response: Sustainer')
xlabel('Time (s)')
ylabel('Thrust (N)')
axis([-0.82 2.5 -150 1200])
grid minor


