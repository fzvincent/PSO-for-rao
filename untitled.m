clear all;
close all;
clc;
N=100;
D=10;
T=200;
c1=1.5;
c2=1.5;
w=0.8;
Xmax=20;
Xmin=-20;
Vmax=10;
Vmin=-10;

x=rand(N,D)*(Xmax-Xmin)+Xmin;
v=rand(N,D)*(Vmax-Vmin)+Vmin;

p=x;
pbest=ones(N,1);
for i=1:N
    pbest(i)=func1(x(i,:));
end

g=ones(1,D);
gbest=inf;
for i=1:N
    if(pbest(i)<gbest)
        g=p(i,:);
        gbest=pbest(i);
    end
end
gb=ones(1,T);

for i=1:T
    for j=1:N
        if(func1(x(j,:))<pbest(j))
            p(j,:)=x(j,:);
            pbest(j)=func1(x(j,1));
        end
        if(pbest(j)<gbest)
            g=p(j,:);
            gbest=pbest(j);
        end
        v(j,:)=w*v(j,:)+c1*rand*(p(j,:)-x(j,:))+c2*rand*(g-x(j,:));
        x(j,:)=x(j,:)+v(j,:);
        for ii=1:D
            if(v(j,ii)>Vmax||v(j,ii)<Vmax)
                v(j,ii)=rand*(Vmax-Vmin)+Vmin;
            end
            if(x(j,ii)>Xmax||x(j,ii)<Xmin)
                x(j,ii)=rand*(Xmax-Xmin)+Xmin;
            end
        end
    end
    gb(i)=gbest;
end
g;
gb(end);
figure
plot(gb)
xlabel('Iteration times');
ylabel('');

function result=func1(x)
summ=sum(x.^2);
result=summ;
end
                
