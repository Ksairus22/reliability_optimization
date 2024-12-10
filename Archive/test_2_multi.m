clc; clear; close all;  
 
%% Includes  
addpath("functions\");  
addpath("Models\");  
addpath("Models\capacitors\");  
addpath("Models\capacitors\functions\");  
addpath("Models\diods\");  
addpath("Models\diods\functions\");  
addpath("Models\resistors\");  
addpath("Models\resistors\functions\");  
addpath("Models\transistors\");    
addpath("Models\transistors\functions\");  
 
%%   
FilenameSystem.Capacitors = 'table_reliability_capacitor.xlsx';  
FilenameSystem.Diods = 'table_reliability_diod.xlsx';  
FilenameSystem.Resistors = 'table_reliability_resistor.xlsx';  
FilenameSystem.Transistors = 'table_reliability_transistor.xlsx';  
 
% Предварительная загрузка данных 
[DataSystem] = getTableSystemData(FilenameSystem); 
 
opts_ps = optimoptions('paretosearch','Display','off','PlotFcn',{'psplotparetof' 'psplotparetox' 'psplotspread' 'psplotvolume' 'psplotfuncount' 'psplotdistance'});  
rng default % For reproducibility  
 
lb = [1e-12 1]; %[cap [F] res [Ohm] 
ub = [1e-1 1e6];  
 
fun = @(x) objval(x, DataSystem);  % Передайте DataSystem 
nlcon = @nonlcon;  
 
[x_ps1,fval_ps1,~,psoutput1] = paretosearch(fun,2,[],[],[],[],lb,ub,nlcon,opts_ps); 
x_ps1 
fval_ps1 
disp("Total Function Count: " + psoutput1.funccount);  
 
 
function [Cineq,Ceq] = nonlcon(x)  
Cineq = [];  
Ceq = [];  
end  
 
function F = objval(x, DataSystem) % Добавлен аргумент DataSystem 
% Параметры могут быть вынесены как константы 
t = 30;  
capacity = 1000e-12;  
U_ratio = 1/2;  
iRelative = 1/2;  
power_b = 0.5;  
resistance_b = 200;  
P_ratio_b = 1/2;  
power_k = 0.5;  
resistance_k = 200;  
P_ratio_k = 1/2;  
pRelative = 1/2;  
s1 = 1/2;  
goalfreq = 1000; 
 
f1 = abs(goalfreq - 1 ./ (log(2) * (2 * x(1) .* x(2))));  
f2 = getReliabilitySystemFromData(DataSystem, 1, 1, 1, 1, 1, t, x(1), U_ratio, iRelative, power_b, resistance_b, P_ratio_b, power_k, x(2), P_ratio_k, pRelative, s1);  
 
F = [f1, f2];  
end
