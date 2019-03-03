clear all
clc;
time=xlsread('15min.xlsx');
number=xlsread('number.xlsx');
people=number(1:end-1,1);
D_constant=95;                           %needs
S_constant=64;                           %suppliers
fun1=zeros(D_constant,S_constant);       %time matrix between suppliers and needs
for i=1:length(time)
    fun1(time(i,3),time(i,4))=time(i,6);
end


supply=zeros(D_constant,1);
%num=num'
for i=1:D_constant
    supply(i)=fun1(i,:)*people;
end
Supply=sum(supply);

function result=func1(x,d)
summ=sum((func2(d)-3).^2);
result=summ;
end

