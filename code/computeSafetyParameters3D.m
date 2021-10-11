function [sig_max,sig_min,scoef_c,scoef_b,sig_cr] = computeSafetyParameters3D(x,dim,Tn,Tmat,mat,sig)
%--------------------------------------------------------------------------
% The function takes as inputs:
%   x       Nodal coordinates matrix (n x n_d)
%   Tn      Connectivities matrix (n_el x n_nod)
%   Fext    Matrix with external forces data (Nforces x 3)
%   fixNod  Matrix with fixed displacement data (Nfixed x 3)
%   Tmat    Material connectivities vector (n_el x 1)
%   mat     Material data (Nmat x 5)
%--------------------------------------------------------------------------
% It must provide as output:
%   sig_max    Maximum stress value (1 x 1)
%   sig_min    Minimum stress value (1 x 1)
%   scoef_c    Safety coefficient to tension (1 x 1)
%   scoef_b    Safety coefficient to compression (1 x 1)
%--------------------------------------------------------------------------
% Hint: Compute the critial stress for buckling to determine the safety
% coeficients

sig_max = max(sig);
sig_min = min(sig);

A = mat(Tmat(:,1),2);
E = mat(Tmat(:,1),1);
I = mat(Tmat(:,1),4);
YS = mat(Tmat(:,1),5);

x1 = x(Tn(:,1), 1);
y1 = x(Tn(:,1), 2);
z1 = x(Tn(:,1), 3);
x2 = x(Tn(:,2), 1);
y2 = x(Tn(:,2), 2);
z2 = x(Tn(:,2), 3);

l = sqrt((x2 - x1).^2 + (y2 - y1).^2 + (z2 - z1).^2);

sig_cr = (pi^2.*E.*I) ./ ((l.^2).*A);

scoef_b = - sig_cr ./ sig;
scoef_b = min(scoef_b(scoef_b > 0));

scoef_c = min(YS ./ sig_max);
end