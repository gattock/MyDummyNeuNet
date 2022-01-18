function [XcSort,LossSort,NewNet] = sorting_sub(dim,Nc,Loss0,cycles,Net,gen)
%import xc %losssort is temp
XcSort=zeros(dim,cycles,Nc);
format compact;

% X,Loss,Net sorting
for i=1:Nc %each of new
    for j=1:Nc %each of old
        
    if (Loss0(j)==max(Loss0))
        LossSort(Nc-i+1)=Loss0(j);
        string=num2str(i);
        filename=['Xc' num2str(gen) '_' string '.txt']; 
        %filenum=strcat('Xc',num2str(gen),'_',num2str(i),'.txt');
        XcSort(:,:,Nc-i+1)=readmatrix(filename);
        filename=['XcSort' num2str(gen) '_' string '.txt'];
        writematrix(XcSort(:,:,Nc-i+1), filename);
        NewNet(gen,Nc-i+1,:,:,:)=Net(gen,j,:,:,:); 
        Loss0(j)=0;                                               
        break
    end
    
    end
end
