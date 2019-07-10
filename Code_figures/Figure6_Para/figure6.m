%% figure6 -- 2019Demory_light
% plot the parameter distributions
% the distribution are in log space so we use the exp() to obtain parameters values.


%% setup

% environment
clear all; close all;clc;

% Load parameter chians
% P-HM2 -- lysis inhibition model -- H1
load('Constrained_MCMCres_H1_Strain_0_delayLysis_1_date_18-Apr-2019.mat')
HM21 = resmcmc{1};

% P-HM2 -- initial model -- H0
load('Constrained_MCMCres_H0_Strain_0_delayLysis_0_date_18-Apr-2019.mat')
HM20 = resmcmc{1};

% P-SSP7 -- lysis inhibition model -- H0
load('Constrained_MCMCres_H0_Strain_1_delayLysis_1_date_18-Apr-2019.mat')
SSP70 = resmcmc{1};

% P-SSP7 -- initial model -- H0
load('Constrained_MCMCres_H0_Strain_1_delayLysis_0_date_18-Apr-2019.mat')
SSP700 = resmcmc{1};

% bin histograms
bin = 50;

% figure
fig = figure('DefaultAxesFontSize',20,'position',[0 0 1200 1500]);

%% Plot P-HM2
% Adsorption
hAx(1) = subplot(3,2,1);
hold on

h0 = histogram(exp(HM20.chain(:,1)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);
h1L = histogram(exp(HM21.chain(:,1)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 1);
h1D = histogram(exp(HM21.chain(:,2)),20000,'normalization','probability','Linestyle','none','FaceAlpha', 0.8);

h0.FaceColor = [100 100 100]/255;
h1L.FaceColor = [102 178 255]/255;
h1D.FaceColor = [8,29,88]/255;

h0.EdgeColor = [100 100 100]/255;
h1L.EdgeColor = [102 178 255]/255;
h1D.EdgeColor = [8,29,88]/255;

axis([10E-14 10E-7 0 0.1])
set(gca,'Xscale','log')
set(gca,'Xlim',[1E-14,1E-7])
set(gca,'xtick',[1E-14,1E-12,1E-10,1E-8])

ylabel('Probability')
%xlabel('Adsorption (mL hours^{-1})','Interpreter','Tex')
title('MED4 / P-HM2')


h1 = legend('$H0$','$\widetilde{H1_{\phi}}$ light','$\widetilde{H1_{\phi}}$ dark','interpreter','latex');
h1.Box = 'off';
h1.Position = [0.16    0.875    0.0708    0.0190];

% Latent period
hAx(3) = subplot(3,2,3);
hold on

h0 = histogram(exp(HM20.chain(:,2)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);
h1L = histogram(exp(HM21.chain(:,3)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);

h0.FaceColor = [100 100 100]/255;
h1L.FaceColor = [102 178 255]/255;

h0.EdgeColor = [100 100 100]/255;
h1L.EdgeColor = [102 178 255]/255;

axis([0 16 0 0.1])
set(gca,'Xlim',[0,16])
set(gca,'xtick',[0,4,8,12,16])

h11 = legend(h1L,'$\widetilde{H1_{\phi}}$ Constant','interpreter','latex');
h11.Box = 'off';
h11.Position = [0.1765    0.835    0.0708    0.0190];

%xlabel('Latent period (hours)','Interpreter','Tex')
ylabel('Probability')

% Burst size
hAx(5) = subplot(3,2,5);
hold on

h0 = histogram(exp(HM20.chain(:,3)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);
h1L = histogram(exp(HM21.chain(:,4)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);

h0.FaceColor = [100 100 100]/255;
h1L.FaceColor = [102 178 255]/255;

h0.EdgeColor = [100 100 100]/255;
h1L.EdgeColor = [102 178 255]/255;

axis([0 120 0 0.1])
set(gca,'xtick',[0,20,40,60,80,100,120])

%xlabel('Burst size','Interpreter','Tex')
ylabel('Probability')



%% Plot P-SSP7
% Adsorption
hAx(2) = subplot(3,2,2);
hold on

h0 = histogram(exp(SSP70.chain(:,1)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);
h00 = histogram(exp(SSP700.chain(:,1)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);

h00.FaceColor = [100 100 100]/255;
h0.FaceColor = [208,28,139]/255;

h00.EdgeColor = [100 100 100]/255;
h0.EdgeColor = [208,28,139]/255;

set(gca,'Xscale','log')
axis([10E-14 10E-7 0 0.1])
set(gca,'Xlim',[1E-14,1E-7])
set(gca,'xtick',[1E-14,1E-12,1E-10,1E-8])
title('MED4 / P-SSP7')

h1 = legend('$H0$','$\widetilde{H0}$','interpreter','latex');
h1.Box = 'off';
h1.Position = [0.585    0.875    0.0708    0.0190];

% Latent period
hAx(4) = subplot(3,2,4);
hold on

h0 = histogram(exp(SSP70.chain(:,2)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);
h00 = histogram(exp(SSP700.chain(:,2)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);

h00.FaceColor = [100 100 100]/255;
h0.FaceColor = [208,28,139]/255;

h00.EdgeColor = [100 100 100]/255;
h0.EdgeColor = [208,28,139]/255;

axis([3 16 0 0.1])
set(gca,'Xlim',[1,16])
set(gca,'xtick',[0,4,8,12,16])

% Burst size
hAx(6) = subplot(3,2,6);
hold on

h0 = histogram(exp(SSP70.chain(:,3)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);
h00 = histogram(exp(SSP700.chain(:,3)),bin,'normalization','probability','Linestyle','none','FaceAlpha', 0.4);

h00.FaceColor = [100 100 100]/255;
h0.FaceColor = [208,28,139]/255;

h00.EdgeColor = [100 100 100]/255;
h0.EdgeColor = [208,28,139]/255;

axis([0 120 0 0.1])
set(gca,'xtick',[0,20,40,60,80,100,120])

% axes labels
p1=get(hAx(1),'position'); 
p2=get(hAx(2),'position'); 
hAxOuter=axes('position',[p1(1) p2(2) p2(1)+p2(3)-p1(1)  p1(2)+p1(4)-p2(2)], ...
              'color','none','visible','off'); % an outer axis for the whole figure
hY=text(0.5,-0.15,'Adsorption (mL hours^{-1})','Interpreter','Tex','rotation',0,'fontsize',20, ... 
        'horizontalalignment','center','verticalalignment','top');
    
p1=get(hAx(3),'position'); 
p2=get(hAx(4),'position'); 
hAxOuter=axes('position',[p1(1) p2(2) p2(1)+p2(3)-p1(1)  p1(2)+p1(4)-p2(2)], ...
              'color','none','visible','off'); % an outer axis for the whole figure  
hY=text(0.5,-0.15,'Latent period (hours)','Interpreter','Tex','rotation',0,'fontsize',20, ... 
        'horizontalalignment','center','verticalalignment','top');

p1=get(hAx(5),'position'); 
p2=get(hAx(6),'position'); 
hAxOuter=axes('position',[p1(1) p2(2) p2(1)+p2(3)-p1(1)  p1(2)+p1(4)-p2(2)], ...
              'color','none','visible','off'); % an outer axis for the whole figure  
hY=text(0.5,-0.15,'Burst size','Interpreter','Tex','rotation',0,'fontsize',20, ... 
        'horizontalalignment','center','verticalalignment','top');

    
% clean some xaxis bug
set(hAx(2),'xtick',[1E-14,1E-12,1E-10,1E-8])
set(hAx(2),'XtickLabel',{'10^{-14}','10^{-12}','10^{-10}','10^{-8}'})

%% Export
% clean up figure
set(gcf, 'Color', 'w');
set(findall(gcf,'-property','Fontsize'),'Fontsize',20)
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman')
set(gcf,'renderer','Painters')
set(gcf,'Color','w')

% export
print -dpng -r300 figure6.png