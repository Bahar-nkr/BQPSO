function [ Gbest,GVbest] = BQPSO( N,  dim, max_it, train,train_labels )
Qbit=Qinitialization(N,dim);
V=zeros(N,dim);
theta_min=0.001.*pi;theta_max=0.05.*pi;
for it=1:max_it
    X=Qobservation(Qbit,N,dim);
    for aa=1:N
        fitness(aa)=MyCost(X(aa,:),train,train_labels);
    end
    [MAX , IND]=max(fitness);
    if it==1
        Pbest=X;
        PVbest=fitness;
        Gbest=X(IND,:);
        GVbest=fitness(IND);
        landa1=zeros(1,N);
        landa2=zeros(1,N);
    else
        for i=1:length(fitness)
            if  fitness(i)>=PVbest(i)
                Pbest(i,:)=X(i,:);
                PVbest(i)=fitness(i);
            end
        end
        if MAX>=GVbest
            GVbest=MAX;
            Gbest=X(IND,:);
        end
        for i=1:length(fitness)
            if  fitness(i)>=PVbest(i)
                landa1(i)=0;
            else
                landa1(i)=1;
            end
            if  fitness(i)>=GVbest
                landa2(i)=0;
            else
                landa2(i)=1;
            end
        end
    end
    theta=theta_max-((theta_max-theta_min).*(it./max_it));
    for ii=1:N
        LANDA1=landa1(ii);
        LANDA2=landa2(ii);
        for jj=1:dim
    delta_theta(ii,jj)=theta.*((LANDA1.*(Pbest(ii,jj)-X(ii,jj)))+(LANDA2.*(Gbest(jj)-X(ii,jj))));
        end
    end
    [Qbit]=Qmove(Qbit,N,dim,delta_theta);
    
end


end

