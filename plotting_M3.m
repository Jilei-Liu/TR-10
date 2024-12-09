function plotting_M2(model)

x=model.x;
base=model.base;
base(base==0)=[];

% rollaxis=model.rollaxis;
% rod=model.rod;
% cable=model.cable;

% X_rod = zeros(size(rod,1),2); 
% Y_rod = zeros(size(rod,1),2);
% Z_rod = zeros(size(rod,1),2);
% for i = 1:size(rod,1)
%     try
%         for j = 1:2
%             X_rod(i,j) = x(rod(i,j),1);
%             Y_rod(i,j) = x(rod(i,j),2);
%             Z_rod(i,j) = x(rod(i,j),3);
%         end
%     catch
%         keyboard
%     end
% end 
% X_cable = zeros(size(cable,1),2);
% Y_cable = zeros(size(cable,1),2);
% Z_cable = zeros(size(cable,1),2);
% for i = 1:size(cable,1)
%     for j = 1:2
%         X_cable(i,j) = x(cable(i,j),1);
%         Y_cable(i,j) = x(cable(i,j),2);
%         Z_cable(i,j) = x(cable(i,j),3);
%     end
% end 
% axis equal
% hold on
% line(X_rod',Y_rod',Z_rod','Color','red','LineWidth',2.2); 
% line(X_cable',Y_cable',Z_cable','Color','blue','LineWidth',1); 
% 
% for i = 1:size(x,1)
%     nodemark = num2str(i);
%     nodemark = strcat('$$\',32,nodemark,'$$');
%     te = text(x(i,1),x(i,2),x(i,3),nodemark,"FontSize",18,'Interpreter','latex');
%     uistack(te,'top');
%     scatter3(x(i,1),x(i,2),x(i,3),50,"red","filled");
% end

% if rollaxis~=[0,0]
%     ROTLX = [x(rollaxis(1),1),x(rollaxis(2),1)];
%     ROTLY = [x(rollaxis(1),2),x(rollaxis(2),2)];
%     ROTLZ = [x(rollaxis(1),3),x(rollaxis(2),3)];
%     line(ROTLX,ROTLY,ROTLZ,'LineStyle','-.','Color','blue','LineWidth',1.25); 
% end

% [~,mc,~] = masscenter(model); 
% hold on
% text(mc(1),mc(2),mc(3),'$$\ CoM$$',"FontSize",15,"FontName",'Times New Roman',...
%     'FontAngle','italic','Interpreter','latex');
% scatter3(mc(1),mc(2),mc(3),100,'blue','filled','d');
%

triangle_x = [x(base(:),1)', x(base(1),1)];
triangle_y = [x(base(:),2)', x(base(1),2)];
triangle_z = [x(base(:),3)', x(base(1),3)];

hold on
fill3(triangle_x,triangle_y,triangle_z,'g','FaceAlpha','0.6','EdgeAlpha','0'); 
line(triangle_x,triangle_y,triangle_z,'LineStyle','-.','Color','m','LineWidth',1); 

xlabel('$$X(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
ylabel('$$Y(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
zlabel('$$Z(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
end