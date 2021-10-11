function postprocess(x,T,u,sig,sig_max,sig_min,scoef_c,scoef_b,time)
% POSTPROCESS function for TASK 2
% Inputs:
%   x       Nodal coordinates matrix (Ndim x Nnodes)
%   T       Connectivities matrix (NnodesXelement x Nelements)
%   u       Global displacements vector (Ndofs x 1)
%   sig     Elemental stress vector (Nelements x 1)

% Plot deformed structure
plotDisp3D(x,T,u);

% Plot stress
plotStress3D(x,T,sig);

% Plot max and min stress evolution
figure('color','w')
box on; 
hold on;
grid on;
plot(time,sig_max/1e6,'r','linewidth',1.5);
plot(time,sig_min/1e6,'b','linewidth',1.5);
xlabel('Time (s)');
ylabel('Stress (MPa)');
legend('Max. stress','Min. stress','location','northoutside','orientation','horizontal');

% Plot max and min stress evolution
figure('color','w')
box on;
hold on;
grid on;
plot(time,scoef_c,'r','linewidth',1.5);
plot(time,scoef_b,'b','linewidth',1.5);
set(gca,'yscale','log');
xlabel('Time (s)');
ylabel('Safety factor');
legend('Safety factor','Safety factor (buckling)','location','northoutside','orientation','horizontal');


end