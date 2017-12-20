
%This function updates the velocity and position of agents.
function [Qbit]=Qmove(Qbit,N,dim,delta_theta)
for i=1:N
    for j=1:dim
        alpha=Qbit(i,j,1);   beta=Qbit(i,j,2); %

        TETA=delta_theta(i,j);
        newangle=[cos(TETA),-sin(TETA); sin(TETA),cos(TETA)]*[alpha; beta];   
   
        Qbit(i,j,1)=newangle(1); Qbit(i,j,2)=newangle(2);
    end
end
return;

