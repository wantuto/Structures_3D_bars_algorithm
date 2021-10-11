function plotDisp3D(x,T,u)
% PLOTDISP function to plot deformed bar structure and displacements
% Inputs:
%   x   Nodal coordinates matrix (Ndim x Nnodes)
%   T   Connectivities matrix (NnodesXelement x Nelements)
%   u   Global displacements vector (Ndofs x 1)

% Dimensions
Ndim = size(x,1);
Nnodes = size(x,2);

% Reshape matrices for plot
U = reshape(u,Ndim,Nnodes);
X = @(fact) reshape(x(1,T)+fact*U(1,T),size(T));
Y = @(fact) reshape(x(2,T)+fact*U(2,T),size(T)); 
Z = @(fact) reshape(x(3,T)+fact*U(3,T),size(T));
D = reshape(sqrt(sum(U(:,T).^2,1)),size(T))*1e3;

% Open and initialize figure
figure('color','w');
hold on;       % Allow multiple plots on same axes
%box on;        % Closed box axes
axis equal;    % Keep aspect ratio to 1
colormap jet;  % Set colormap colors
set(gca,'xtick',[],'ytick',[],'ztick',[],'units','pixels'); % Take out ticks from axes
set(gca,'xcolor','none','ycolor','none','zcolor','none'); % Take out axes
view(37,23);

% Plot undeformed structure
plot3(X(0),Y(0),Z(0),'color',[0.5,0.5,0.5],'linewidth',2);

% Plot deformed structure with displacement magnitude coloring
p = patch(X(1),Y(1),Z(1),D,'edgecolor','interp','linewidth',2);

% Set colorbar properties
caxis([min(D(:)),max(D(:))]); % Colorbar limits
cbar = colorbar;              % Create colorbar
set(cbar,'Ticks',linspace(min(D(:)),max(D(:)),5))

% Set title
title('Displacement (mm)');

% Plot axes
x_lim = get(gca,'xlim');
y_lim = get(gca,'ylim');
z_lim = get(gca,'zlim');
plot3(x_lim,[y_lim(1),y_lim(1)],[z_lim(1),z_lim(1)],'r'); text(x_lim(2),y_lim(1),z_lim(1),'X','color','r')
plot3([x_lim(1),x_lim(1)],y_lim,[z_lim(1),z_lim(1)],'g'); text(x_lim(1),y_lim(2),z_lim(1),'Y','color','g')
plot3([x_lim(1),x_lim(1)],[y_lim(1),y_lim(1)],z_lim,'b'); text(x_lim(1),y_lim(1),z_lim(2),'Z','color','b')

% Add slider to control displacements factor
xlabel(sprintf('scale %.0f%%',100));
slid = uicontrol(gcf,'style','slider','min',-1,'max',3,'value',0,'callback',@scale);
pos = get(slid,'position');
pax = get(gca,'position');
set(slid,'position',[pax(1)+pax(3)*0.2,pos(2),pax(3)*0.6,pos(4)]);
function scale(source,event) % Function to control slider behaviour
    factor = 10^get(source,'value');
    set(p,'xdata',X(factor),'ydata',Y(factor),'zdata',Z(factor)); % Re-plot to adjust factor
    xlabel(sprintf('scale %.0f%%',100*factor));
    drawnow;
end

% Add pushbutton for fast export of the figure to a .png file
uicontrol(gcf,'style','pushbutton','string','Export plot','callback',@exportfig);
function exportfig(source,event) % Function to export figure to '.png' file
    print(gcf,[pwd,filesep,sprintf('figure%i',get(gcf,'number'))],'-dpng','-r300','-noui');
end

end