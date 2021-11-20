function [Ac_t] = NeuNet_sub (dim,nlay,nr,VN,NetPart)

for i=2:nlay
    for j=1:nr(i,1)
         for k=1:nr(i-1,1)
       VN(i,j)=VN(i,j)+VN(i-1,k)*NetPart(i-1,j,k); %j,k or k,j ? mind!
         end
   end
end

Ac_t=zeros(dim,1);
for i=1:dim
Ac_t(i)=VN(nlay,i);
end
