function [thrust] = GetThrust ( time )  

% ~ Spaceport Rocket ~ %

% G54  - Sustainer Engine data (taken from thrustcurve.org)
thrustCurve = 4.44822*[0,75,200,225,250,275,300,300,300,300,300,300,200,50,0]; %Thrust curve with corresponding %Thrust (N) 1 lbf * 4.44822 = (N)
timeCurve = [0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0];

% xs_data = [0, 1, 2,  3,  8,  9,  10,11]; % s
% ys_data = [1900,1800,1700,1450,1200,900,600,0]; % N

% uses data points to find the slope of the line between points and
% estimate the thrust as time iterates through the function

    
% ~ SUSTAINER FIRES ~
%Inital Assumptions 
    %Mass Components (g)
            %Thrust Curve Integration
            if time >= timeCurve(1) && time <= timeCurve(2)
                thrustSlope = thrustCurve(2) - ((thrustCurve(2) - thrustCurve(1))/(timeCurve(2) - timeCurve(1)))*timeCurve(2);
                thrust = ((thrustCurve(2) - thrustCurve(1))/(timeCurve(2) - timeCurve(1)))*time + thrustSlope;

            elseif time > timeCurve(2) && time <= timeCurve(3)
                thrustSlope = thrustCurve(3) - ((thrustCurve(3) - thrustCurve(2))/(timeCurve(3) - timeCurve(2)))*timeCurve(3);
                thrust = ((thrustCurve(3) - thrustCurve(2))/(timeCurve(3) - timeCurve(2)))*time + thrustSlope;

            elseif time > timeCurve(3) && time <= timeCurve(4)
                thrustSlope = thrustCurve(4) - ((thrustCurve(4) - thrustCurve(3))/(timeCurve(4) - timeCurve(3)))*timeCurve(4);
                thrust = ((thrustCurve(4) - thrustCurve(3))/(timeCurve(4) - timeCurve(3)))*time + thrustSlope;

            elseif time > timeCurve(4) && time <= timeCurve(5)
                thrustSlope = thrustCurve(5) - ((thrustCurve(5) - thrustCurve(4))/(timeCurve(5) - timeCurve(4)))*timeCurve(5);
                thrust = ((thrustCurve(5) - thrustCurve(4))/(timeCurve(5) - timeCurve(4)))*time + thrustSlope;
            elseif time > timeCurve(5) && time <= timeCurve(6)
                thrustSlope = thrustCurve(6) - ((thrustCurve(6) - thrustCurve(5))/(timeCurve(6) - timeCurve(5)))*timeCurve(6);
                thrust = ((thrustCurve(6) - thrustCurve(5))/(timeCurve(6) - timeCurve(5)))*time + thrustSlope;

            elseif time > timeCurve(6) && time <= timeCurve(7)
                thrustSlope = thrustCurve(7) - ((thrustCurve(7) - thrustCurve(6))/(timeCurve(7) - timeCurve(6)))*timeCurve(7);
                thrust = ((thrustCurve(7) - thrustCurve(6))/(timeCurve(7) - timeCurve(6)))*time + thrustSlope;

            elseif time > timeCurve(7) && time <= timeCurve(8)
                thrustSlope = thrustCurve(8) - ((thrustCurve(8) - thrustCurve(7))/(timeCurve(8) - timeCurve(7)))*timeCurve(8);
                thrust = ((thrustCurve(8) - thrustCurve(7))/(timeCurve(8) - timeCurve(7)))*time + thrustSlope;

            elseif time > timeCurve(8) && time <= timeCurve(9)
                thrustSlope = thrustCurve(9) - ((thrustCurve(9) - thrustCurve(8))/(timeCurve(9) - timeCurve(8)))*timeCurve(9);
                thrust = ((thrustCurve(9) - thrustCurve(8))/(timeCurve(9) - timeCurve(8)))*time + thrustSlope;

            elseif time > timeCurve(9) && time <= timeCurve(10)
                thrustSlope = thrustCurve(10) - ((thrustCurve(10) - thrustCurve(9))/(timeCurve(10) - timeCurve(9)))*timeCurve(10);
                thrust = ((thrustCurve(10) - thrustCurve(9))/(timeCurve(10) - timeCurve(9)))*time + thrustSlope;

            elseif time > timeCurve(10) && time <= timeCurve(11)
                thrustSlope = thrustCurve(11) - ((thrustCurve(11) - thrustCurve(10))/(timeCurve(11) - timeCurve(10)))*timeCurve(11);
                thrust = ((thrustCurve(11) - thrustCurve(10))/(timeCurve(11) - timeCurve(10)))*time + thrustSlope;
            
            elseif time > timeCurve(11) && time <= timeCurve(12)
                thrustSlope = thrustCurve(12) - ((thrustCurve(12) - thrustCurve(11))/(timeCurve(12) - timeCurve(11)))*timeCurve(12);
                thrust = ((thrustCurve(12) - thrustCurve(11))/(timeCurve(12) - timeCurve(11)))*time + thrustSlope;

            elseif time > timeCurve(12) && time <= timeCurve(13)
                thrustSlope = thrustCurve(13) - ((thrustCurve(13) - thrustCurve(12))/(timeCurve(13) - timeCurve(12)))*timeCurve(13);
                thrust = ((thrustCurve(13) - thrustCurve(12))/(timeCurve(13) - timeCurve(12)))*time + thrustSlope;

            elseif time > timeCurve(13) && time <= timeCurve(14)
                thrustSlope = thrustCurve(14) - ((thrustCurve(14) - thrustCurve(13))/(timeCurve(14) - timeCurve(13)))*timeCurve(14);
                thrust = ((thrustCurve(14) - thrustCurve(13))/(timeCurve(14) - timeCurve(13)))*time + thrustSlope;

            else
                thrust = 0;
            end


% if t >= xs_data(1) && t <= xs_data(2)
%     b1b = ys_data(2) - ((ys_data(2) - ys_data(1))/(xs_data(2) - xs_data(1)))*xs_data(2);
%     thrust = ((ys_data(2) - ys_data(1))/(xs_data(2) - xs_data(1)))*t + b1b;
%     
% elseif t > xs_data(2) && t <= xs_data(3)
%     b2b = ys_data(3) - ((ys_data(3) - ys_data(2))/(xs_data(3) - xs_data(2)))*xs_data(3);
%     thrust = ((ys_data(3) - ys_data(2))/(xs_data(3) - xs_data(2)))*t + b2b;
%     
% elseif t > xs_data(3) && t <= xs_data(4)
%     b3b = ys_data(4) - ((ys_data(4) - ys_data(3))/(xs_data(4) - xs_data(3)))*xs_data(4);
%     thrust = ((ys_data(4) - ys_data(3))/(xs_data(4) - xs_data(3)))*t + b3b;
%     
% elseif t > xs_data(4) && t <= xs_data(5)
%     b4b = ys_data(5) - ((ys_data(5) - ys_data(4))/(xs_data(5) - xs_data(4)))*xs_data(5);
%     thrust = ((ys_data(5) - ys_data(4))/(xs_data(5) - xs_data(4)))*t + b4b;
% elseif t > xs_data(5) && t <= xs_data(6)
%     b5b = ys_data(6) - ((ys_data(6) - ys_data(5))/(xs_data(6) - xs_data(5)))*xs_data(6);
%     thrust = ((ys_data(6) - ys_data(5))/(xs_data(6) - xs_data(5)))*t + b5b;
%     
% elseif t > xs_data(6) && t <= xs_data(7)
%     b6b = ys_data(7) - ((ys_data(7) - ys_data(6))/(xs_data(7) - xs_data(6)))*xs_data(7);
%     thrust = ((ys_data(7) - ys_data(6))/(xs_data(7) - xs_data(6)))*t + b6b;
%     
% elseif t > xs_data(7) && t <= xs_data(8)
%     b7b = ys_data(8) - ((ys_data(8) - ys_data(7))/(xs_data(8) - xs_data(7)))*xs_data(8);
%     thrust = ((ys_data(8) - ys_data(7))/(xs_data(8) - xs_data(7)))*t + b7b;
%     
% 
% else
%     thrust = 0;
% end


end