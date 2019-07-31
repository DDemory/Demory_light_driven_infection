%% Figure 1 - 2019Demory_light
% plot experimental plots of P-HM2 and P-SSP7 infecting strain MED4 in
% light or dark conditions. 

%% initiate figure
close all; clear all; clc;
set(groot,{'DefaultAxesXColor','DefaultAxesYColor','DefaultAxesZColor'},{'k','k','k'})
%figure('position',[0 1 600 320])
figure('position',[0 1 1200 640])

%% Plots P-HM2 / MED4

% -- load data
id = 1;
d = xlsread('fig1_data_v2.xlsx',id);
t = d(:,1);
repL1 = d(:,2);
repL2 = d(:,3);
repD1 = d(:,4);
repD2 = d(:,5);

% -- plots
hAx(id) = subplot(1,2,id);
hold on

% light
p3L = plot(t,(repL1+repL2)/2,'k-','LineWidth',2);
plot([0 40],[1 1],'k:','LineWidth',1)
p1L = plot(t,repL1,'ko','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');
p2L = plot(t,repL2,'ks','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');

% dark
p3D = plot(t,(repD1+repD2)/2,'k--','LineWidth',2);
p1D = plot(t,repD1,'ko','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');
p2D = plot(t,repD2,'ks','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');

% info
%title('MED4/P-HM2')
%ylabel({'Extracellular phage DNA';'relative to T0'})
%text(7.5,-3.5,'Hours after infection') 
axis([0 10 -2 11])

% Zoom first hours
aa = axes('position',[0.2 .58 .13 .3], 'NextPlot', 'add');
hold on

% light
p3L = plot(t,(repL1+repL2)/2,'k-','LineWidth',2);
plot([0 40],[1 1],'k:','LineWidth',1)
p1L = plot(t,repL1,'ko','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');
p2L = plot(t,repL2,'ks','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');

% dark
p3D = plot(t,(repD1+repD2)/2,'k--','LineWidth',2);
p1D = plot(t,repD1,'ko','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');
p2D = plot(t,repD2,'ks','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');

set(aa,'Xlim',[0 4])

%% Plots P-SSP7 / MED4
% -- load data
id = 2;
d = xlsread('fig1_data_v2.xlsx',id);
t = d(:,1);
repL1 = d(:,2);
repL2 = d(:,3);
repD1 = d(:,4);
repD2 = d(:,5);

% -- plot
hAx(id) = subplot(1,2,id);
hold on

% light
p3L = plot(t,(repL1+repL2)/2,'k-','LineWidth',2);
plot([0 40],[1 1],'k:','LineWidth',1)
p1L = plot(t,repL1,'ko','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');
p2L = plot(t,repL2,'ks','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');

% dark
p3D = plot(t,(repD1+repD2)/2,'k--','LineWidth',2);
p1D = plot(t,repD1,'ko','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');
p2D = plot(t,repD2,'ks','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');

% Info
%title('MED4/P-SSP7')
axis([0 10 -2 11])

% Zoom first hours 
aa = axes('position',[0.65 .58 .13 .3], 'NextPlot', 'add');
hold on

plot([0 40],[1 1],'k:','LineWidth',1)

% light
p3L = plot(t,(repL1+repL2)/2,'k-','LineWidth',2);
plot([0 40],[1 1],'k:','LineWidth',1)
p1L = plot(t,repL1,'ko','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');
p2L = plot(t,repL2,'ks','MarkerFaceColor','w','MarkerSize',10,'linestyle','none');

% dark
p3D = plot(t,(repD1+repD2)/2,'k--','LineWidth',2);
p1D = plot(t,repD1,'ko','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');
p2D = plot(t,repD2,'ks','MarkerFaceColor','k','MarkerSize',10,'linestyle','none');

set(aa,'Xlim',[0 4])

% axes labels
p1=get(hAx(1),'position'); 
p2=get(hAx(2),'position'); 
hAxOuter=axes('position',[p1(1) p2(2) p2(1)+p2(3)-p1(1)  p1(2)+p1(4)-p2(2)], ...
              'color','none','visible','off'); % an outer axis for the whole figure
%Ylabel          
hX=text(-0.1,0.5,{'Extracellular phage DNA';'relative to T0'},'rotation',90,'fontsize',11, ...
        'horizontalalignment','center','verticalalignment','bottom'); 
%Xlabel    
hY=text(0.5,-0.1,'Hours after infection','rotation',0,'fontsize',11, ... 
        'horizontalalignment','center','verticalalignment','top');

%% Export
% figure cleanup
set(gcf,'color','w')
set(findall(gcf,'-property','FontSize'),'FontSize',20)
set(findall(gcf,'-property','FontName'),'FontName','Times New Roman')
set(gcf,'renderer','Painters')

% export
%print -dpdf -r300 -painters figure1.pdf
%print -depsc2 -tiff -r300 -painters figure1.eps
print -dpng -r600 -painters figure1.png
