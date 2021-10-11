%-------------------------------------------------------------------------%
% ASSIGNMENT 02
%-------------------------------------------------------------------------%
% Date:
% Author/s:
%

clear;
close all;

%% INPUT DATA 

%Cables
E1 = 210e9;%Compute the correct value
A1 = 1;%Compute the correct value
rho1 = 1550;%Compute the correct value
Sig_y1 = 180e6;%Compute the correct value
I1 = 1; %Compute the correct value

%Bars
E2 = 70e9;%Compute the correct value
A2 = 1;%Compute the correct value
rho2 = 2700;%Compute the correct value
Sig_y2 = 270e6;%Compute the correct value
I2 = 1; %Compute the correct value

% Problem data
g = [0,0,-9.81]; % m/s2 
g_esc = g(3);
M = 125;         % kg
rho_a = 1.225;   % kg/m3
Cd = 1.75;
V = [0,0,0];     % m/s
dVdt = g;        % m/s2

% time discretization
dt = 1; % Modify the value
t_end = 1; % Modify the value
time = 0:dt:t_end;

% Stresses for safetyparameters
sig_max = zeros(1,length(time));
sig_min = zeros(1,length(time));
scoef_c = zeros(1,length(time));
scoef_b = zeros(1,length(time));

%% PREPROCESS

% Nodal displacement matrix, Connectivities matrix and Material connectivities are loaded from input_data_02.m
%     x(a,j) = coordinate of node a in the dimension j
%     Tn(e,a) = global nodal number associated to node a of element e
%     Tmat(e) = Row in mat corresponding to the material associated to element e 

input_data_02;

% Fix nodes matrix creation
%  fixNod(k,1) = node at which some DOF is prescribed
%  fixNod(k,2) = DOF prescribed (1,2,3)
%  fixNod(k,3) = prescribed displacement in the corresponding DOF (0 for fixed)
fixNod = [% Node        DOF  Magnitude
          % Write the data here...
];

% Material data
%  mat(m,1) = Young modulus of material m
%  mat(m,2) = Section area of material m 
%  mat(m,3) = density of material m
%  mat(m,4) = second area moment of material m 
%  mat(m,5) = yield strength of material m 
%  --more columns can be added for additional material properties--
mat = [% Young M.   Section A.   Density    A. Moment    Yield S.
           E1,           A1,      rho1,        I1        Sig_y1;  % Material (1)
		   E2,           A2,      rho2,        I2        Sig_y2   % Material (2)
];


%% SOLVER

% Dimensions
dim.n_d = size(x,2);              % Number of dimensions
dim.n_i = dim.n_d;                    % Number of DOFs for each node
dim.n = size(x,1);                % Total number of nodes
dim.n_dof = dim.n_i*n;                % Total number of degrees of freedom
dim.n_el = size(Tn,1);            % Total number of elements
dim.n_nod = size(Tn,2);           % Number of nodes for each element
dim.n_el_dof = dim.n_i*dim.n_nod;         % Number of DOFs for each element 

% Computation of the DOFs connectivities
Td = connectDOFs3D(dim,Tn);

% Computation of element stiffness matrices
Kel = computeKelBar3D(dim,x,Tn,mat,Tmat);

% Global matrix assembly
KG = assemblyKG3D(dim,Td,Kel);

% Compute nodal mass
[m_nod,tmass,Ms,total_m] = computeMass3D(x,Tn,mat,Tmat,M,rho_s,S,t_s,dim);

for t = 1:length(time)

    % Update Velocity
    V = 1; % Modify the expression

    % Compute drag
    D = 1; % Modify the expression

    % External force matrix creation
    %  Fext(k,1) = node at which the force is applied
    %  Fext(k,2) = DOF (direction) at which the force is applied (1,2,3)
    %  Fext(k,3) = force magnitude in the corresponding DOF
    Fext = [%   Node        DOF  Magnitude   
                % Write the data here...
    ];

    % Global force vector assembly
    f = computeF3D(dim,Fext,m_nod,g_esc);

    % System resolution
    [ur,vr,vl,u,R] = solveSys3D(dim,fixNod,KG,f);

    % Compute strain and stresses
    [eps,sig] = computeStrainStressBar3D(dim,u,Td,x,Tn,mat,Tmat);
    
    % Update acceleration
    dVdt = 1; % Modify the expression

    % Store maximum and minimum stress and safety coefficients
    [sig_max(t),sig_min(t),scoef_c(t),scoef_b(t)] = computeSafetyParameters3D(x,dim,Tn,Tmat,mat,sig);

end

%% POSTPROCESS

postprocess(x',Tn',u,sig,sig_max,sig_min,scoef_c,scoef_b,time);