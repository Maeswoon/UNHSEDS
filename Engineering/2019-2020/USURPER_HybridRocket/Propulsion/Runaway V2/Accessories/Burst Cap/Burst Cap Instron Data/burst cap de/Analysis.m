clear all
close all

Cap1_1 = xlsread('BurstCapAnal.xlsx','J2:J400');
Cap1_2 = xlsread('BurstCapAnal.xlsx','K2:K400');
Cap2_1 = xlsread('BurstCapAnal.xlsx','L2:L400');
Cap2_2 = xlsread('BurstCapAnal.xlsx','M2:M400');
Cap3_1 = xlsread('BurstCapAnal.xlsx','N2:N400');
Cap3_2 = xlsread('BurstCapAnal.xlsx','O2:O400');

%% Get them to start at the same time
for i = 1:length(Cap1_1)
    if Cap1_1(i)>10
        Cap1_1_Start = i
        break
    end
end

for i = 1:length(Cap1_1)
    if Cap1_2(i)>10
        Cap1_2_Start = i
        break
    end
end

for i = 1:length(Cap1_1)
    if Cap2_1(i)>110
        Cap2_1_Start = i
        break
    end
end

for i = 1:length(Cap1_1)
    if Cap2_2(i)>110
        Cap2_2_Start = i
        break
    end
end

for i = 1:length(Cap1_1)
    if Cap3_1(i)>80
        Cap3_1_Start = i
        break
    end
end

for i = 1:length(Cap1_1)
    if Cap3_2(i)>80
        Cap3_2_Start = i
        break
    end
end
%% Grabbing that and redefining

Cap1_1 = Cap1_1(Cap1_1_Start:end);
Cap1_2 = Cap1_2(Cap1_2_Start:end);
Cap2_1 = Cap2_1(Cap2_1_Start:end);
Cap2_2 = Cap2_2(Cap2_2_Start:end);
Cap3_1 = Cap3_1(Cap3_1_Start:end);
Cap3_2 = Cap3_2(Cap3_2_Start:end);


figure()
plot(Cap1_1)
hold on
plot(Cap1_2)
plot(Cap2_1)
plot(Cap2_2)
plot(Cap3_1)
plot(Cap3_2)
ylabel('Pounds (lbs)')
legend('Cap 0.001 Press - 1','Cap 0.001 Press - 2','Cap 0.004 Press - 1','Cap 0.004 Press - 2','Cap 0.003 Press - 1','Cap 0.003 Press - 2','Location','southeast')



