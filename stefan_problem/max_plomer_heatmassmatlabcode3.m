%this code is for comparing X(t) for PSS, and PSS w/ newton cooling
function max_plomer_heatmassmatlabcode3()
clc;clear;format long

c1=4.1818;    % heat capacity of water        [J/(g·K) water at 20 deg C]
Tl= 300;      % temperature of liquid at x=0  [K]
Tf= 273.15;   % temperature of melting        [K]
L= 334;       % latent heat of fusion         [J/g of water]

k1=0.58;               % thermal conductivity of liquid water  [W/(m*K)]   
rho1= 0.99777e6 ;      % density (constant for both phases)    [g/m^3]
h= 1;                 % convective heat transfer coefficient    [W/(m^2*K)]

%PSS aproximation stefan solution  t=f(X)
f1=@(X)  X^2*rho1*L/(2*(Tl-Tf)*k1)  ;
%PSS aproximation stefan solution w/ newton cooling at x=0
f2=@(X)  (0.5*X^2*h + k1*X)*rho1*L/((Tl-Tf)*h*k1)  ;

X=0:1:10;
for i=1:length(X)
    f_pss(i)=f1(X(i));
    f_pssnc(i)=f2(X(i));
end
X'
f_pss'
f_pssnc'
end
