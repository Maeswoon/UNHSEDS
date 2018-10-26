function [thrust] = GetThrust ( t )  

% ~ Competition Rocket Engines ~ 

% H159 - Booster Engine data (taken from thrustcurve.org)
xb_data = [0, 0.012, 0.032, .103, .171, .299, .511, .717, 1.272, 1.424,1.519,1.584,1.632,1.727,1.768,1.834,1.865,1.887]; % s
yb_data = cosd(25).*[0, 117, 158 , 177 ,  184,  185, 178, 179 , 162  , 159,152,149,146,89,109,25,10,0]; % N

% I204  - Sustainer Engine data (taken from thrustcurve.org)
xs_data_Raw = [0 0.01 0.012 0.03 0.3 0.5 0.7 1 1.1 1.2 1.3 1.4 1.5 1.6 1.72];
xs_data=xs_data_Raw+xb_data(end)+2;
ys_data = cosd(25).*[0 100 356 310 286 270 251 228 215 165 125 95 52 36 0];


% Uses data points to find the slope of the line between points and
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
    
    
elseif t > xb_data(17) && t <= xb_data(18)
    b17s = yb_data(18) - ((yb_data(18) - yb_data(17))/(xb_data(18) - xb_data(17)))*xb_data(18);
    thrust = ((yb_data(18) - yb_data(17))/(xb_data(18) - xb_data(17)))*t + b17s;
    


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