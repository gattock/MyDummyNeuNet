clc; clear all; userpath('C:\Users\Enrico Di Lavore\Documents\AAA TTU\Code&Stack\Z-Caccia')
format compact;
dt=0.1 ; tmax=20; dim=2; cycles=int32(tmax/dt);
Nc=9;  genmax=100; gen=1;%Number of caccia(mult. of 6), number of generations
nlay=8; nr=zeros(nlay,1); %number of layers and rows for each lay
for i=2:nlay-1
nr(i)=(i*(nlay-i));
end
nr(1)=2*dim; nr(nlay)=dim;
nrmax=max(nr);

%tensor with matrix (nrmax,nrmax) for each layer. Nc times
Net=rand(genmax,Nc,nlay-1,nrmax,nrmax)-0.5;
            %filename=['Net' num2str(gen) '.txt'];
            %writematrix(Net(gen,:,:,:,:),filename);

%performance evaluation
Loss=zeros(gen,Nc);   %%%later have to become genmax!
%subroutine P
[Xp,Vp]= Ppoint_Sub(dt,cycles,dim); 

for h=1:Nc %first gen, every caccia
     NetPart=zeros(nlay-1,nrmax,nrmax); %1 caccia from 1 gen
     NetPart=reshape(Net(gen,h,:,:,:),nlay-1,nrmax,nrmax);
     loss_temp=0;
    [loss_temp]=Crun_sub (Xp,Vp,cycles,h,gen,dim,nlay,nrmax,nr,tmax,dt,NetPart);
     Loss(gen,h)=loss_temp;
end
Loss

[XcSort,LossSort_temp,Net]= sorting_sub(dim,Nc,Loss,cycles,Net,gen);
LossSort=zeros(genmax,Nc); 
LossSort(gen,:)=LossSort_temp; 
LossSort_temp
clear LossSort_temp ; clear loss-temp ;

%plot    (conditional on a question-answer) 
risp=1;  sciao=0; n='n';
while ne(risp,n)
    prompt = 'Wanna plot one caccia? If yes, type the rank. If not type n';
risp=input(prompt)
if ne(risp,n)
    [sciao] = Plot_sub(Xp,cycles,dim,risp,gen)
end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%
gen=2;
gen

%gradient descent 
sur=round(Nc/3) ; %survived ones
Grad=zeros(genmax,sur,nlay-1,nrmax,nrmax);
for h=1:sur
     NetPart=reshape(Net(gen-1,h,:,:,:),nlay-1,nrmax,nrmax); %check which one
     [onegrad] = Grad_comp_sub(Xp,Vp,cycles,dim,nlay,nr,nrmax,tmax,dt,NetPart);
    Grad(gen,sur,:,:,:)=onegrad;
   
    LR=0.5; %learning rate: FIND ADAPTIVE FORMULA
    update=reshape(Grad(gen,h,:,:,:).*LR,nlay-1,nrmax,nrmax); %plus or minus????
    NetPart=NetPart-update;
    Net(gen,2,:,:,:)=NetPart;
    [loss_temp]=Crun_sub (Xp,Vp,cycles,h,gen,dim,nlay,nrmax,nr,tmax,dt,NetPart);
    Loss(gen,h)=loss_temp;
    [Net,Loss] = Fill_sub(Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,Net,h,sur,Nc,gen,Loss);
end
Loss_temp=Loss(gen,:)

[XcSort,LossSort_temp,Net]= sorting_sub(dim,Nc,Loss_temp,cycles,Net,gen);
LossSort(gen,:)=LossSort_temp;
gen
LossSort(gen-1,:)
LossSort_temp
clear LossSort_temp

for gen=3:genmax
    gen
for h=1:sur
     NetPart=reshape(Net(gen-1,h,:,:,:),nlay-1,nrmax,nrmax); %check which one
     [onegrad] = Grad_comp_sub(Xp,Vp,cycles,dim,nlay,nr,nrmax,tmax,dt,NetPart);
    Grad(gen,sur,:,:,:)=onegrad;
   
    LR=0.1; %learning rate: FIND ADAPTIVE FORMULA
    update=reshape(Grad(gen,h,:,:,:).*LR,nlay-1,nrmax,nrmax); %plus or minus????
    NetPart=NetPart-update;
    Net(gen,2,:,:,:)=NetPart;
    [loss_temp]=Crun_sub (Xp,Vp,cycles,h,gen,dim,nlay,nrmax,nr,tmax,dt,NetPart);
    Loss(gen,h)=loss_temp;
    [Net,Loss] = Fill_sub(Xp,Vp,cycles,dim,nlay,nrmax,nr,tmax,dt,Net,h,sur,Nc,gen,Loss);
end
Loss_temp=Loss(gen,:)

[XcSort,LossSort_temp,Net]= sorting_sub(dim,Nc,Loss_temp,cycles,Net,gen);
LossSort(gen,:)=LossSort_temp;
LossSort_temp
clear LossSort_temp

  %  [sciao] = Plot_sub(Xp,cycles,dim,1,gen?)
end

%%french-toasto%->resilience training by zeroing half of nodes
%early stopping introduction