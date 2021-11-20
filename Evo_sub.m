function [bla] = Evo_sub(Xp,Vp,cycles,dim,nlay,nr,tmax,dt,Net)

eps=0.05; %grad discretization

for i=2:nlay-1
    for j=1:nr(i)
        %calcola Loss (Net'')-Loss(Net')
[loss'']=Crun_sub (Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,NetPart);    
[loss']=Crun_sub (Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,NetPart);        
    end
end



