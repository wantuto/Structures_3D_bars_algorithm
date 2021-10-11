function [Td] = connectDOFs3D(dim,Tn)
%--------------------------------------------------------------------------
% The function takes as inputs:
%   - Dimensions:  n_el     Total number of elements
%                  n_nod    Number of nodes per element
%                  n_i      Number of DOFs per node
%   - Tn    Nodal connectivities table [n_el x n_nod]
%            Tn(e,a) - Nodal number associated to node a of element e
%--------------------------------------------------------------------------
% It must provide as output:
%   - Td    DOFs connectivities table [n_el x n_el_dof]
%            Td(e,i) - DOF i associated to element e
%--------------------------------------------------------------------------
% Hint: Use the relation between the DOFs numbering and nodal numbering.


for e = 1:dim.n_el
    for i = 1:dim.n_ne
        for j = 1:dim.n_i
            
            I = dim.n_i*(i-1) + j;
            Td(e,I) = dim.n_i*(Tn(e,i)-1) + j;
            
        end
    end
end
end