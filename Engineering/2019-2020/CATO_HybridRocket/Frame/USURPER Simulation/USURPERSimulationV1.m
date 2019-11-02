%% USURPER Simulation V1
clear all 
close all 

%Initial Values
%Time Components 
    timeStart = 0;  
    timeStep = 0.1; 
    timeStop = 200;
%Drag Components
    dragForce = 0;          
    skinFrictionDrag = 0;         
    pressureDrag = 0;           
    baseDrag = 0;     
%Physical Components
    gravitationalAcceleration = 9.81;
    rocketAcceleration = 0;   
    velocity = 0;             
    height = 0.5; 
    thurst = 0;
%Mass Components (g)
    %Nitrous Oxide Components 
    nitrousOxideTankEmpty  = 3968.93; 
    nitrousOxideTankFull = 9780.59;
    nitrousOxideMass = 5698.25;
    nitriousOxideMassFullFlowRate = 907.185/timeStep; %2 lbs/s flow rate in grams
    nitriousOxideMassHalfFlowRate = 453.592/timeStep; %1 lbs/s flow rate in grams
    flowRate = 0;
    totalMass = 0; %CHANGE
    

    
%Initial Vectors
%Mass Components (g)
    nitrousOxideMassVector = [];
    totalMassVector = [];
%Drag Components 
    dragForceVector = []; 
    skinFrictionDragVector = [];
    pressureDragVector = []; 
    baseDragVector = []; 
%Physical Components 
    heightVector = []; 
    velocityVector = [];
    rocketAccelerationVector = [];
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

        %USURPER Simulation
for time = timeStart:timeStep:timeStop
%Initializing / Updating Vectors   
    %Mass Components (g)
    nitrousOxideMassVector(end + 1) = nitrousOxideMass;
    totalMassVector(end + 1) = totalMass; 
    %Drag Components
    dragForceVector(end + 1) = dragForce;
    skinFrictionDragVector(end + 1) = skinFrictionDrag;
    pressureDragVector(end + 1) = pressureDrag;
    baseDragVector(end + 1) = baseDrag;
    %Physical Components
    heightVector(end + 1) = height;
    velocityVector(end + 1) = velocity;
    rocketAccelerationVector(end + 1) = rocketAcceleration;
    thrustVector(end + 1) = thurst;
    %Time Components
    timeVector(end + 1) = time;
 
 %Simulation Calculations
    %Inital Assumptions
    if time == 0 
    thrust = 1334.47; %Assumption for full thurst at ignition in Newtons
    rocketAcceleration = thurst/totalMassVector(end);
    end 
    
    %Mass Components (g)
    nitriousOxideMass = nitrousOxideMassVector(end) - nitriousOxideMassFullFlowRate;
    %Physical Components 
    rocketAcceleration = 

    
    [a, d] = GetAcceleration(t,v,h); % get current acceleration
    v = v + dt*a ; % update velocity
    h = h + dt*v ; % update height
    
    if h < -.5
        break
    end
end        
  


%% USURPER SimulationV1. GetAcceleration 
function [a, d] = GetAcceleration (t , v, h )
g = 9.81;
f = GetThrust ( t );
m = GetMass ( t );
[d] = GetDrag ( v,h,t );
a = ( f - m*g - d )/ m ; % Newton Second Law
end
