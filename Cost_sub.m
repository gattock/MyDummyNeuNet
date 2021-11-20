function [loss_1] = Cost_sub(Xc,Xp,cycles,dim)
loss=0;
for f=1:cycles-1
    for j=1:dim
    loss= loss+ sqrt( (Xc(j,f)-Xp(j,f))^2 );
    end
end
% 1/cycles=dt/tmax-> integration dt;  integral average-> /tmax
loss_1=loss/(cycles-1);
    