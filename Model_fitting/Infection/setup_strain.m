% David Demory -- April 2019
function [data,iniH,aveH,stdH,iniV,aveV,stdV,xl_array,xu_array] = setup_strain(s,Hypo,delayLysis,gversion,nbrBatches)

%% Setup_strain function
% return the associated dataset and the associeted parameter
% setup.
% s is a scalar from 0 to 1 (viral strain id):
% HM2 -> s = 0
% SSP7 -> s = 1

% nS = size of the LHS space to sample.
% Hypo = hypothesis to test: 0 to 7
%	0 = H0
%	1 = H1_\phi
%	2 = H1_\beta
%	3 = H1_\lambda
%	4 = H2_\phi\beta
%	5 = H2_\phi\lambda
%	6 = H2_\lambda\beta
%	7 = H3
% delayLysis = initial model (0) or lysis inhibition model (1)
% nbrBatches = number of Batches to use in the analysis

%% Setup the strain
% initial conditions
if s == 0
    file = './Data/dataHM2.xlsx';
    iniH = [1.74E+08 1.82E8 1.98E8 2.18E8 2.28E+08];% 410000000 410000000];
    aveH = 2.00E+08; % average of all the treatment for t = 0.
    stdH = 22942237.29; % std of all the treatment for t = 0.
    iniV = [1279250 1882500 1374250 1077250	949625];% 30600000 29450000];
    aveV = 1312575;
    stdV = 359457.72;
    host = 0; %MED4 id
elseif s == 1
    file = './Data/dataSSP7.xlsx';
    iniH = [1.74E8 1.82E8 1.98E8 2.18E8 2.15E8];
    aveH = 1.97E+08; % average of all the treatment for t = 0.
    stdH = 19399604.61; % std of all the treatment for t = 0.
    iniV = [2536666.667	3437500	2540000	5175000	3347500];
    aveV = 3407333.333;
    stdV = 1076970.642;
    host = 0;
end

% number of parameters to estimate
if Hypo == 0
    npara = 3;
elseif Hypo == 1 || Hypo == 2 || Hypo == 3
    npara = 4;
elseif Hypo == 4 || Hypo == 5 || Hypo == 6
    npara = 5;
elseif Hypo == 7
    npara = 6;
end


% data, metadata and host data
for i = 1:nbrBatches
    
    % data and meta data
    data{i}.ydata = xlsread(file,i);
    data{i}.Hypo = Hypo;
    data{i}.strain = s;
    data{i}.host = host;
    data{i}.delayLysis = delayLysis;
    data{i}.gversion = gversion;
    
    % host growht data (mean from the figure2)
    if gversion == 0
        L = 35;
        data{i}.L = L;
        data{i}.kd = 322.68;
        data{i}.K = 3E9;
        mumax = 0.056965;
        alpha = 0.00069265;
        Lopt = 43.325;
        data{i}.muopt = mumax*(L/(L+(mumax/alpha)*((L/Lopt)-1)^2));
        data{i}.omega = 0.010398;
    elseif gversion == 1
        L = 35;
        data{i}.L = L;
        data{i}.kd = 151.59;
        data{i}.K = 3E9;
        mumax = 0.035;
        alpha = 0.0011;
        Lopt = 44.78;
        data{i}.muopt = mumax*(L/(L+(mumax/alpha)*((L/Lopt)-1)^2));
        data{i}.omega = 0.0032;
    end
    
    
    % viral decay rate
    if s == 0 | s == 3
        data{i}.deltaL = 0.022/24;%in hours % Data from Qinglu PFU
        data{i}.deltaD = 0.029/24;
    elseif s == 1
        data{i}.deltaL = 0.0176/24; % Data from Qinglu PFU
        data{i}.deltaD = 0.021/24;
    elseif s == 2
        data{i}.deltaL = 0.07/24; % Data from Qinglu PFU
        data{i}.deltaD = 0.09/24;
    end
    
end

% LHS constrained space
xl.adsorptionL = 1E-20;
xl.adsorptionD = 1E-20;
xu.adsorptionL = 1E-8;
xu.adsorptionD = 1E-8;
xl.lysisL = 0.1;
xl.lysisD = 0.1;
xu.lysisL = 36;
xu.lysisD = 36;
xl.burstL = 0.1;
xl.burstD = 0.1;
xu.burstL = 120;
xu.burstD = 120;
xl_array = log(struct2array(xl));
xu_array = log(struct2array(xu));

end