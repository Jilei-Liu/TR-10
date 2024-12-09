function plotting_M(model)

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
scatter3(x(size(x,1),1),x(size(x,1),2),x(size(x,1),3),1250,"black","filled"); 

for i = 1:size(x,1)-1
    nodemark = num2str(i);
    nodemark = strcat('$$\',32,nodemark,'$$');
    te = text(x(i,1),x(i,2),x(i,3),nodemark,"FontSize",18,'Interpreter','latex');
    uistack(te,'top');
    scatter3(x(i,1),x(i,2),x(i,3),50,"red","filled");
end 

triangle_x = [x(base(:),1)', x(base(1),1)];
triangle_y = [x(base(:),2)', x(base(1),2)];
triangle_z = [x(base(:),3)', x(base(1),3)];

hold on

xlabel('$$X(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
ylabel('$$Y(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
zlabel('$$Z(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
end