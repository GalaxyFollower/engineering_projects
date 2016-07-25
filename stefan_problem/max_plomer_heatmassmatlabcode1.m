%this code is for computing the analytical stefan problem and comparing to
%the pseudo-steady state approximation
function max_plomer_heatmassmatlabcode1()
clc;clear;format long

c1=4.1818;    % heat capacity of water        [J/(g·K) water at 20 deg C]
Tl= 300;      % temperature of liquid at x=0  [K]
Tf= 273.15;   % temperature of melting        [K]
L= 334;       % latent heat of fusion         [J/g of water]

k1=0.58;               % thermal conductivity of liquid water  [W/(m*K)]   
rho1= 0.99777e6 ;      % density (constant for both phases)    [g/m^3]
alpha1= k1/(c1*rho1);  % thermal difusivity of phase 1
St=c1*(Tl-Tf)/L;       % one form of the stefan #

f=@(x) x*exp(x^2)*erf(x) - St/sqrt(pi);
lambda=fzero(f,2);

%analytical stefan solution
f2=@(t) 2*lambda*sqrt(alpha1*t); 
f3=@(x,t) Tl-(Tl-Tf)*erf(  x/(2*sqrt(alpha1*t))  )/erf(lambda); 

%PSS aproximation stefan solution
f4=@(t) sqrt( 2*t*(Tl-Tf)*k1/ (rho1*L));
f5=@(x,t) Tl - x*(Tl-Tf)/f4(t); 

time=1e29;
f2(time)
f4(time)

error=abs(f2(time)-f4(time))/max(f2(time),f4(time))


end
