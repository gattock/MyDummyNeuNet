function [onegrad] = Grad_comp_sub(Xp,Vp,cycles,dim,nlay,nr,nrmax,tmax,dt,NetPart)

deps=0.1; %grad discretization: related with Learning Rate??? MIND! 

NetPart2=zeros(nlay-1,nrmax,nrmax);
NetPart1=zeros(nlay-1,nrmax,nrmax);
onegrad=zeros(nlay-1,nrmax,nrmax);
for i=1:nlay-1 %which layer
    for j=1:nr(i) %arrival raw
        for k=1:nr(i+1) %start raw
        %calcola Loss (Net'')-Loss(Net')
        eps=zeros(nlay-1,nrmax,nrmax);
        eps(i,j,k)=deps;
        NetPart2=NetPart+eps; %epsilon al posto i,j,k?
        NetPart1=NetPart-eps;
[loss2]=Crun_evo_sub (Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,NetPart2);    
[loss1]=Crun_evo_sub (Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,NetPart1);
onegrad(i,j,k)=(loss2-loss1);%/(2*deps); MIND STEP
        end
    end
end

