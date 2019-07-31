%% Plot chain
figure
pp = 1;
nbrBatches = 5;
%for pp = 1:size(MAT,1)
    hold on
    mcmcplot(exp(resmcmc{pp}.chain),[],resmcmc{pp}.results,'pairs');
    %end
drawnow 

figure
h = [1,3,5,7,9];
v = [2,4,6,8,10];

%for pp = 1:size(MAT,1)
	
	for z = 1:nbrBatches
		
	if delayLysis == 0
		 [tmod,ymod] = Modelplot_initial(data{z},median(resmcmc{pp}.chain));
	elseif delayLysis == 1
		 [tmod,ymod] = Modelplot_widetilde(data{z},median(resmcmc{pp}.chain));
	end
	
	subplot(nbrBatches,2,h(z))
	hold on
	plot(data{z}.ydata(:,1),data{z}.ydata(:,2),'o')
	plot(tmod,ymod(:,1)+ymod(:,2)+ymod(:,3),'-','linewidth',2)
	hold off
	set(gca,'Yscale','log')
	title('Host')
	xlabel('Hours')
	ylabel('Cell/ml')
	
	subplot(nbrBatches,2,v(z))
	hold on
	plot(data{z}.ydata(:,1),data{z}.ydata(:,3),'o')
	plot(tmod,ymod(:,4),'-','linewidth',2)
	hold off
	set(gca,'Yscale','log')
	title('Virus')
	xlabel('Hours')
	ylabel('Virus/ml')
end
	%end