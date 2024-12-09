function plotting_M2(model)

x=model.x;
base=model.base;
base(base==0)=[];
rollaxis=model.rollaxis;
rod=model.rod;
cable=model.cable;
string=model.string;

X_rod = zeros(size(rod,1),2); 
Y_rod = zeros(size(rod,1),2);
Z_rod = zeros(size(rod,1),2);
for i = 1:size(rod,1)
    try 
        for j = 1:2
            X_rod(i,j) = x(rod(i,j),1);
            Y_rod(i,j) = x(rod(i,j),2);
            Z_rod(i,j) = x(rod(i,j),3);
        end
    catch
        keyboard
    end
end
X_cable = zeros(size(cable,1),2);
Y_cable = zeros(size(cable,1),2);
Z_cable = zeros(size(cable,1),2);
for i = 1:size(cable,1)
    for j = 1:2
        X_cable(i,j) = x(cable(i,j),1);
        Y_cable(i,j) = x(cable(i,j),2);
        Z_cable(i,j) = x(cable(i,j),3);
    end
end 
X_string = zeros(size(string,1),2);
Y_string = zeros(size(string,1),2);
Z_string = zeros(size(string,1),2);
for i = 1:size(string,1)
    for j = 1:2
        X_string(i,j) = x(string(i,j),1);
        Y_string(i,j) = x(string(i,j),2);
        Z_string(i,j) = x(string(i,j),3);
    end
end 
axis equal 
hold on
line(X_rod',Y_rod',Z_rod','Color','red','LineWidth',2.5);
line(X_cable',Y_cable',Z_cable','Color','blue','LineWidth',1.5);
line(X_string',Y_string',Z_string','Color','black','LineWidth',1);
scatter3(x(size(x,1),1),x(size(x,1),2),x(size(x,1),3),1250,[0, 0, 0],"filled");

for i = 1:size(x,1)-1
%     nodemark = num2str(i);
%     nodemark = strcat('$$\',32,nodemark,'$$');
%     te = text(x(i,1),x(i,2),x(i,3),nodemark,"FontSize",18,'Interpreter','latex');
%     uistack(te,'top');
    scatter3(x(i,1),x(i,2),x(i,3),50,"red","filled");
end

% if rollaxis~=[0,0]
%     ROTLX = [x(rollaxis(1),1),x(rollaxis(2),1)];
%     ROTLY = [x(rollaxis(1),2),x(rollaxis(2),2)];
%     ROTLZ = [x(rollaxis(1),3),x(rollaxis(2),3)];
%     line(ROTLX,ROTLY,ROTLZ,'LineStyle','-.','Color','blue','LineWidth',2.5);
% end
%==========================================================
% base=[
% 1 5 9;
% 1 3 5;
%
% 2 4 19 11 15;
% 2 4 20 12 17; %2-4
% 2 15 5 6 17;  %2-15
% 4 19 7 8 20;  %4-19
% 11 19 7 16 9;  %11-19
% 9 11 15 5 13;  %11-15
%     ];
% 
% triangle_x = [x(base(:),1)', x(base(1),1)];
% triangle_y = [x(base(:),2)', x(base(1),2)];
% triangle_z = [x(base(:),3)', x(base(1),3)];
% 
% hold on
% fill3(triangle_x,triangle_y,triangle_z,[0.59608, 0.98431, 0.59608],'FaceAlpha','0.6','EdgeAlpha','0'); % Fill the bottom surface
% %[1, 1, 0]-yellow ; [0.80392, 0.36078, 0.36078]-Light Red；[0.59608, 0.98431, 0.59608]-Light green;
% %[1, 0.07843, 0.57647]-Pink；[1, 0.64706, 0]-Orange；[0.25098, 0.87843, 0.81569]-Light Blue；
% % line(triangle_x,triangle_y,triangle_z,'LineStyle','-.','Color','m','LineWidth',2.5);
%=====================================================================

xlabel('$$X(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
ylabel('$$Y(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
zlabel('$$Z(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
end

