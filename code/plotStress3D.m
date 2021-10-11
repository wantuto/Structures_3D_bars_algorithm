function plotStress3D(x,T,sig)
% PLOTSTRESS function to plot stress for each bar in the structure
% Inputs:
%   x     Nodal coordinates matrix (Ndim x Nnodes)
%   T     Connectivities matrix (NnodesXelement x Nelements)
%   sig     Elemental stress vector (Nelements x 1)

% Dimensions
Ndim = size(x,1);
Nnodes = size(x,2);

% Reshape matrices for plot
x0 = reshape(x(1,T),size(T));
y0 = reshape(x(2,T),size(T));
z0 = reshape(x(3,T),size(T)); 
S = repmat(sig',size(T,1),1)/1e6;

% Open and initialize figure
figure('color','w');
hold on;       % Allow multiple plots on same axes
%box on;        % Closed box axes
axis equal;    % Keep aspect ratio to 1
colormap jet;  % Set colormap colors
set(gca,'xtick',[],'ytick',[],'ztick',[],'units','pixels'); % Take out ticks from axes
set(gca,'xcolor','none','ycolor','none','zcolor','none'); % Take axes
view(37,23);

% Plot structure with stress magnitude coloring
patch(x0,y0,z0,S,'edgecolor','flat','linewidth',2);

% Set colorbar properties
caxis([min(S(:)),max(S(:))]);
cbar = colorbar;
set(cbar,'Ticks',linspace(min(S(:)),max(S(:)),5))

% Plot axes
x_lim = get(gca,'xlim');
y_lim = get(gca,'ylim');
z_lim = get(gca,'zlim');
plot3(x_lim,[y_lim(1),y_lim(1)],[z_lim(1),z_lim(1)],'r'); text(x_lim(2),y_lim(1),z_lim(1),'X','color','r')
plot3([x_lim(1),x_lim(1)],y_lim,[z_lim(1),z_lim(1)],'g'); text(x_lim(1),y_lim(2),z_lim(1),'Y','color','g')
plot3([x_lim(1),x_lim(1)],[y_lim(1),y_lim(1)],z_lim,'b'); text(x_lim(1),y_lim(1),z_lim(2),'Z','color','b')

% Set title
title('Stress (MPa)');

% Add pushbutton for fast export of the figure to a .png file
uicontrol(gcf,'style','pushbutton','string','Export plot','callback',@exportfig);
function exportfig(source,event) % Function to export figure to '.png' file
    print(gcf,[pwd,filesep,sprintf('figure%i',get(gcf,'number'))],'-dpng','-r300','-noui');
end

end