%% USURPER Simulation V1
clear all 
close all 

%Initial Values
%Time Components 
    timeStart = 0;  
    timeStep = 0.1; 
    timeStop = 45;
    simulationIterator = 1;
%Drag Components
    dragForce = 0;          
    skinFrictionDrag = 0;         
    noseConeDrag = 0;           
    baseDrag = 0; 
    finDrag = 0;
    parachuteDrag = 0;
%Physical Components
    gravitationalAcceleration = 9.81;
    rocketAcceleration = 0;   
    velocity = 0;             
    height = 0; 
    thrustForce = 0;
    force = 0;
    rhoAir = zeros(((timeStop-timeStart)/timeStep)+1,2); %density vector from 0 to 3000 meters kg/m^3
    rhoAir(:,1) = linspace(0,3048,((timeStop-timeStart)/timeStep)+1);
    rhoAir(:,2) = linspace(1.225,.9093,((timeStop-timeStart)/timeStep)+1);
    runawayFullThrust = 1334.47; %300 lbf thurst in N
    runawayHalfThurst = 667.233; %150 lbf thurst in N
    
%Mass Components (g)
    %Nitrous Oxide Components 
    nitrousOxideTankEmpty  = 3968.93; 
    nitrousOxideTankFull = 9780.59;
    nitrousOxideMass = 5698.25;
    nitrousOxideTankMass = 9780.59;
    nitriousOxideMassFullFlowRate = 907.185*timeStep; %2 lbs/s flow rate in grams
    nitriousOxideMassHalfFlowRate = 453.592*timeStep; %1 lbs/s flow rate in grams
    flowRate = 0;
    %Rocket Body Components 
    rocketBodyComponentsMass = 22679.6; %Assumption of 50lb rocket mass without Nitrious Tank
    %Total Mass (Kg)
    totalMass = (nitrousOxideTankMass + rocketBodyComponentsMass)/1000; %CHANGE
%Nose Cone Components 
    cdNoseCone = 0.15; %value chosen, we need to do more research
    diameterNoseCone = 7*0.0254; % diameter of outside of rocket, meters
%Skin Friction Components
    diameterRocket = 7*0.0254;
    rocketSkinLength=2.15; % Length of rocket (m)
    dynamicViscosity=1.198e-5; %Dynamic viscosity of air
    cylSurfaceArea=pi*diameterRocket*rocketSkinLength; % surface area outside of rocket, meters
    finSurfaceArea= 0.036; % surface area of one fin (m^2)
    numFins=4; % number of fins on rocket
    finSurfaceAreaTotal= finSurfaceArea*numFins; % surface area of all fins
    totalSurfaceArea=cylSurfaceArea+finSurfaceAreaTotal; % total surface area of rocket
%Base Drag Components  (vaccum created under rocket when combustion is over)
    rocketLength=2.44; % overall length of rocket, meters
    noseConeLength=.457; % length of nose cone, meters
    bodyDiameter=.178; % diameter of body, meters
    bodyLength=1.98; % length of body, meters
    nozzleLength=.102; % length of nozzle, meters
    nozzleDiameter= .0762; % diameter of nozzle, meters
%Thrust Components 
thrustCurve = 4.44822*[0,75,200,225,250,275,300,300,300,300,300,300,200,50,0]; %Thrust curve with corresponding %Thrust (N) 1 lbf * 4.44822 = (N)
timeCurve = [0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0,5.5,6.0,6.5,7.0];
%Initial Vectors
%Mass Components (g)
    nitrousOxideTankMassVector = [];
    totalMassVector = [];
%Drag Components 
    dragForceVector = []; 
    skinFrictionDragVector = [];
    noseConeDragVector = []; 
    baseDragVector = [];
    finDragVector = [];
%Physical Components 
    heightVector = []; 
    velocityVector = [];
    rocketAccelerationVector = [];
    thrustForceVector = [];
    forceVector = [];
%Time Components 
    timeVector = []; 


%USURPER Simulation
for time = timeStart:timeStep:timeStop
%Initializing / Updating Vectors   
    %Mass Components (g)
    nitrousOxideTankMassVector(end + 1) = nitrousOxideTankMass;
    totalMassVector(end + 1) = totalMass; 
    %Drag Components
    dragForceVector(end + 1) = dragForce;
    skinFrictionDragVector(end + 1) = skinFrictionDrag;
    noseConeDragVector(end + 1) = noseConeDrag;
    baseDragVector(end + 1) = baseDrag;
    finDragVector(end + 1) = finDrag;
    %Physical Components
    heightVector(end + 1) = height;
    velocityVector(end + 1) = velocity;
    rocketAccelerationVector(end + 1) = rocketAcceleration;
    thrustForceVector(end + 1) = thrustForce;
    forceVector(end + 1) =  force;
    %Time Components
    timeVector(end + 1) = time;
 
%Simulation Calculations
    
    %Inital Assumptions 
    %Mass Components (g)
        nitrousOxideTankMass = nitrousOxideTankMassVector(end) - nitriousOxideMassFullFlowRate;
        if nitrousOxideTankMass > nitrousOxideTankEmpty 
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
  
        else 
            thrust = 0.0; 
            nitriousOxideMassFullFlowRate = 0;
        end 
        totalMass = (nitrousOxideTankMass + rocketBodyComponentsMass)/1000;
    %Physical Components
        velocity = velocityVector(end) + rocketAcceleration(end)*timeStep; %Inaccuracy 
        height = heightVector(end) + velocity*timeStep;

    %Drag Components
    if velocity ~= 0
        %Skin Friction
        reynoldsNum=((rhoAir(simulationIterator,2))*abs(velocity)*rocketSkinLength)/dynamicViscosity; % reynolds number, unitless
        cfSkin=1/((1.5*log(reynoldsNum)-5.6)^2); % friction coeff, unitless
        skinFrictionDrag = (.5)*(cfSkin)*(rhoAir(simulationIterator,2))*(totalSurfaceArea*(velocity^2));
        %Nose Cone Drag
        noseConeDrag = (.5)*(cdNoseCone)*(rhoAir(simulationIterator,2))*(pi*(diameterNoseCone^2)/4)*(velocity^2);
        %Base Drag
        cdForBody=(1+(60/(rocketLength/bodyDiameter)^3)+.0025*(bodyLength/bodyDiameter))*((2.7*noseConeLength/bodyDiameter)+(4*bodyLength/bodyDiameter)+(2*(1-(nozzleDiameter/bodyDiameter))*(nozzleLength/bodyDiameter)))*skinFrictionDrag;
        cdBase=(.029*((nozzleDiameter/bodyDiameter)^3))/sqrt(cdForBody); % drag coeff of base of rocket
        baseDrag = (0.5)*cdBase*(rhoAir(simulationIterator,2))*(pi*(bodyDiameter^2)/4)*(velocity^2); % drag of the base, N
        %Fin Drag
        finDrag = 0;
    else 
        skinFrictionDrag = 0;
        noseConeDrag = 0;
        baseDrag = 0;
        finDrag = 0;
    end
    %Force Calculations
    thrustForce = thrust;
    dragForce = skinFrictionDrag + noseConeDrag + baseDrag + finDrag;
    massForce = totalMass*gravitationalAcceleration;
    force = thrustForce - dragForce - massForce; 
    %Acceleration Calculation
    rocketAcceleration = force/totalMass;
    
    simulationIterator = simulationIterator + 1;
end        
  
figure(1)
plot(timeVector,heightVector,'k','LineWidth',1.3)
title('Height Vs Time')
ylabel('Height (m)')
xlabel('Time (sec)')

figure(2)
plot(timeVector,forceVector,'k','LineWidth',1.3)
title('Force Vs Time')
ylabel('Force (N)')
xlabel('Time (sec)')

figure(3)
plot(timeVector,rocketAccelerationVector,'k','LineWidth',1.3)
title('Acceleration Vs Time')
ylabel('Acceleration (m/s^2)')
xlabel('Time (sec)')

figure(4)
plot(timeVector,velocityVector,'k','LineWidth',1.3)
title('Velocity Vs Time')
ylabel('Velocity (m/s)')
xlabel('Time (sec)')

figure(5)
plot(timeVector,dragForceVector,'k','LineWidth',1.3)
title('Drag Force Vs Time')
ylabel('Drag Force (N)')
xlabel('Time (sec)')

figure(6)
plot(timeVector,totalMassVector,'k','LineWidth',1.3)
title('Mass Vs Time')
ylabel('Mass (Kg)')
xlabel('Time (sec)')

figure(7)
plot(timeVector,thrustForceVector,'k','LineWidth',1.3)
title('Thrust Force Vs Time')
ylabel('Thrust Force (N)')
xlabel('Time (sec)')





%% USURPER SimulationV1. GetAcceleration 
function [a, d] = GetAcceleration (t , v, h )
g = 9.81;
f = GetThrust ( t );
m = GetMass ( t );
[d] = GetDrag ( v,h,t );
a = ( f - m*g - d )/ m ; % Newton Second Law
end
