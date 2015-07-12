clc;clear;
format long;
N=200000;
dt=0.00001;
i11=100;i22=200;i33=350;
w10=10;w20=0.1;w30=0.1;

w1=w10;w2=w20;w3=w30;
for i=1:N
    t=i*dt;
    w1=w1-[(i33-i22)/i11]*dt*w2*w3;
    w2=w2-[(i11-i33)/i22]*dt*w1*w3;
    w3=w3-[(i22-i11)/i33]*dt*w1*w2;
    
    tgraph(i)=t;
    w1graph(i)=w1;
    w2graph(i)=w2;
    w3graph(i)=w3;
    
    
    
end

figure(1)
% plot(tgraph,w1graph,'x')
% hold on
plot(tgraph,w2graph,'o')
hold on
plot(tgraph,w3graph,'x')

figure (2)

plot(w2graph,w3graph)

%checking with analytical solution
w0=w10;
Wn= w0*((i11-i22)*(i11-i33)/(i22*i33))^0.5;
period = 2*pi/Wn
% period =
% 
%    1.051377997164677