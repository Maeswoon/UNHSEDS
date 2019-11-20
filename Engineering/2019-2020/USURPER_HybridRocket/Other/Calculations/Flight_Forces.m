% Forces calculated on rocket
clear all
close all
clc
%% Calculations after ignition
% Force of weight
masswet=9.78; % kg (21.563 lb)
massdry=3.97; % kg (3.97 lb)
massvec=linspace(masswet,massdry);
accelgrav=9.81; % m/s^2
weight=massvec*accelgrav;

% Force of thrust
f_thrust= ; %get data from hotfire test!!!!!!!
accel1=f_thrust/massvec;

% Forces due to drag: nose cone, skin, base, and fin

% nose cone
cdnose=.15; %value chosen, we need to do more research!!!!!
roeair=linspace(1.225,.9093); %density vector from 0 to 3000 meters kg/m^3
dia=7*.0254; % meters
vel1= ; % m/s need to determine this thru physics and accel1 vec!!!!!!
f_nose=.5*cdnose*roeair*(pi*(dia^2)/4)*(vel1^2);

% skin friction force

% base force (vaccum created under rocket when combustion is over)

% friction on fins (model as flat plates)
