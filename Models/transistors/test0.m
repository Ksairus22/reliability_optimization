clc; clear; close all;diary off;
% diary LogFile_ConsoleOutput.txt
disp("Start    " + datestr(datetime()))
tStart=tic;
%% Include
addpath("functions\")

%% Inputs
filename = 'table_reliability_transistor.xlsx';
rownum = 2;
pRelative = 0.6;
t = 25;
s1 = 0.6;
counTransistors = 225;

%% Work: open file -> get coef -> get lambda
[num, partName, type, groupKey, technicalConditions, tTrMax, tLow, lambdaB] = getTableTransistor(filename, rownum);
[lambdaB, kPr, kR, kF, kS1, kE] = getCoefTransistor(tTrMax, tLow, lambdaB, pRelative, t, s1);
[lambda] = getReliabilityTransistor(lambdaB, kPr, kR, kF, kS1, kE);

%% 2D plot
cond_2D_plot = 1;
if(cond_2D_plot)
    t_line = linspace(1,100,100);
    pRelative_line = linspace(0.1,1,100);
    lambda_line = arrayfun( @(x) getReliabilityTransistorFromVariables(tTrMax, tLow, lambdaB, pRelative, x, s1), t_line);
    size(t_line)
    size(pRelative_line)
    size(lambda_line)
    figure
    plot(t_line, lambda_line)
end

%% 3D plot
cond_3D_plot = 1;
if(cond_3D_plot)
    [t_surf, pRelative_surf] = meshgrid(t_line, pRelative_line);
    lambda_surf = arrayfun( @(x,y)...
        getReliabilityTransistorFromVariables(...
        tTrMax, tLow, lambdaB, y, x, s1), t_surf, pRelative_surf);
    size(t_surf)
    size(pRelative_surf)
    size(lambda_surf)
    figure
    surf(t_surf,pRelative_surf,lambda_surf)
end
%% 3D plot from file
cond_3D_plot_from_file = 0;
if(cond_3D_plot_from_file)
    [t_surf, pRelative_surf] = meshgrid(t_line, pRelative_line);

    lambda_surf = arrayfun( @(x,y) ...
        getReliabilityTransistorFromFile(filename, rownum, y, x, s1),...
        t_surf, pRelative_surf);  % Bad condition

    size(t_surf)
    size(pRelative_surf)
    size(lambda_surf)
    figure
    surf(t_surf,pRelative_surf,lambda_surf)
end

%% 3D plot from Data
cond_3D_plot_from_data = 1;
if(cond_3D_plot_from_data)
    Data = getTableTransistorData(filename);

    [t_surf, pRelative_surf] = meshgrid(t_line, pRelative_line);

    lambda_surf = arrayfun( @(x,y) ...
        getReliabilityTransistorFromData(Data, rownum, y, x, s1),...
        t_surf, pRelative_surf);  % Bad condition

    size(t_surf)
    size(pRelative_surf)
    size(lambda_surf)
    figure
    surf(t_surf,pRelative_surf,lambda_surf)
end

%% Test open full file row by row
cond_test_open_rowbyrow = 0;
if(cond_test_open_rowbyrow)
    lambda_vec = zeros(1,counTransistors);
    for i=1:counTransistors
        lambda_vec(i) = getReliabilityTransistorFromFile(filename, i, pRelative, t, s1);
    end
    size(lambda_vec)
end

%% Functions
% getTableTransistorData(filename);
% getReliabilityTransistorFromVariables(tTrMax, tLow, lambdaB, pRelative, t, s1)
% getReliabilityTransistorFromData(Data, rownum, pRelative, t, s1)
% getReliabilityTransistorFromFile(filename, rownum, pRelative, t, s1)
% getCoefTransistorFromData(Data, rownum, pRelative, t, s1)
% getCoefTransistorFromFile(filename, rownum, pRelative, t, s1)
% getCoefTransistorFromFile_lambdaB(filename, rownum)
% getCoefTransistor_lambdaB(lambdaB)
% getCoefTransistor_kPr(prGroup) % 1
% getCoefTransistor_kR(tTrMax, tLow, pRelative, t)
% getCoefTransistor_kF(fGroup) % 3
% getCoefTransistor_kS1(s1)
% getCoefTransistor_kE(erGroup) % 1
% getCoefTransistor_kEl(pRelative)
% getReliabilityTransistorFromVariablesVectorial(tTrMax, tLow, lambdaB, pRelative, t, s1)

disp("Finish    " + datestr(datetime()));
tElapsed=toc(tStart);
disp("Elapsed time: "+num2str(tElapsed)+" sec")
diary off