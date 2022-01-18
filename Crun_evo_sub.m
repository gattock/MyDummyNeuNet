function [loss_1] = Crun_evo_sub(Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,NetPart)
format compact; %h is which caccia
VN=zeros(nlay,nrmax); %si resetta ogni round
t=0; 
Xc=zeros(dim,cycles); Vc=zeros(dim,cycles); %caccia I.C.
Ac=zeros(dim,cycles);
        
for i=1:cycles-1
           t=t+dt;
          VN(1,1)=Xp(1,i)-Xc(1,i);     VN(1,2)=Xp(2,i)-Xc(2,i); 
          VN(1,3)=Vp(1,i)-Vc(1,i);     VN(1,4)=Vp(2,i)-Vc(2,i);
          
          %subroutine NeuNet computation-> Ac
         [Ac(:,i)]= NeuNet_sub(dim,nlay,nrmax,nr,VN,NetPart);
          Xc(:,i+1)=Xc(:,i)+Vc(:,i)*dt;
          Vc(:,i+1)=Vc(:,i)+Ac(:,i)*dt;
           t=t+dt;              
end
%cost function subroutine  [loss_1]= Cost_sub(Xc,Xp,cycles,dim);
loss=0;
for f=1:cycles-1
    for j=1:dim
    loss= loss+ sqrt( (Xc(j,f)-Xp(j,f))^2 );
    end
end
loss_1=loss/(cycles-1);
