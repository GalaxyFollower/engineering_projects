%this code is for the finite element stefan problem using the enthalpy
%method in book "Phase Transformations"
function heatmassproject2()
clc;clear;format long

c1=4.1818;   % heat capacity of water         [J/(g·K) water at 20 deg C] 
c2=2.05;     % heat capacity of ice           [J/(g·K) ice at -10 deg C] 
T1= 300;     % temperature of liquid at x=0   [K]
Tf= 273.15;  % temperature of melting         [K]
T2= Tf;%250;     % temperature of solid at xmax   [K]
L= 334;      % latent heat of fusion          [J/g of water]


k1=0.58;              % thermal conductivity of liquid water  [W/(m*K)] 
k2=2.18;              % thermal conductivity of ice           [W/(m*K) ice at 0 deg C]      
rho1= 0.99777e6 ;     % density (constant for both phases)    [g/m^3]
alpha1= k1/(c1*rho1); % thermal difusivity of phase 1
alpha2= k2/(c2*rho1); % thermal difusivity of phase 2


%%%%Finite difference%%%%%

%stability requires alpha*deltat <=0.5*(deltax)^2
deltax=1e-6;
deltat=(1/10)*(deltax^2)/(2*max(alpha1,alpha2));
N=50; %number of nodes, x=0 at node 1
timesteps=100000;
timesteps*deltat

h=zeros(N,1);
h(1)=(T1-Tf)*c1+L;
h(2:N)=(T2-Tf)*c2;
hnew=h;




for i=1:timesteps
    for j=2:(N-1)
        q1=-[getk(h(j+1))+getk(h(j))]*[getT(h(j+1)) - getT(h(j))]/(2*deltax);
        q2=-[getk(h(j))+getk(h(j-1))]*[getT(h(j)) - getT(h(j-1))]/(2*deltax);
        
        hnew(j) = h(j) + (q2 - q1)*deltat/(deltax*rho1);


    end
    q1=0;
    q2=-[getk(h(N))+getk(h(N-1))]*[getT(h(N)) - getT(h(N-1))]/(2*deltax);
    hnew(N)=h(N) + (q2 - q1)*deltat/(deltax*rho1);
    h=hnew;
end

for i=1:N
    T(i)=getT(h(i));
end
T'




end

function [k]=getk(h)
    L= 334;
    k1=0.58;   
    k2=2.18; 
    if h<=0
        k=k1;
    end
    if 0<h && h<L
       k=(k1+k2)/2; 
    end
    if h>=L
       k=k2;
    end

end

function [T]=getT(h)
    L= 334;
    c1=4.1818;   
    c2=2.05;
    Tf= 273.15;
    if h<=0
        T=Tf +h/c2;
    end
    if 0<h && h<L
       T=Tf; 
    end
    if h>=L
        T=Tf + (h-L)/c1;
    end

end