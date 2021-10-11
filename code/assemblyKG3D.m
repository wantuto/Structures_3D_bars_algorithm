function KG = assemblyKG3D(dim,Td,Kel)
%--------------------------------------------------------------------------
% The function takes as inputs:
%   - Dimensions:  n_el       Total number of elements
%                  n_el_dof   Number of DOFs per element
%                  n_dof      Total number of DOFs
%   - Td    DOFs connectivities table [n_el x n_el_dof]
%            Td(e,i) - DOF i associated to element e
%   - Kel   Elemental stiffness matrices [n_el_dof x n_el_dof x n_el]
%            Kel(i,j,e) - Term in (i,j) position of stiffness matrix for element e
%--------------------------------------------------------------------------
% It must provide as output:
%   - KG    Global stiffness matrix [n_dof x n_dof]
%            KG(I,J) - Term in (I,J) position of global stiffness matrix
%--------------------------------------------------------------------------
KG = zeros(dim.n_dof,dim.n_dof);

for e = 1:dim.n_el
    for i = 1:dim.n_ne*dim.n_i
        I = Td(e,i);
        
        for j = 1:dim.n_ne*dim.n_i
            J = Td(e,j);
            KG(I,J) = KG(I,J) + Kel(i,j,e);
        end
    end
end
end