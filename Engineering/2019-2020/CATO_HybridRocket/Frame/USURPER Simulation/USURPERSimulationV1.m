%% USURPER Simulation V1
clear all 
close all 

%Initial Values
%Mass Components (g)
    %Nitrous Oxide Components 
    nitrousOxideTankEmpty  = 3968.93; 
    nitrousOxideTankFull = 9780.59;
    nitrousOxideMass = 5698.25;
%Drag Components
    dragForce = 0;          
    skinFrictionDrag = 0;         
    pressureDrag = 0;           
    baseDrag = 0;     
%Physical Components
    acceleration = 0;   
    velocity = 0;             
    height = 0.5; 
    thurst = 0;
%Time Components 
    timeStart = 0;  
    timeStep = 0.1; 
    timeStop = 200;
    

%Initial Vectors
%Mass Components (g)
    nitrousOxideMassVector = [];
%Drag Components 
    dragForceVector = []; 
    skinFrictionDragVector = [];
    pressureDragVector = []; 
    baseDragVector = []; 
%Physical Components 
    heightVector = []; 
    velocityVector = [];
    accelerationVector = [];
    thrustVector = [];
%Time Components 
    timeVector = []; 





%Pseudo Code
    %Step #1
        %Designate inital variables and vectors 
        %Determine total values
    %Step #2
        %Time step iteration. Calculation of each new variable. 
        %Note. Save each previous calculation for plot purposes. 
    %Step #3
        %
        


%% USURPER SimulationV1. GetAcceleration 
function [a, d] = GetAcceleration (t , v, h )
g = 9.81;
f = GetThrust ( t );
m = GetMass ( t );
[d] = GetDrag ( v,h,t );
a = ( f - m*g - d )/ m ; % Newton Second Law
end
