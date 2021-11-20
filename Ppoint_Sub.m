function [Xp,Vp] = Ppoint_sub(dt,cycles,dim)
arena=3; k1=1.4; k2=1.6;
Xp=zeros(dim,cycles); Vp=zeros(dim,cycles);

for i=1:cycles
 t=double(i)*dt;
%lissajous ignorante, will become random
 Xp(:,i)=arena*[cos(t/k1) cos(t/k2)]; 
 Vp(:,i)=arena*[-sin(t/k1)/k1 -sin(t/k2)/k2];
end
 