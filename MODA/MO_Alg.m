clear all;
clc;
gridPath = '.\GridData';
addpath(gridPath);
%% MOEA-D
moeadPath = '.\MOEA-D';
addpath(moeadPath);
moead;
moeadF = [EP.Cost];
moeadPath = '.\MOEA-D';
rmpath(moeadPath);
%% SPEA2
spea2Path = '.\SPEA2';
addpath(spea2Path);
spea2;
spea2F = [PF.Cost];
spea2Path = '.\SPEA2';
rmpath(spea2Path);