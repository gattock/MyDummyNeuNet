function [sciao] = Plot_sub(Xp,cycles,dim,ans,gen)
%plot parameters
axis(gca,'equal'); %same aspect ratio
axis([-6 6 -6 6]); %plot dominium RxR
filename=['XcSort' num2str(gen) '_' num2str(ans) '.txt'];
Xc=readmatrix(filename);
   %plot zone 
   PlotP=zeros(dim,1); PlotC=zeros(dim,1);
   for i=1:cycles
          PlotP=Xp(:,i).' ; PlotC=Xc(:,i).' ;
          P=viscircles(PlotP,0.04,'color','b');
          C=viscircles(PlotC,0.04,'color','r');
          pause(0.1);
          delete(P);delete(C);   
   end
   sciao=0;