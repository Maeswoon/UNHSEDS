%%% INPUTS %%%
d_grain = 3.875;        % Grain OD (in)
pd_ratio = 1.6;         % Port/diameter ratio 
m_dot_ox = 1.8;         % Oxidizer flow rate (kg/s)
L_grain = 16;           % Grain length (in)
rho_f = 0.788;          % Fuel specific gravity
T_c = 3000;             % Chamber Temp (K)
R = 339;                % Gas constant for NOS (J/kgK) 
P_0 = 101325;           % Ambient Pressure (Pa)
P_c_psi = 450;          % Chamber Pressure (psi)
gamma = 1.25;           % Specific Heat Ratio
d_conv = 3.5;           % Nozzle inlet diameter (in)
theta_conv = 45;        % Convergent half-angle (deg)
theta_div = 15;         % Divergent half-angle (deg)

%%% CONSTANTS %%%
P_c = P_c_psi * 6894.76; % Chamber pressure (Pa)
a = 0.00014; % Regression coefficient
n = 0.52; % Regression exponent
d_port = (d_grain / pd_ratio) * 0.0254; % Port Diameter (meters)
L = L_grain * 0.0254; % Fuel Grain Length (m)
gamma_p = (gamma + 1) / 2; % Gamma plus one over two
gamma_m = gamma_p - 1; % Gamma minus one over two
gamma_exp = gamma_p / (gamma-1); % Common gamma exponent

%%% COMBUSTION CALCULATIONS %%% 
G_ox = m_dot_ox * 4 / (pi * d_port^2);
r_dot = a * power(G_ox, n);
% Some sources give the below equation for r_dot
% r_dot = a * power(G_ox, n) * power(L, -0.2);
m_dot_f = rho_f * r_dot * L * pi * d_port * 1000;
OF = m_dot_ox / m_dot_f;
m_dot = m_dot_ox + m_dot_f;
% Throat area A_t is constant for given chamber pressure
A_t = (m_dot / P_c) * sqrt(R * T_c / gamma) * power(gamma_p, 1 * gamma_exp);

%%% NOZZLE EQUATIONS %%%
mach_factor = @(exit_mach) 1 + gamma_m * power(exit_mach, 2);
expansion_ratio = @(factor, mach) power(factor / gamma_p, gamma_exp) ./ mach;
exit_pressure = @(factor) P_c * power(factor, -1 * gamma / (gamma - 1));
pressure_ratio = @(pressure) pressure / P_0;
exit_temperature = @(factor) T_c * power(factor, -1);
exit_velocity = @(mach, T) mach .* sqrt(gamma * R * T);
exit_area = @(ratio) ratio * A_t;
thrust = @(v, P, A) ((m_dot * v) + ((P - P_0).*A)) / 1000;
specific_impulse = @(force) force / (m_dot * 0.00981);

%%% NOZZLE SIMULATION %%%
% Independent variable is Exit Mach, M_e
M_e = linspace(1, 5, 1000); 
M_f = mach_factor(M_e);
A_r = expansion_ratio(M_f, M_e);
P_e = exit_pressure(M_f);
P_r = pressure_ratio(P_e);
T_e = exit_temperature(M_f);
v_e = exit_velocity(M_e, T_e);
A_e = exit_area(A_r);
F = thrust(v_e, P_e, A_e);
I_sp = specific_impulse(F);

%%% OPTIMUM NOZZLE PARAMETERS %%%
% Assuming optimal expansion (P_e = P_0)
% Adjust M_e_target to try other values
M_e_target = sqrt((power(P_0 / P_c, (1 - gamma) / gamma) - 1) / gamma_m);
M_f_target = mach_factor(M_e_target);
A_r_target = expansion_ratio(M_f_target, M_e_target);
P_e_target = exit_pressure(M_f_target);
P_r_target = pressure_ratio(P_e_target);
T_e_target = exit_temperature(M_f_target);
v_e_target = exit_velocity(M_e_target, T_e_target);
A_e_target = exit_area(A_r_target);
F_target = thrust(v_e_target, P_e_target, A_e_target);
I_sp_target = specific_impulse(F_target);

%%% OPTIMUM NOZZLE GEOMETRY %%%
% Units are converted to imperial for design use
d_t = (200 / 2.54) * sqrt(A_t / pi); % Throat diameter (in)
d_e = (200 / 2.54) * sqrt(A_e_target / pi); % Exit diameter (in)
L_conv = ((d_conv - d_t) / 2) * cot(theta_conv * (pi / 180)); % Convergent section length (in)
L_div = ((d_e - d_t) / 2) * cot(theta_div * (pi / 180)); % Divergent section length (in)

%%% DISPLAY %%%
sprintf("Port Diameter: %0.3fin \nOxidizer Flux: %0.3fkg/(s*m^2) \nRegression Rate: %0.3fmm/s \n" + ...
    "Fuel Flow Rate: %.3fkg/s \nTotal Flow Rate: %.3fkg/s \nOF Ratio: %.3f" + ...
    "\nExit Mach: %.3f \nThrust: %.3fkN \nIsp: %.1fs\n" + ...
    "Throat Diameter: %.3fin \nExit Diameter: %.3fin \n" + ...
    "Convergent Section Length: %.3fin \nDivergent Section Length: %.3fin", ...
     d_port / 0.0254, G_ox, r_dot * 1000, m_dot_f, m_dot, OF, M_e_target, F_target, ...
     I_sp_target, d_t, d_e, L_conv, L_div)

close all
figure('Name','Nozzle Performance','NumberTitle','off');
hold on
plot(M_e, F);
plot(M_e, P_r);
xline(M_e_target);
plot(M_e_target, F_target, '*');
title("Nozzle Performance")
xlabel("Exit Mach")
legend("Thrust (kN)", "Pressure Ratio", "Optimal Expansion");
text(M_e_target, F_target+0.5, sprintf("(%.3f, %.3f)",M_e_target, F_target))
hold off