%this code is for simpliflying the polynomial for the newton cooling
%pseudo-steady state aproximation stefan problem
function max_plomer_heatmassmatlabcode2()
clc;clear;format long

syms TF k1 T0 X h f g
g=       (TF*k1/(X*h) + T0)/(1 + k1/(X*h)) ;
f=(g-TF)/X;
f=simple(f)


end
