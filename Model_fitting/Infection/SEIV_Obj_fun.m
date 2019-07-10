function err = SEIV_Obj_fun(theta,data,local)

%theta
nbatch = length(data);

err = 0;
W = 12;
th = theta(local==0|local==1);

for i=1:nbatch
    
    tspan  = data{i}.ydata(:,1);
    ydata  = data{i}.ydata(:,2:3);
    
    if data{i}.delayLysis == 0;
        ymodel = Modelfun_initial(data{i},th);
    elseif data{i}.delayLysis == 1;
        ymodel = Modelfun_widetilde(data{i},th);
    end
    
    ydataH = ydata(:,1); ydataH(isnan(ydataH) == 1) = [];
    ydataV = ydata(:,2); ydataV(isnan(ydataV) == 1) = [];
    Hmod = ymodel(:,1)+ymodel(:,2)+ymodel(:,3);
    tH = tspan(isnan(data{i}.ydata(:,2)) == 0);
    Vmod = ymodel(:,4);
    tV = tspan(isnan(data{i}.ydata(:,3)) == 0);
    
    yH = interp1(tspan,Hmod,tH);
    yV = interp1(tspan,Vmod,tV);
    
    nmseH = (1/(length(ydataH)))*sum(log(yH./ydataH).^2);
    
    errlocal = [];
    for j = 1:length(ydataV)
        temp = log(yV(j)./ydataV(j)).^2;
        if j > length(ydataV)-3
            temp = W*temp;
        end
        errlocal = [errlocal,temp];
    end
    
    nmseV = (1/(length(ydataV)))*sum(errlocal);
    err = real(err + nmseH + nmseV);
    
end
end
