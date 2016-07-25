%this code is for computing the analytical stefan problem and comparing to
%the pseudo-steady state approximation
function max_plomer_heatmassmatlabcode4()
clc;clear;format long

c1=4.1818;    % heat capacity of water        [J/(g·K) water at 20 deg C]
TL= 300;      % temperature of liquid at x=0  [K]
Tf= 273.15;   % temperature of melting        [K]
L= 334;       % latent heat of fusion         [J/g of water]

k1=0.58;               % thermal conductivity of liquid water  [W/(m*K)]   
rho1= 0.99777e6 ;      % density (constant for both phases)    [g/m^3]
alpha1= k1/(c1*rho1);  % thermal difusivity of phase 1
St=c1*(TL-Tf)/L;       % one form of the stefan #

f=@(x) x*exp(x^2)*erf(x) - St/sqrt(pi);
lambda=fzero(f,2);

%analytical stefan solution
f1=@(t) 2*lambda*sqrt(alpha1*t); 

%PSS aproximation stefan solution
f2=@(t) sqrt( 2*t*(TL-Tf)*k1/ (rho1*L));

%PSS quadratic aproximation stefan soluton
rad=sqrt(1-2*c1*(Tf-TL)/L);
f3=@(t) sqrt(-(1-rad)*t*2*k1/(rho1*c1));


t=0:1:10;
for i=1:length(t)
   f_anal(i)=f1(t(i));
   f_pss(i)=f2(t(i));
   f_pssquad(i)=f3(t(i));
   errorpss(i)=abs(f1(t(i))-f2(t(i)))/max(f1(t(i)),f2(t(i)));
   errorpssquad(i)=abs(f1(t(i))-f3(t(i)))/max(f1(t(i)),f3(t(i)));
end
t'
f_anal'
f_pss'
f_pssquad'
errorpss'
errorpssquad'


end
