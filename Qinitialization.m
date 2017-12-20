%This function initializes the agents randomly.
function [Qbit]=Qinitialization(N,L)

%Qbit=rand(N,dim);
%Qbit(:,:,2)=sqrt(1-(Qbit(:,:,1).^2));
%Qbit(1:N,1:L,1:2)=1/sqrt(2);

Qbit(:,:,1)=-1+2*rand(N,L);
Qbit(:,:,2)=-1+2*rand(N,L);
AA=sqrt(Qbit(:,:,1).^2+Qbit(:,:,2).^2);
Qbit(:,:,1)=Qbit(:,:,1)./AA;
Qbit(:,:,2)=Qbit(:,:,2)./AA;


return;

