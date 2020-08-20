%% Pflanz's Method for Drogue Chute Opening forces 
% Pflanz's method yields on the peak opening load. It requires the least
% knowledge of the system compared to other methods. It assumes no
% gravitational acceleration which limits the application to shallow path
% angles at parachute deployment and allows for finite mass approximation. 
%
% Equations 
% Fmax = q1*(Cd*So)*Cx*X1 
% A_ballistic = 2m/((Cd*So)*rho*V*t_inf) [Knacke: 5-51]
% X1 = f(A,n)
% 
% Launch date : June 20th, 2020 Spaceport America 

clear all; close all; clc;

% Apogee measurements of the rocket
m_rocket = 60; % lbm
m_fuel   = 15; % lbm
m_apogee = m_rocket - m_fuel; 
m_apogee = m_apogee/2.205;  % kg

h_launchsite = 1401; % MAMSL, [Source: https://en.wikipedia.org/wiki/Spaceport_America]
h_agl        = 3048; % meters, this is the target height [10,000 ft]
h_apogee     = h_launchsite + h_agl; 

launch_temp = 34;                   % degrees C [Source: https://www.currentresults.com/Weather/New-Mexico/temperature-june.php]
launch_temp = launch_temp + 273.15; % Kelvin

% Parachute Characteristics 
cd_drogue = 1.6;          % [Source: Fruity Chutes]
So        = pi*(12^2);    % Nominal Area in square inches
So        = So/1550.0031; % Convert to square meters
Do        = 24/39.37;     % Nominal Diamter in meters 
n         = 10;            % inflation curve exponent. [Knacke: pg. 5-43]
k         = 0.85;         % [Knacke: pg. 5-43]
Cx        = 1.7;          % Opening force factor [Source: Knacke pg. 5-3]

% Assuming a 4 second free fall the code below describes the velocity of
% the rocket. The postive coordinate direction is being defined as down
% here, notice the sign of gravity. 
g          = 9.81; % m/s^2
v_apogee   = 0; 
t_freefall = 4; % seconds

v_freefall = v_apogee + g*t_freefall; % m/s 

Do_Imp    = Do*(39.37/12); % feet
v_ff_Imp  = v_freefall*3.281;
t_inf     = (n*Do_Imp)/(v_ff_Imp^k);
% t_inf     = 2;

% Atmospheric Density calculation for apogee. Values interpolated from Fox
% and McDonald's Introduction to Fluid Mechanics Table A.3
rho_sl     = 1.225; % kg/m^3
rho_sg     = interp1([4000 4500], [0.6689 0.6343], h_apogee);
rho_apogee = rho_sg*rho_sl;

% Equation: (1/2)*(V^2)*Fluid_Density. Dynamic Pressure in Pascals at start
% of inflation [Source: Fox and McDonald's Introduction to Fluid Mechanics 
% pg. 245]
q1          = (1/2)*(v_freefall^2)*rho_apogee; % Dynamic Pressure 

% At this point everything has been calculated in order to figure out the
% peak force except X1 the force reduction factor for inflation
% deceleration. This is function of a ballistic parameter A and the
% n which is equal to two for solid cloth conical chutes [Source: Knacke pg. 5-58]. 

A_ballistic = (2*m_apogee)/((cd_drogue*So)*rho_apogee*v_freefall*t_inf);

X1          = 1; 

Fmax = q1*(cd_drogue*So)*Cx*X1;
disp(['Peak Drogue Force: ', num2str(Fmax, 4), ' N'])
Fmax = Fmax/4.448;
disp(['Peak Drogue Force: ', num2str(Fmax, 4), ' lbf'])

%% Pflanz's Method for Main Chute Opening forces 

clear all; close all; 

% Apogee measurements of the rocket
m_rocket = 60; % lbm
m_fuel   = 15; % lbm
m_apogee = m_rocket - m_fuel; 
m_apogee = m_apogee/2.205;  % kg

h_launchsite = 1401; % MAMSL, [Source: https://en.wikipedia.org/wiki/Spaceport_America]
h_agl        = 365;  % meters, this is the target height [750 ft]
h_deploy     = h_launchsite + h_agl; 

launch_temp = 34;                   % degrees C [Source: https://www.currentresults.com/Weather/New-Mexico/temperature-june.php]
launch_temp = launch_temp + 273.15; % Kelvin

% Parachute Characteristics 
cd_main   = 2.2;          % [Source: Fruity Chutes]
So        = pi*(38^2);    % Nominal Area in square inches
So        = So/1550.0031; % Convert to square meters
Do        = 96/39.37;     % Nominal Diamter in meters 
n         = 10;            % inflation curve exponent. [Knacke: pg. 5-43]
k         = 0.85;         % [Knacke: pg. 5-43]
Cx        = 1.4;          % Opening force factor [Source: Knacke pg. 5-3]

v_freefall = 26.98; % m/s 
Do_Imp     = Do*(39.37/12); % feet
v_ff_Imp  = v_freefall*3.281;
t_inf     = (n*Do_Imp)/(v_ff_Imp^k);
% t_inf     = 2;

% Atmospheric Density calculation for apogee. Values interpolated from Fox
% and McDonald's Introduction to Fluid Mechanics Table A.3
rho_sl     = 1.225; % kg/m^3
rho_sg     = interp1([1500 2000], [0.8638 0.8217], h_deploy);
rho_deploy = rho_sg*rho_sl;

% Equation: (1/2)*(V^2)*Fluid_Density. Dynamic Pressure in Pascals at start
% of inflation [Source: Fox and McDonald's Introduction to Fluid Mechanics 
% pg. 245]
q1          = (1/2)*(v_freefall^2)*rho_deploy; % Dynamic Pressure 

% At this point everything has been calculated in order to figure out the
% peak force except X1 the force reduction factor for inflation
% deceleration. This is function of a ballistic parameter A and the
% n which is equal to two for solid cloth conical chutes [Source: Knacke pg. 5-58]. 

A_ballistic = (2*m_apogee)/((cd_main*So)*rho_deploy*v_freefall*t_inf);

X1          = .2; 

Fmax = q1*(cd_main*So)*Cx*X1;
disp(['Peak Main Force: ', num2str(Fmax, 4), ' N'])
Fmax = Fmax/4.448;
disp(['Peak Main Force: ', num2str(Fmax, 4), ' lbf'])







