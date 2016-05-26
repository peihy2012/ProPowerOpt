function [ pwrSmp ] = powersample( npoints, busdata )
%POWERSAMPLE Summary of this function goes here
%   The load power follows Gauss distribution.
Nb = size(busdata,1);
% Mathematical Expectation of Active and Reactive Power 
activePower = busdata(:,5);
reactivePower = busdata(:,6);
% Simpling Number
% 1000000 = 151 seconds
% 100000 = 5 seconds
simpleNum = npoints;
% Deviation of Mathematical Expectation 
% Standard Normal Distribution P[ -3<x<3 ] = 94.5%
normalDev = norminv(rand(Nb,simpleNum));
% activePowerDev = norminv(rand(Nb,simpleNum))/3+1;
% reactivePowerDev = norminv(rand(Nb,simpleNum))/3+1;
% Set the Deviation at (-15%,15%)~(-40%,40%)
devRange = randi([15,40],Nb,1)/100;
powerDev = diag(devRange) * normalDev / 3 + 1;
% Simpling with Deviation
% Active and Reactive Power Simpling
% actPwrSmp = diag(activePower) * activePowerDev;
% reactPwrSmp = diag(reactivePower) * reactivePowerDev;
pwr = activePower + i*reactivePower;
pwrSmp = diag(pwr) * powerDev;


end

