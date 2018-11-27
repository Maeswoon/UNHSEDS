function [thrust] = GetThrust ( t )  

% ~ Spaceport Rocket ~ %

% G54  - Sustainer Engine data (taken from thrustcurve.org)
xs_data = [0 0.018 0.031 0.059 0.135 0.22 0.299 0.432 0.959 1.757 2.418 2.851 2.98 3.0]; % s
ys_data = [0 107.3 113.6 103.5 121.7 104.6 95.5 88.3 69.7 43.5 20.76 9.48 5.57 0]; % N

% uses data points to find the slope of the line between points and
% estimate the thrust as time iterates through the function

    
% ~ SUSTAINER FIRES ~
if t > xs_data(1) && t <= xs_data(2)
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