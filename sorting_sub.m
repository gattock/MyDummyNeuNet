function [XcSort,LossSort,NewNet] = sorting_sub(dim,Nc,Loss0,cycles,Net,gen)
%import xc
XcSort=zeros(dim,cycles,Nc);
format compact;
                        %list=1:1:Nc
% X,Loss,Net sorting
for i=1:Nc %each of new
    for j=1:Nc %each of old
        
    if (Loss0(j)==max(Loss0))
        LossSort(Nc-i+1)=Loss0(j);
        XcSort(:,:,Nc-i+1)=readmatrix('out1.xlsx','Sheet',j,'Range','C2');
        NewNet(gen,Nc-i+1,:,:,:)=Net(gen,j,:,:,:); % DA TESTARE CON Replay
        Loss0(j)=0;                                               
        %Newlist(Nc-i+1)=list(j);   %NewNet testato con list-Newlist
        break
    end
    
    end
end
%Newlist
