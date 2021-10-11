function [ur,vr,vl,u,R] = solveSys3D(dim,fixNod,KG,f)
%--------------------------------------------------------------------------
% The function takes as inputs:
%   - Dimensions:  n_i      Number of DOFs per node
%                  n_dof           Total number of DOFs
%   - fixNod  Prescribed displacements data [Npresc x 3]
%              fixNod(k,1) - Node at which the some DOF is prescribed
%              fixNod(k,2) - DOF (direction) at which the prescription is applied
%              fixNod(k,3) - Prescribed displacement magnitude in the corresponding DOF
%   - KG      Global stiffness matrix [n_dof x n_dof]
%              KG(I,J) - Term in (I,J) position of global stiffness matrix
%   - f       Global force vector [n_dof x 1]
%              f(I) - Total external force acting on DOF I
%--------------------------------------------------------------------------
% It must provide as output:
%   - u       Global displacement vector [n_dof x 1]
%              u(I) - Total displacement on global DOF I
%   - R       Global reactions vector [n_dof x 1]
%              R(I) - Total reaction acting on global DOF I
%--------------------------------------------------------------------------
% Hint: Use the relation between the DOFs numbering and nodal numbering to
% determine at which DOF in the global system each displacement is prescribed.

 ur = zeros(size(fixNod,1),1);
 vr = zeros(size(fixNod,1),1);
 for i = 1:size(fixNod,1)
     
     ur(i,1) = fixNod(i,3);     
     vr(i,1) = dim.n_i*(fixNod(i,1) - 1 ) + fixNod(i,2);
     
 end
 
 vl = [1:dim.n_dof]';
 vl(vr) = [];
 
 
 KLL = KG(vl,vl);
 KLR = KG(vl,vr);
 KRL = KG(vr,vl);
 KRR = KG(vr,vr);
 FL = f(vl,1);
 FR = f(vr,1);
 
 ul = KLL\(FL - KLR*ur);
 R = (KRR*ur) + (KRL*ul) - FR;
 
 u(vl,1) = ul;
 u(vr,1) = ur;
end