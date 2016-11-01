%% clear variables and console and close windows
clear
clc
close all

%% set directory
%cd('C:/...')

%% data import
formatSpec = '%{yyyy-MM-dd}D%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
data       = readtable('2004-2014_dax_ftse.csv','Delimiter',',','Format',formatSpec);

T  = size(data, 1);

%% range for d
a  = -1;
b  = 2;

%% 3 different highest frequencies
m  = [round(T/64) round(T/16) round(T/4)];

%% tables for the results:
testAbs = table;
testSqr = table;

%% FTSE 100
absLogRetFTSE = abs(diff(log(data.FTSE100)));
logRetFTSE2   = absLogRetFTSE.^2;
testAbs.FTSE  = [SFE_gsp(absLogRetFTSE,a,b,m(1)); SFE_gsp(absLogRetFTSE,a,b,m(2)); SFE_gsp(absLogRetFTSE,a,b,m(3))];
testSqr.FTSE2 = [SFE_gsp(logRetFTSE2,a,b,m(1)); SFE_gsp(logRetFTSE2,a,b,m(2)); SFE_gsp(logRetFTSE2,a,b,m(3))];

%% Bayer
absLogRetBayer = abs(diff(log(data.BAYER)));
logRetBayer2   = absLogRetBayer.^2;
testAbs.Bayer  = [SFE_gsp(absLogRetBayer,a,b,m(1)); SFE_gsp(absLogRetBayer,a,b,m(2)); SFE_gsp(absLogRetBayer,a,b,m(3))];
testSqr.Bayer  = [SFE_gsp(logRetBayer2,a,b,m(1)); SFE_gsp(logRetBayer2,a,b,m(2)); SFE_gsp(logRetBayer2,a,b,m(3))];

%% Siemens
absLogRetSiem   = abs(diff(log(data.SIEMENS)));
logRetSiem2     = absLogRetSiem.^2;
testAbs.Siemens = [SFE_gsp(absLogRetSiem,a,b,m(1)); SFE_gsp(absLogRetSiem,a,b,m(2)); SFE_gsp(absLogRetSiem,a,b,m(3))];
testSqr.Siemens = [SFE_gsp(logRetSiem2,a,b,m(1)); SFE_gsp(logRetSiem2,a,b,m(2)); SFE_gsp(logRetSiem2,a,b,m(3))];

%% Volkswagen
absLogRetVW = abs(diff(log(data.VOLKSWAGEN)));
logRetVW2   = absLogRetVW.^2;
testAbs.VW  = [SFE_gsp(absLogRetVW,a,b,m(1)); SFE_gsp(absLogRetVW,a,b,m(2)); SFE_gsp(absLogRetVW,a,b,m(3))];
testSqr.VW  = [SFE_gsp(logRetVW2,a,b,m(1)); SFE_gsp(logRetVW2,a,b,m(2)); SFE_gsp(logRetVW2,a,b,m(3))];

%% Adding row names to the tables of results:
testAbs.Properties.RowNames = {'T/64' 'T/16' 'T/4'};
testSqr.Properties.RowNames = {'T/64' 'T/16' 'T/4'};

%% printing results:
testAbs
testSqr

