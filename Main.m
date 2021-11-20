clc; clear all; 
format compact;
dt=0.1 ; tmax=8; dim=2; cycles=int32(tmax/dt);
Nc=6;  genmax=10; gen=1;%Number of caccia(mult. of 6), number of generations
nlay=8; nr=zeros(nlay,1); %number of layers and rows for each lay
for i=2:nlay-1
nr(i)=(i*(nlay-i));
end
nr(1)=2*dim; nr(nlay)=dim;
nrmax=max(nr);

%tensor with matrix (nrmax,nrmax) for each layer. Nc times
Net=rand(genmax,Nc,nlay-1,nrmax,nrmax)-0.5;

%performance evaluation
Loss=zeros(gen,Nc);   %%%later have to become genmax!
%subroutine P
[Xp,Vp]= Ppoint_Sub(dt,cycles,dim); 

for h=1:Nc %first gen, every caccia
     NetPart=zeros(nlay-1,nrmax,nrmax);
     NetPart=reshape(Net(gen,h,:,:,:),nlay-1,nrmax,nrmax);
     loss_1=0;
    [loss_1]=Crun_sub (Xp,Vp,cycles,h,gen,dim,nlay,nrmax,nr,tmax,dt,NetPart);
     Loss(gen,h)=loss_1;
end
Loss

[XcSort,LossSort,Net]= sorting_sub(dim,Nc,Loss,cycles,Net,gen);
LossSort

for h=1:Nc
writematrix(XcSort,'OutSort.xlsx','Sheet',h,'Range','C2');
writematrix(LossSort(h),'OutSort.xlsx','Sheet',h,'Range','A2');
end

%plot    (conditional on a question-answer) 
risp=1;  sciao=0; n='n';
while ne(risp,n)
    prompt = 'Wanna plot one caccia? If yes, type the rank. If not type n';
risp=input(prompt)
if ne(risp,n)
    [sciao] = Plot_sub(Xp,cycles,dim,risp)
end
end
    
%gradient descent 
k=Nc/6; %survived ones
for i=1:k
[bla] = Evo_sub(Xp,Vp,cycles,dim,nlay,nr,tmax,dt,Net)
    
end
                %(genmax,Nc,nlay-1,nrmax,nrmax)
%check for well fitting
%%french-toasto%resilience training by zeroing half of nodes

