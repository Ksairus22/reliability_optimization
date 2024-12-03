clc; clear; close all;diary off;
% diary LogFile_ConsoleOutput.txt
disp("Start    " + datestr(datetime()))
tStart=tic;
%% Include
addpath("functions\")

%% Inputs
filename = 'table_reliability_diod.xlsx';
rownum = 2;
iRelative = 0.6;
t = 25;
s1 = 0.6;
counTransistors = 225;

%% Work: open file -> get coef -> get lambda
[num, partName, type, groupKey, technicalConditions, lambdaB] = getTableDiod(filename, rownum);
[lambdaB, kPr, kR, kE] = getCoefDiod(lambdaB, iRelative, t);
[lambda] = getReliabilityDiod(lambdaB, kPr, kR, kE);

%% 2D plot
cond_2D_plot = 1;
if(cond_2D_plot)
    t_line = linspace(1,100,100);
    iRelative_line = linspace(0.1,1,100);
    lambda_line = arrayfun( @(x) getReliabilityDiodFromVariables(lambdaB, iRelative, x), t_line);
    size(t_line)
    size(iRelative_line)
    size(lambda_line)
    figure
    plot(t_line, lambda_line)
end

%% 3D plot
cond_3D_plot = 1;
if(cond_3D_plot)
    [t_surf, iRelative_surf] = meshgrid(t_line, iRelative_line);
    lambda_surf = arrayfun( @(x,y)...
        getReliabilityDiodFromVariables(lambdaB, y, x),...
        t_surf, iRelative_surf);
    size(t_surf)
    size(iRelative_surf)
    size(lambda_surf)
    figure
    surf(t_surf,iRelative_surf,lambda_surf)
end
%% 3D plot from file
cond_3D_plot_from_file = 0;
if(cond_3D_plot_from_file)
    [t_surf, iRelative_surf] = meshgrid(t_line, iRelative_line);

    lambda_surf = arrayfun( @(x,y) ...
        getReliabilityDiodFromFile(filename, rownum, y, x),...
        t_surf, iRelative_surf);  % Bad condition

    size(t_surf)
    size(iRelative_surf)
    size(lambda_surf)
    figure
    surf(t_surf,iRelative_surf,lambda_surf)
end

%% 3D plot from Data
cond_3D_plot_from_data = 1;
if(cond_3D_plot_from_data)
    Data = getTableTransistorData(filename);

    [t_surf, iRelative_surf] = meshgrid(t_line, iRelative_line);

    lambda_surf = arrayfun( @(x,y) ...
        getReliabilityDiodFromData(Data, rownum, y, x),...
        t_surf, iRelative_surf);  % Bad condition

    size(t_surf)
    size(iRelative_surf)
    size(lambda_surf)
    figure
    surf(t_surf,iRelative_surf,lambda_surf)
end

%% Test open full file row by row
cond_test_open_rowbyrow = 0;
if(cond_test_open_rowbyrow)
    lambda_vec = zeros(1,counTransistors);
    for i=1:counTransistors
        lambda_vec(i) = getReliabilityDiodFromFile(filename, i, iRelative, t);
    end
    size(lambda_vec)
end

%% Functions
% getTableTransistorData(filename);
% getReliabilityTransistorFromVariables(tTrMax, tLow, lambdaB, iRelative, t, s1)
% getReliabilityTransistorFromData(Data, rownum, iRelative, t, s1)
% getReliabilityTransistorFromFile(filename, rownum, iRelative, t, s1)
% getCoefTransistorFromData(Data, rownum, iRelative, t, s1)
% getCoefTransistorFromFile(filename, rownum, iRelative, t, s1)
% getCoefTransistorFromFile_lambdaB(filename, rownum)
% getCoefTransistor_lambdaB(lambdaB)
% getCoefTransistor_kPr(prGroup) % 1
% getCoefTransistor_kR(tTrMax, tLow, iRelative, t)
% getCoefTransistor_kF(fGroup) % 3
% getCoefTransistor_kS1(s1)
% getCoefTransistor_kE(erGroup) % 1
% getCoefTransistor_kEl(iRelative)
% getReliabilityTransistorFromVariablesVectorial(tTrMax, tLow, lambdaB, iRelative, t, s1)

disp("Finish    " + datestr(datetime()));
tElapsed=toc(tStart);
disp("Elapsed time: "+num2str(tElapsed)+" sec")
diary off