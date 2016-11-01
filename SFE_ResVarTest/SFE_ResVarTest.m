%% clear variables and console and close windows
clear
clc
close all

%% set directory
cd('C:\Users\castrotp.hub\Desktop\QuantletNow')

%% data import
formatSpec = '%{yyyy-MM-dd}D%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f';
dataset    = readtable('2004-2014_dax_ftse.csv','Delimiter',',', 'Format',formatSpec);

%% 5 different truncation lags
q = [5, 10, 32, 40, 110];

%% create tables for the results
testAbs = table;
testSqr = table;

%% FTSE 100
absLogRetFTSE = abs(diff(log(dataset{:, 'FTSE100'})));
LogRetFTSE2   = absLogRetFTSE.^2;

%% Bayer
absLogRetBayer = abs(diff(log(dataset{:, 'BAYER'})));
LogRetBayer2   = absLogRetBayer.^2;

%% Siemens
absLogRetSiem = abs(diff(log(dataset{:, 'SIEMENS'})));
LogRetSiem2   = absLogRetSiem.^2;

%% Volkswagen
absLogRetVW = abs(diff(log(dataset{:, 'VOLKSWAGEN'})));
LogRetVW2   = absLogRetVW.^2;

%% Tests 
% assign name and length to the colums of the tables of results
testAbs.FTSE  = (1:length(q))';
testSqr.FTSE  = testAbs.FTSE;
testAbs.Bayer = testAbs.FTSE;
testSqr.Bayer = testAbs.FTSE;
testAbs.Siem  = testAbs.FTSE;
testSqr.Siem  = testAbs.FTSE;
testAbs.VW    = testAbs.FTSE;
testSqr.VW    = testAbs.FTSE;

% fill the colums of the tables of results
for i = 1:length(q);
    % calculate the rescaled variance test for the lag q(i)
    v_sFTSE   = SFE_RVarTestStat(absLogRetFTSE, q(i));
    v_sFTSE2  = SFE_RVarTestStat(LogRetFTSE2, q(i));
    v_sBayer  = SFE_RVarTestStat(absLogRetBayer, q(i));
    v_sBayer2 = SFE_RVarTestStat(LogRetBayer2, q(i));
    v_sSiem   = SFE_RVarTestStat(absLogRetSiem, q(i));
    v_sSiem2  = SFE_RVarTestStat(LogRetSiem2, q(i));
    v_sVW     = SFE_RVarTestStat(absLogRetVW, q(i));
    v_sVW2    = SFE_RVarTestStat(LogRetVW2, q(i));
    
    testAbs.FTSE(i)  = v_sFTSE;
    testSqr.FTSE(i)  = v_sFTSE2;
    testAbs.Bayer(i) = v_sBayer;
    testSqr.Bayer(i) = v_sBayer2;
    testAbs.Siem(i)  = v_sSiem;
    testSqr.Siem(i)  = v_sSiem2;
    testAbs.VW(i)    = v_sVW;
    testSqr.VW(i)    = v_sVW;
end

%% add row names to the tables of results
testAbs.Properties.RowNames = cellstr(num2str(q(:)));
testSqr.Properties.RowNames = cellstr(num2str(q(:)));

%% print results
testAbs
testSqr
