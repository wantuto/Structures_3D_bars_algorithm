function [m_nod,tmass,Ms,total_m] = computeMass3D(x,Tn,mat,Tmat,M,rho_s,S,t_s,dim)
%--------------------------------------------------------------------------
% The function takes as inputs:
%   x       Nodal coordinates matrix (n x n_d)
%   Tn      Connectivities matrix (n_el x n_nod)
%   mat     Material data (Nmat x 5)
%   Tmat    Material connectivities vector (Nelements x 1)
%   M     PL mass
%   rho_s Density of the canvas
%   S     Surface area of the canvas
%   t_s   Thickness of the canvas
%   n     number of nodes
%   n_el  number of elements
%--------------------------------------------------------------------------
% It must provide as output:
%   m_nod Mass associated to each node (n x 1)
%--------------------------------------------------------------------------

m_nod = zeros(dim.n,1);
tmass = zeros(dim.n_el,1);
total_m = 0;

Ms = rho_s*t_s*S;

for e = 1:dim.n_el
    
     A = mat(Tmat(e,1),2);
     rho = mat(Tmat(e,1),3);
     
     x1 = x(Tn(e,1),1);
     x2 = x(Tn(e,2),1);
     y1 = x(Tn(e,1),2);
     y2 = x(Tn(e,2),2);
     z1 = x(Tn(e,1),3);
     z2 = x(Tn(e,2),3);
     
     l = sqrt((x2 - x1)^2 + (y2 - y1)^2 + (z2 - z1)^2);
     
     massb = A*l*rho;
     tmass(e,1) = massb;
     total_m = total_m + massb;
     
     for i = 1:2
         
         m_nod(Tn(e,i),1) = m_nod(Tn(e,i),1) + massb/2  ;
             
     end
end
     
    m_nod = m_nod + [
     M; 0; 0; 0; 0; Ms/16; Ms/8;
    Ms/16; Ms/8; Ms/4; Ms/8; Ms/16; Ms/8; Ms/16;    
    ];

    total_m = total_m + M + Ms;
     
end 