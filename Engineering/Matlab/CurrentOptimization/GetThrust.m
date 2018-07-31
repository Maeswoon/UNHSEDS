function [thrust] = GetThrust ( t )  

% ~ Competition Rocket Engines ~ 

% burntimeboost = .9;  % s
% burntimesust = 1.7;     % s
% startTimeboost = 1.9; % s (.9 + 1 second delay)
cruisetime=1; %Change to D array

% H340 - Booster Engine data (taken from thrustcurve.org)
xb_data = [0, 0.01, 0.04, 0.06, 0.62, 0.68, 0.7, 0.8, 0.85, 0.9]; % s
yb_data = [0, 5.00, 450 , 385 ,  375,  410, 400, 60 , 10  , 0]; % N

% I204  - Sustainer Engine data (taken from thrustcurve.org)
xs_data_Raw = [0 0.01 0.012 0.03 0.3 0.5 0.7 1 1.1 1.2 1.3 1.4 1.5 1.6 1.72];
xs_data=xs_data_Raw+xb_data(end)+cruisetime;
ys_data = [0 100 356 310 286 270 251 228 215 165 125 95 52 36 0];


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
elseif t > xs_data(14) && t <= xs_data(15)
    b14b = ys_data(15) - ((ys_data(15) - ys_data(14))/(xs_data(15) - xs_data(14)))*xs_data(15);
    thrust = ((ys_data(15) - ys_data(14))/(xs_data(15) - xs_data(14)))*t + b14b;
else
    thrust = 0;
end


end