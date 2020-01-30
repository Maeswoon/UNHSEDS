
clear all;
close all;

%% Static Test Fire Rig - (3/26/18 Test)

L = 'linewidth';
D = 'displayname';

% Import: Booster Data
enginedatabooster = xlsread('test_booster.xlsx');
xb = enginedatabooster(9:5007,1) - 4.53; % time
yb = enginedatabooster(9:5007,2); % V
xb(1309:1310) = []; % remove unwanted data points
yb(1309:1310) = [];

% Import: Sustainer Data
enginedatasustainer = xlsread('test_sustainer.xlsx');
xs = enginedatasustainer(9:5007,1) - 1.02; % time
ys = enginedatasustainer(9:5007,2); % V
xs(463:483) = []; % remove unwanted data points
ys(463:483) = [];
xs(503:511) = [];
ys(503:511) = [];

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
% figure
% plot(xb,yNboost,'b',L,1)
% title('Booster Thrust Response')
% xlabel('Time (s)')
% ylabel('Thrust (N)')
% axis([-0.5 1.5 -50 600]);
% grid minor

% Sustainer Thrust Response
% figure
% plot(xs,yNsust,'r',L,1)
% title('Sustainer Thrust Response')
% xlabel('Time (s)')
% ylabel('Thrust (N)')
% axis([-0.5 2.5 -50 600])
% grid minor

% Cesaroni H399 Data
h399x = [0.0 0.015 0.02 0.024 0.05 0.075 0.1 0.2 0.53 0.55 0.575 0.64 0.685 0.71];
h399y = [0 10 320 555 490 475 468 463 451 460 400 200 25 0];
% Cesaroni I204 Data
i204x = [0 0.01 0.012 0.03 0.3 0.5 0.7 1 1.1 1.2 1.3 1.4 1.5 1.6 1.72];
i204y = [0 100 356 310 286 270 251 228 215 165 125 95 52 36 0];

% Booster - Sustainer Thrust Subplot
figure
subplot(2,1,1)
hold on
plot(xb,yNboost,'r',D,'Experimental',L,2)
plot(h399x,h399y,'k',D,'Supplied Data',L,2)
title('Thrust Response: Booster')
% xlabel('Time (s)')
ylabel('Thrust (N)')
% axis([-0.5 1.5 -50 600]);
axis([-0.5 2 -50 600]);
legend('show')
grid minor

subplot(2,1,2)
hold on
plot(xs,yNsust,'r',D,'Experimental',L,2)
plot(i204x,i204y,'k',D,'Supplied Data',L,2)
title('Thrust Response: Sustainer')
xlabel('Time (s)')
ylabel('Thrust (N)')
axis([-0.5 2 -50 600])
grid minor

% Booster Impulse - Test
yIboost = cumtrapz(xb,yNboost); % integrate booster thrust data for impulse

% Sustainer Impulse - Test
yIsust = cumtrapz(xs,yNsust); % integrate sustainer thrust data for impulse
xs = xs + 1.782;
yIsust = yIsust + 277.1;

% Cesaroni Official Impulse
h399I = cumtrapz(h399x,h399y); 

i204x = i204x + 1.71;
i204I = cumtrapz(i204x,i204y);
i204I = i204I + 282.2;

linex = linspace(0.71,1.71,10);
liney = linspace(282.2,282.2,10);
impulse_x = [h399x linex i204x];
impulse_y = [h399I liney i204I];

%% Booster - Sustainer Total Impulse
figure
hold on
plot(xb(1:1322),yIboost(1:1322),'b',D,'Booster Experimental',L,2)
plot(xs(1:661),yIsust(1:661),'r',D,'Sustainer Experimental',L,2)
plot(impulse_x,impulse_y,'k--',D,'Cesaroni Data',L,1)
title('Total Impulse vs Time')
xlabel('Time (s)')
ylabel('Impulse (N-s)')
axis([0 4 0 700])
legend('show','location','southeast')
grid minor

