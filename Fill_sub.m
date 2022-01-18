function [Net,Loss] = Fill_sub(Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,Net,h,sur,Nc,gen,Loss)

interv=round(Nc/sur)-1;
    for j=1: interv
        k=(sur+interv*(h-1)+j);
    
    NetPart=reshape(Net(gen-1,h,:,:,:),nlay-1,nrmax,nrmax)+(rand(nlay-1,nrmax,nrmax)-0.5)*0.3;
    Net(gen,k,:,:,:)=NetPart;
    
    [loss_temp]=Crun_sub (Xp,Vp,cycles,k,gen,dim,nlay,nrmax,nr,tmax,dt,NetPart);
    Loss(gen,k)=loss_temp;
    end

    