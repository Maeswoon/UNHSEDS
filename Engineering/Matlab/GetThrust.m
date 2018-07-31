function [thrust] = GetThrust ( t )  

% ~ AETHER4 ~

% burntimeboost = 1.3;  % s
% burntimesust = 3;     % s
% startTimeboost = 2.3; % s (1.3 + 1 second delay)

% G125 - Booster Engine data (taken from thrustcurve.org)
xb_data = [0 0.01 0.025 0.03 0.037 0.044 0.055 0.1 0.19 0.27 0.4 0.94 1.05 1.13 1.19 1.22 1.3]; % s
yb_data = [0 5 155 169 160 127 118 140 148 152 151 126 125 108 40 20 0]; % N

% G54  - Sustainer Engine data (taken from thrustcurve.org)
xs_data = [0 0.018 0.031 0.059 0.135 0.22 0.299 0.432 0.959 1.757 2.418 2.851 2.98 3.0] + 2.3; % s
ys_data = [0 107.3 113.6 103.5 121.7 104.6 95.5 88.3 69.7 43.5 20.76 9.48 5.57 0]; % N

% uses data points to find the slope of the line between points and
% estimate the thrust as time iterates through the function

% ~ BOOSTER FIRES ~
if t > xb_data(1) && t <= xb_data(2)
    b1s = yb_data(2) - ((yb_data(2) - yb_data(1))/(xb_data(2) - xb_data(1)))*xb_data(2);
    thrust = ((yb_data(2) - yb_data(1))/(xb_data(2) - xb_data(1)))*t + b1s;
    
elseif t > xb_data(2) && t <= xb_data(3)
    b2s = yb_data(3) - ((yb_data(3) - yb_data(2))/(xb_data(3) - xb_data(2)))*xb_data(3);
    thrust = ((yb_data(3) - yb_data(2))/(xb_data(3) - xb_data(2)))*t + b2s;
    
elseif t > xb_data(3) && t <= xb_data(4)
    b3s = yb_data(4) - ((yb_data(4) - yb_data(3))/(xb_data(4) - xb_data(3)))*xb_data(4);
    thrust = ((yb_data(4) - yb_data(3))/(xb_data(4) - xb_data(3)))*t + b3s;
    
elseif t > xb_data(4) && t <= xb_data(5)
    b4s = yb_data(5) - ((yb_data(5) - yb_data(4))/(xb_data(5) - xb_data(4)))*xb_data(5);
    thrust = ((yb_data(5) - yb_data(4))/(xb_data(5) - xb_data(4)))*t + b4s;
    
elseif t > xb_data(5) && t <= xb_data(6)
    b5s = yb_data(6) - ((yb_data(6) - yb_data(5))/(xb_data(6) - xb_data(5)))*xb_data(6);
    thrust = ((yb_data(6) - yb_data(5))/(xb_data(6) - xb_data(5)))*t + b5s;
    
elseif t > xb_data(6) && t <= xb_data(7)
    b6s = yb_data(7) - ((yb_data(7) - yb_data(6))/(xb_data(7) - xb_data(6)))*xb_data(7);
    thrust = ((yb_data(7) - yb_data(6))/(xb_data(7) - xb_data(6)))*t + b6s;
    
elseif t > xb_data(7) && t <= xb_data(8)
    b7s = yb_data(8) - ((yb_data(8) - yb_data(7))/(xb_data(8) - xb_data(7)))*xb_data(8);
    thrust = ((yb_data(8) - yb_data(7))/(xb_data(8) - xb_data(7)))*t + b7s;
    
elseif t > xb_data(8) && t <= xb_data(9)
    b8s = yb_data(9) - ((yb_data(9) - yb_data(8))/(xb_data(9) - xb_data(8)))*xb_data(9);
    thrust = ((yb_data(9) - yb_data(8))/(xb_data(9) - xb_data(8)))*t + b8s;
    
elseif t > xb_data(9) && t <= xb_data(10)
    b9s = yb_data(10) - ((yb_data(10) - yb_data(9))/(xb_data(10) - xb_data(9)))*xb_data(10);
    thrust = ((yb_data(10) - yb_data(9))/(xb_data(10) - xb_data(9)))*t + b9s;
    
elseif t > xb_data(10) && t <= xb_data(11)
    b10s = yb_data(11) - ((yb_data(11) - yb_data(10))/(xb_data(11) - xb_data(10)))*xb_data(11);
    thrust = ((yb_data(11) - yb_data(10))/(xb_data(11) - xb_data(10)))*t + b10s;
    
elseif t > xb_data(11) && t <= xb_data(12)
    b11s = yb_data(12) - ((yb_data(12) - yb_data(11))/(xb_data(12) - xb_data(11)))*xb_data(12);
    thrust = ((yb_data(12) - yb_data(11))/(xb_data(12) - xb_data(11)))*t + b11s;
    
elseif t > xb_data(12) && t <= xb_data(13)
    b12s = yb_data(13) - ((yb_data(13) - yb_data(12))/(xb_data(13) - xb_data(12)))*xb_data(13);
    thrust = ((yb_data(13) - yb_data(12))/(xb_data(13) - xb_data(12)))*t + b12s;

elseif t > xb_data(13) && t <= xb_data(14)
    b13s = yb_data(14) - ((yb_data(14) - yb_data(13))/(xb_data(14) - xb_data(13)))*xb_data(14);
    thrust = ((yb_data(14) - yb_data(13))/(xb_data(14) - xb_data(13)))*t + b13s;
    
elseif t > xb_data(14) && t <= xb_data(15)
    b14s = yb_data(15) - ((yb_data(15) - yb_data(14))/(xb_data(15) - xb_data(14)))*xb_data(15);
    thrust = ((yb_data(15) - yb_data(14))/(xb_data(15) - xb_data(14)))*t + b14s;
    
elseif t > xb_data(15) && t <= xb_data(16)
    b15s = yb_data(16) - ((yb_data(16) - yb_data(15))/(xb_data(16) - xb_data(15)))*xb_data(16);
    thrust = ((yb_data(16) - yb_data(15))/(xb_data(16) - xb_data(15)))*t + b15s;
    
elseif t > xb_data(16) && t <= xb_data(17)
    b16s = yb_data(17) - ((yb_data(17) - yb_data(16))/(xb_data(17) - xb_data(16)))*xb_data(17);
    thrust = ((yb_data(17) - yb_data(16))/(xb_data(17) - xb_data(16)))*t + b16s;
    

% ~ SUSTAINER FIRES ~
elseif t > xs_data(1) && t <= xs_data(2)
    b1b = ys_data(2) - ((ys_data(2) - ys_data(1))/(xs_data(2) - xs_data(1)))*xs_data(2);
    thrust = ((ys_data(2) - ys_data(1))/(xs_data(2) - xs_data(1)))*t + b1b;
    
elseif t > xs_data(2) && t <= xs_data(3)
    b2b = ys_data(3) - ((ys_data(3) - ys_data(2))/(xs_data(3) - xs_data(2)))*xs_data(3);
    thrust = ((ys_data(3) - ys_data(2))/(xs_data(3) - xs_data(2)))*t + b2b;
    
elseif t > xs_data(3) && t <= xs_data(4)
    b3b = ys_data(4) - ((ys_data(4) - ys_data(3))/(xs_data(4) - xs_data(3)))*xs_data(4);
    thrust = ((ys_data(4) - ys_data(3))/(xs_data(4) - xs_data(3)))*t + b3b;
    
elseif t > xs_data(4) && t <= xs_data(5)
    b4b = ys_data(5) - ((ys_data(5) - ys_data(4))/(xs_data(5) - xs_data(4)))*xs_data(5);
    thrust = ((ys_data(5) - ys_data(4))/(xs_data(5) - xs_data(4)))*t + b4b;
elseif t > xs_data(5) && t <= xs_data(6)
    b5b = ys_data(6) - ((ys_data(6) - ys_data(5))/(xs_data(6) - xs_data(5)))*xs_data(6);
    thrust = ((ys_data(6) - ys_data(5))/(xs_data(6) - xs_data(5)))*t + b5b;
    
elseif t > xs_data(6) && t <= xs_data(7)
    b6b = ys_data(7) - ((ys_data(7) - ys_data(6))/(xs_data(7) - xs_data(6)))*xs_data(7);
    thrust = ((ys_data(7) - ys_data(6))/(xs_data(7) - xs_data(6)))*t + b6b;
    
elseif t > xs_data(7) && t <= xs_data(8)
    b7b = ys_data(8) - ((ys_data(8) - ys_data(7))/(xs_data(8) - xs_data(7)))*xs_data(8);
    thrust = ((ys_data(8) - ys_data(7))/(xs_data(8) - xs_data(7)))*t + b7b;
    
elseif t > xs_data(8) && t <= xs_data(9)
    b8b = ys_data(9) - ((ys_data(9) - ys_data(8))/(xs_data(9) - xs_data(8)))*xs_data(9);
    thrust = ((ys_data(9) - ys_data(8))/(xs_data(9) - xs_data(8)))*t + b8b;
    
elseif t > xs_data(9) && t <= xs_data(10)
    b9b = ys_data(10) - ((ys_data(10) - ys_data(9))/(xs_data(10) - xs_data(9)))*xs_data(10);
    thrust = ((ys_data(10) - ys_data(9))/(xs_data(10) - xs_data(9)))*t + b9b;
    
elseif t > xs_data(10) && t <= xs_data(11)
    b10b = ys_data(11) - ((ys_data(11) - ys_data(10))/(xs_data(11) - xs_data(10)))*xs_data(11);
    thrust = ((ys_data(11) - ys_data(10))/(xs_data(11) - xs_data(10)))*t + b10b;
    
elseif t > xs_data(11) && t <= xs_data(12)
    b11b = ys_data(12) - ((ys_data(12) - ys_data(11))/(xs_data(12) - xs_data(11)))*xs_data(12);
    thrust = ((ys_data(12) - ys_data(11))/(xs_data(12) - xs_data(11)))*t + b11b;
    
elseif t > xs_data(12) && t <= xs_data(13)
    b12b = ys_data(13) - ((ys_data(13) - ys_data(12))/(xs_data(13) - xs_data(12)))*xs_data(13);
    thrust = ((ys_data(13) - ys_data(12))/(xs_data(13) - xs_data(12)))*t + b12b;
    
elseif t > xs_data(13) && t <= xs_data(14)
    b13b = ys_data(14) - ((ys_data(14) - ys_data(13))/(xs_data(14) - xs_data(13)))*xs_data(14);
    thrust = ((ys_data(14) - ys_data(13))/(xs_data(14) - xs_data(13)))*t + b13b;
else
    thrust = 0;
end


end