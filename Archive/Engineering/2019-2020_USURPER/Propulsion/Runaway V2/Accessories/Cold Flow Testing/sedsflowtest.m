clear all
close all

Time = xlsread('sedsswagetest full flow','A:A');
Voltage = xlsread('sedsswagetest full flow','B:B');
Voltage = Voltage(8:207);
Voltage = Voltage-Voltage(1);

%%




Pounds = (Voltage+.0195)./0.0161;





