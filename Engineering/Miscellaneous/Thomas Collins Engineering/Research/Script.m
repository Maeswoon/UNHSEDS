%% Script for formating and data analysis of Cooldown Data 

%General Cooldown data pull
Heater_Equilibrating_Data=xlsread('Cooldown Data','Heater Equilibrating');
Heater_Turning_off_Data=xlsread('Cooldown Data','Heater Turning off');
Heater_Turning_on_Data=xlsread('Cooldown Data','Heater Turning on','A2:D14');
Heater_On_Stable_Temp_Data=xlsread('Cooldown Data','Heater On, Stable Temp');
Fridge_cooling_Heater_off_Data=xlsread('Cooldown Data','Fridge cooling, Heater off');
Heater_Off_On_Data=xlsread('Cooldown Data','Heater Off On');

%Plots 

    %Heater Equilibrating 
    Time_Heater_Equilibrating = 0:5:190;
    Voltage_Heater_Equilibrating = Heater_Equilibrating_Data(:,2);
    Temperature_Heater_Equilibrating = Heater_Equilibrating_Data(:,4);
    Set_Temp_Heater_Equilibrating = 100*ones(39,1);
    
    figure
    hold on
    title('Heater Equilibrating')
    yyaxis left
    plot(Time_Heater_Equilibrating,Temperature_Heater_Equilibrating,'b');
    plot(Time_Heater_Equilibrating,Set_Temp_Heater_Equilibrating,'k--')
    ylabel('Temperature (K)')
    ylim([60,110]);
    yyaxis right
    plot(Time_Heater_Equilibrating,Voltage_Heater_Equilibrating,'r');
    ylabel('Voltage')
    legend({'Temperature (K)','Heater Set Temperature (K)','Voltage'},'Fontsize',10,'Location','east')
    xlabel('Time (Sec)')    
    ylim([25,50]);
    xlim([0,190]);
    hold off
    
    %Heater Turning off
    Time_Heater_Turning_off = 0:5:165;
    Voltage_Heater_Turning_off = Heater_Turning_off_Data(:,2);
    Temperature_Heater_Turning_off = Heater_Turning_off_Data(:,4);
    
    figure
    hold on
    title('Heater Turning off')
    yyaxis left
    plot(Time_Heater_Turning_off,Temperature_Heater_Turning_off,'b');
    ylabel('Temperature (K)')
    ylim([100,115]);
    yyaxis right
    plot(Time_Heater_Turning_off,Voltage_Heater_Turning_off,'r');
    ylabel('Voltage')
    legend({'Temperature (K)','Voltage'},'Fontsize',10,'Location','northeast')
    xlabel('Time (Sec)')    
    ylim([0,14]);
    xlim([0,165]);
    hold off
        
    %Heater Turning on 
    Time_Heater_Turning_on = 0:5:60;
    Voltage_Heater_Turning_on = Heater_Turning_on_Data(:,2);
    Temperature_Heater_Turning_on = Heater_Turning_on_Data(:,4);
    
    figure
    hold on
    title('Heater Turning on')
    yyaxis left
    plot(Time_Heater_Turning_on,Temperature_Heater_Turning_on,'b');
    ylabel('Temperature (K)')
    ylim([90,100]);
    yyaxis right
    plot(Time_Heater_Turning_on,Voltage_Heater_Turning_on,'r');
    ylabel('Voltage')
    legend({'Temperature (K)','Voltage'},'Fontsize',10,'Location','north')
    xlabel('Time (Sec)')    
    ylim([0,14]);
    xlim([0,60]);
    hold off
    
    %Heater Off On Data 
    Time_Heater_Off_On = 0:5:225;
    Voltage_Heater_Off_On = Heater_Off_On_Data(:,2);
    Temperature_Heater_Off_On = Heater_Off_On_Data(:,4);
    
    figure
    hold on
    title('Heater Off On Cycle')
    yyaxis left
    plot(Time_Heater_Off_On,Temperature_Heater_Off_On,'b');
    ylabel('Temperature (K)')
    ylim([90,115]);
    yyaxis right
    plot(Time_Heater_Off_On,Voltage_Heater_Off_On,'r');
    ylabel('Voltage')
    legend({'Temperature (K)','Voltage'},'Fontsize',10,'Location','north')
    xlabel('Time (Sec)')    
    ylim([0,15]);
    xlim([0,225]);
    hold off
    
    %%
    
a=2.36862708;
b=0.66027805;
c=0.77520692;
data=zeros(876,2);
for i = 1000:-1:125
data(1001-i,2)=i;
data(1001-i,1)=a+b*exp(c*(1000/i)); 
end 
temperature = data(:,1);
resistance = data(:,2);

figure 
hold on 
title('Calibration Curve of Allen Bradley #15')
plot(resistance,temperature); 
ylabel('Temperature (K)')
xlabel('Resistance (Ohm)')
plot(129.04,293.15,'r*');
plot(160.226,77.00,'b*'); 
plot(857,4,'k*');
legend('Calibration Curve','STP Calibration','Liquid Nitrogen Calibration','Liquid Helium Calibration')
hold off 

%% 
Polarization_Data=xlsread('arolditespinup.ods');
Polarization_TimeStamp = Polarization_Data(:,1); 
Polarization = Polarization_Data(:,2);
Polarization_Time=[1:1:5180]';
y=linspace(0,18,18);
x=linspace(2850,2850,18);
str={'Microwave Power','Study at 4.1K'};
str2={'Cooling from','4.1K to 2.0K'};

figure 
hold on 
title('Tempo Doped Aralidite Spin Up')
plot(Polarization_Time,Polarization); 
plot(x,y,'k');
text(700,6,str);
text(4000,6,str2);
ylabel('Polarization (%)')
xlabel('Time (Sec)')
legend({'Polarization (%)'},'Fontsize',10,'Location','northwest')
hold off 
    



    