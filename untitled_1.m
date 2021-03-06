clear all;
close all;
clc;

%%
time=xlsread('15min.xlsx');
number=xlsread('number.xlsx');
%%
D_constant=95;                           %needs
S_constant=64;                           %suppliers

N=95;
D=1;
T=200;
c1=1.5;
c2=1.5;
w=0.8;
Vmax=5;
Vmin=-5;

year=30;
if year==30
    Xmax=round(15*number(1:end-1,5)/1000);
    Xmin=number(1:end-1,5);
else
    Xmax=round(15*number(1:end-1,5)/1000);
    Xmin=ones(S_constant,1);
end

x=rand(N,D)*(Xmax-Xmin)+Xmin;
v=rand(N,D)*(Vmax-Vmin)+Vmin;


%%
people=number(1:end-1,1);

reaction=zeros(D_constant,S_constant);       %time matrix between suppliers and needs
for i=1:length(time)
    reaction(time(i,3),time(i,4))=time(i,6);
end


supply=zeros(D_constant,1);
%num=num'
for i=1:D_constant
    supply(i)=reaction(i,:)*people;
end
Supply=sum(supply);


%%%%%%%
p=x;
pbest=ones(N,1);
for i=1:N
    pbest(i)=func1(x(i,:),reaction);
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
        if(func1(x(j,:),reaction)<pbest(j))
            p(j,:)=x(j,:);
            pbest(j)=func1(x(j,1),reaction);
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

function result=func1(x,reaction)
summ=sum((sum(x'*reaction)).^2);
result=summ;
end