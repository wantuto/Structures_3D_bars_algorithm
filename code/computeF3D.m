function f = computeF3D(dim,Fext,m_nod,g_esc)
%--------------------------------------------------------------------------
% The function takes as inputs:
%   - Dimensions:  n_i         Number of DOFs per node
%                  n_dof       Total number of DOFs
%   - Fext  External nodal forces [Nforces x 3]
%            Fext(k,1) - Node at which the force is applied
%            Fext(k,2) - DOF (direction) at which the force acts
%            Fext(k,3) - Force magnitude in the corresponding DOF
%--------------------------------------------------------------------------
% It must provide as output:
%   - f     Global force vector [n_dof x 1]
%            f(I) - Total external force acting on DOF I
%--------------------------------------------------------------------------
% Hint: Use the relation between the DOFs numbering and nodal numbering to
% determine at which DOF in the global system each force is applied.

f = zeros(dim.n_dof,1);

for i = 1:dim.n
    
    f(3*i,1) = f(3*i,1) + m_nod(i,1)*g_esc;
       
end

for j = 1:size(Fext,1)
    
    f(3*Fext(j,1),1) = f(3*Fext(j,1),1) + Fext(j,3);
    
end
end