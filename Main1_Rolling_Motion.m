clear;
clc;
close all;
%================================
% Need to select and modify TensegrityRobotType as needed in the simulate and mass_change_mar_1 files
% Suggest setting a breakpoint at line 65 to check if the structure is formed.
% The configuration exists in mirror image, when defining the roll axis,
% TR-10 takes 2 below and 4 above the configuration; TR-6 takes 1 below and 5 above the configuration; 
% If it is not formed or there is a mirror phenomenon, it can be rerun.
%================================
% Choose the tensegrity configuration : 1. 10-bar 30-cable Tensegrity Robot(TR-10)；2.6-bar 24-cable Tensegrity Robot(TR-6).
TensegrityRobotType = 1;
% Basic gait of TR-10 : 1.ES-step; 2.SE-step; 3.SS1-step; 4.SS2-step; 5.SS3-step; 6.SS4-step;
% Basic gait of TR-6  :  7.CO-step; 8.OCO-step;
% Combination gait of TR-10 : 11.Combination gait 1; 12.Combination gait 2; 13.Combination gait 3.
BaseGaitType = 1;
%===================================================================
% Setting of various configuration parameters
if TensegrityRobotType == 1 
    model = tensegrity_10_bar;                    % Initialize a tensorgravity class and name it model
    model.lr = 0.525*ones(size(model.rod,1),1);   % Define bar length
    model.lc = 0.15*ones(size(model.cable,1),1);  % Define cable length
    model.ls = 0.15*ones(size(model.string,1),1); % Define string length
    if BaseGaitType == 1                          %1.ES-step
    model.base = [2 4 20 12 17];                  % Define the bottom surface
    model.rollaxis = [2 4];                       % Define the roll axis, the configuration exists in mirror image, take 2 below and 4 above the configuration  
    elseif BaseGaitType == 2                      %2.SE-step
    model.base = [2 4 19 11 15];
    model.rollaxis = [2 4]; 
    elseif BaseGaitType == 3                      %3.SS1-step
    model.base = [2 4 19 11 15];
    model.rollaxis = [2 15]; 
    elseif BaseGaitType == 4                      %4.SS2-step
    model.base = [2 4 19 11 15];
    model.rollaxis = [4 19]; 
    elseif BaseGaitType == 5                      %5.SS3-step
    model.base = [2 4 19 11 15];
    model.rollaxis = [11 19]; 
    elseif BaseGaitType == 6                      %6.SS4-step
    model.base = [2 4 19 11 15];
    model.rollaxis = [11 15]; 
    elseif BaseGaitType > 10                      %11.Combination gait 1; 12.Combination gait 1; 13.Combination gait 1;
    model.base = [2 4 20 12 17]; 
    model.rollaxis = [2 4]; 
    end
end
if TensegrityRobotType == 2
    model = tensegrity_6_bar;
    model.lr = 0.525*ones(size(model.rod,1),1); 
    model.lc = 0.2*ones(size(model.cable,1),1);
    model.ls = 0.2*ones(size(model.string,1),1);
    if BaseGaitType == 7                          %1.CO-step
    model.base = [1 5 9];
    model.rollaxis = [1 5];                       % Define the roll axis, with a mirrored configuration where 1 is located below and 5 is located above 
    elseif BaseGaitType == 8                      %2.OCO-step
    model.base = [1 3 5];
    model.rollaxis = [1 5]; 
    end
end
%===================================================================
model = iniStatic(model);                         % Initialize the tensegrity
figure(1);
plotting_M(model);
view(5,20)
axis on;                                          % Suggest setting a breakpoint here
grid on;
%===================================================================
%Input driven strategies
a = model.lrmin;
b = model.lrmax; 
if TensegrityRobotType == 1
    if BaseGaitType == 1                          %1.ES-step
    stra1=[a a b a a a a a a b;
         a a a a a a a a a a;];  
    elseif BaseGaitType == 2                      %2.SE-step
    stra1=[a a a a b a b b b a;
         a a a a a a a a a a;];  
    elseif BaseGaitType == 3                      %3.SS1-step
    stra1=[a a a b b a b b b a; 
         a a a a a a a a a a;]; 
    elseif BaseGaitType == 4                      %4.SS2-step
    stra1=[a b b a a b b b b b;
         a a a a a a a a a a;]; 
    elseif BaseGaitType == 5                      %5.SS3-step
    stra1=[a b a a a a a a b a;
         a a a a a a a a a a;]; 
    elseif BaseGaitType == 6                      %6.SS4-step
    stra1=[b b a a b b a a a a;
         a a a a a a a a a a;]; 
    elseif BaseGaitType == 11                     %11.Combination gait 1
    stra1=[a a b a a a a a a b;
         a a a a a a a a a a;
         a b b a a b a b b b;
         a a a a a a a a a a;
         a a a b b a b a b b;
         a a a a a a a a a a;];
    elseif BaseGaitType == 12                     %12.Combination gait 2
    stra1=[a a b a a a a a a b;
         a a a a a a a a a a;
         a b a a a a a a b a;
         a a a a a a a a a a;
         a a a a b a b b b 0.8*a;
         a a a a a a a a a a;]; 
    elseif BaseGaitType == 13                     %13.Combination gait 3
    stra1=[a a b a a a a a a b;
         a a a a a a a a a a;
         0.8*a a a b b a b b b a;
         a a a a a a a a a a;
         b b a a b b b a a a;
         a a a a a a a a a a;];
    end
end
%===================================================================
if TensegrityRobotType == 2
    if BaseGaitType == 7                         %7.CO-step
    stra1=[
    a a a b b a;
    a a a a a a;];  
    elseif BaseGaitType == 8                     %8.OCO-step
    stra1=[
    a b b a a a;
    a a a a a a;]; 
    end
end
%===================================================================
stra=[model.lr'; stra1];
model.lr=stra1';

node_num=size(model.x,1);
t_rank = straDiv(stra);
tstra = [t_rank stra];
x_temp = zeros(3*node_num,1);
v_temp = zeros(3*node_num,1);
for i = 1:node_num
    x_temp(3*i-2:3*i) = model.x(i,:)';
end
y0 = [x_temp;v_temp];

if isempty(t_rank)
    tspan = [0 40];
else
    tspan = 0:0.1:t_rank(end)+0.1+1;
end
options = odeset('Mass',@mass_change_bar_1,'MStateDependence','none','MassSingular','no');
clear t;
clear y;
[t,y] = ode15s(@(t,y) tensegrity_ode(t,y,tstra,model),tspan,y0,options);

f_rod = zeros(size(y,1),size(model.rod,1));
f_cable = zeros(size(y,1),size(model.cable,1));
f_string = zeros(size(y,1),size(model.string,1));
len_cable = zeros(size(y,1),size(model.cable,1));
len_string = zeros(size(y,1),size(model.string,1));
fct = zeros(size(y,1),3*node_num);
ff = zeros(size(y,1),3*node_num);
mc = zeros(size(y,1),3);
energy = zeros(size(y,1),1);
v_in = zeros(size(y,1),1);
v_ratio= zeros(size(y,1),1);
m = diag(ones(node_num,1));
posi = zeros(node_num,3,size(y,1));
for time = 1:size(y,1)
    for i = 1:node_num
        posi(i,:,time) = y(time,3*i-2:3*i)';
    end
    model.x=posi(:,:,time);
%     [f_rod(time,:),f_cable(time,:),f_string(time,:),len_cable(time,:),...
%         len_string(time,:),fct(time,:),ff(time,:),mc(time,:),energy(time,:),...
%         v_in(time,:),v_ratio(time,:)] = ...
%         tensegrity_output(t(time),y(time,:)',tstra,model,m);
end
%===================================================
% Output parameters
% figure(11)
% plot(t,y(:,1:60),'-');
% xlabel('x-t');
% figure(22)
% plot(t,y(:,61:end),'-');
% xlabel('v-t');
% figure(33)
% plot(t,f_rod,'-');
% xlabel('Internal force of compression bar');
% figure(44)
% plot(t,f_cable,'-');
% xlabel('Internal force of cable')
% figure(88)
% plot(t,len_cable,'-');
% xlabel('Length of cable')
% figure(89)
% plot(t,f_string,'-');
% xlabel('Internal force of string')
% figure(90)
% plot(t,len_string,'-');
% xlabel('Length of string')
% figure(99)
% plot(t,energy,'-');
% xlabel('Energy variation')
% figure(110)
% plot(t,v_in,'-');
% xlabel('Changes in internal space');
% figure(122)
% plot(t,v_ratio,'-');
% xlabel('Changes in the ratio of internal and external space')
% figure(77);
% plot3(mc(:,1),mc(:,2),mc(:,3));
% xlabel('Centroid trajectory');
%===================================================================
% Robot bottom surface
if TensegrityRobotType == 1
    if BaseGaitType == 1                         %1.ES-step
    Allbase=[2 4 20 12 17;
            2 4 19 11 15;]; 
    elseif BaseGaitType == 2                     %2.SE-step
    Allbase=[2 4 19 11 15;
            2 4 20 12 17;]; 
    elseif BaseGaitType == 3                     %3.SS1-step
    Allbase=[2 4 19 11 15;
            2 15 5 6 17;];
    elseif BaseGaitType == 4                     %4.SS2-step
    Allbase=[2 4 19 11 15;
            4 19 7 8 20;];
    elseif BaseGaitType == 5                     %5.SS3-step
    Allbase=[2 4 19 11 15;
            11 19 7 16 9;];
    elseif BaseGaitType == 6                     %6.SS4-step
    Allbase=[2 4 19 11 15;
            11 15 5 13 9;];
    elseif BaseGaitType == 11                    %11.Combination gait 1
    Allbase=[2 4 20 12 17;
            2 4 19 11 15;
            4 19 7 8 20;
            3 16 7 8 18;];
    elseif BaseGaitType == 12                    %12.Combination gait 2
    Allbase=[2 4 20 12 17;
            2 4 19 11 15;
            16 9 11 19 7;
            1 13 9 16 3;];
    elseif BaseGaitType == 13                    %13.Combination gait 3
    Allbase=[2 4 20 12 17;
            2 4 19 11 15;
            2 15 5 6 17;
            9 13 5 15 11;];
    end
end
%===================================================================
if TensegrityRobotType == 2
    if BaseGaitType == 7                         %7.CO-step
        Allbase=[1 5 9;
                1 3 5;]; 
    elseif BaseGaitType == 8                     %8.OCO-step
        Allbase=[1 3 5;
                1 9 11;]; 
    end
end
%===================================================================

%% Output simulation video
recordmark = 1;
if recordmark
    h = figure(9);
    h.Visible = 'on';
    set(0,'defaultfigurecolor','w')

    if BaseGaitType < 10 
        x=posi(:,:,1);
        base=Allbase(1,:);
        base(base==0)=[];
        triangle_x1 = [x(base(:),1)',x(base(1),1)'];
        triangle_y1 = [x(base(:),2)',x(base(1),2)'];
        triangle_z1 = [x(base(:),3)',x(base(1),3)'];
    
        x=posi(:,:,500);
        base=Allbase(2,:);
        base(base==0)=[];
        triangle_x2 = [x(base(:),1)',x(base(1),1)'];
        triangle_y2 = [x(base(:),2)',x(base(1),2)'];
        triangle_z2 = [x(base(:),3)',x(base(1),3)'];

        for time = 1:size(y,1)
            cla;
            axis equal;
            model.x=posi(:,:,time);
            line(triangle_x1,triangle_y1,triangle_z1,'LineStyle','-.','Color','[1, 0.07843, 0.57647]','LineWidth',2.5);
            hold on
    
            if time>501
                base=Allbase(2,:);
                base(base==0)=[];
                model.base=base;
                line(triangle_x2,triangle_y2,triangle_z2,'LineStyle','-.','Color','[1, 1, 0]','LineWidth',2.5);
                hold on
            end    
            plotting_M2(model);
                xlim([-0.4 0.8]);
                ylim([-0.5 0.6]);
                zlim([0 0.65]);
                view(5,22);
            axis on;
            grid on;
            cdata = print(h,'-RGBImage','-r120');
            frm(time) = im2frame(cdata);
            hold on
        end
            if BaseGaitType == 1 
                v = VideoWriter('ES_step','MPEG-4');
            elseif BaseGaitType == 2
                v = VideoWriter('SE_step','MPEG-4');   
            elseif BaseGaitType == 3
                v = VideoWriter('SS1_step','MPEG-4');
            elseif BaseGaitType == 4
                v = VideoWriter('SS2_step','MPEG-4'); 
            elseif BaseGaitType == 5
                v = VideoWriter('SS3_step','MPEG-4');   
            elseif BaseGaitType == 6
                v = VideoWriter('SS4_step','MPEG-4');
            elseif BaseGaitType == 7
                v = VideoWriter('CO_step','MPEG-4');   
            elseif BaseGaitType == 8
                v = VideoWriter('OCO_step','MPEG-4');
            end 
            v.FrameRate = 40;
            open(v);
            writeVideo(v,frm);
            close(v);
    end

    if BaseGaitType > 10
        x=posi(:,:,1);
        base=Allbase(1,:);
        base(base==0)=[];
        triangle_x1 = [x(base(:),1)',x(base(1),1)'];
        triangle_y1 = [x(base(:),2)',x(base(1),2)'];
        triangle_z1 = [x(base(:),3)',x(base(1),3)'];
    
        x=posi(:,:,500);
        base=Allbase(2,:);
        base(base==0)=[];
        triangle_x2 = [x(base(:),1)',x(base(1),1)'];
        triangle_y2 = [x(base(:),2)',x(base(1),2)'];
        triangle_z2 = [x(base(:),3)',x(base(1),3)'];

        x=posi(:,:,1000);
        base=Allbase(3,:);
        base(base==0)=[];
        triangle_x3 = [x(base(:),1)',x(base(1),1)'];
        triangle_y3 = [x(base(:),2)',x(base(1),2)'];
        triangle_z3 = [x(base(:),3)',x(base(1),3)'];
    
        x=posi(:,:,1500);
        base=Allbase(4,:);
        base(base==0)=[];
        triangle_x4 = [x(base(:),1)',x(base(1),1)'];
        triangle_y4 = [x(base(:),2)',x(base(1),2)'];
        triangle_z4 = [x(base(:),3)',x(base(1),3)'];

        for time = 1:size(y,1)
            cla;
            axis equal;
            model.x=posi(:,:,time);
            line(triangle_x1,triangle_y1,triangle_z1,'LineStyle','-.','Color','[1, 0.07843, 0.57647]','LineWidth',2.5);
            hold on
    
            if time>501
                base=Allbase(2,:);
                base(base==0)=[];
                model.base=base;
                line(triangle_x2,triangle_y2,triangle_z2,'LineStyle','-.','Color','[1, 1, 0]','LineWidth',2.5);
                hold on
            end
            if time>1002
                base=Allbase(3,:);
                base(base==0)=[];
                model.base=base;
                line(triangle_x3,triangle_y3,triangle_z3,'LineStyle','-.','Color','[1, 0.64706, 0]','LineWidth',2.5);
                hold on
            end
    
            if time>1503
                base=Allbase(4,:);
                base(base==0)=[];
                model.base=base;
                line(triangle_x4,triangle_y4,triangle_z4,'LineStyle','-.','Color','[0.25098, 0.87843, 0.81569]','LineWidth',2.5);
                hold on
            end
    
            plotting_M2(model);
            if  BaseGaitType == 11
                xlim([-0.4 0.8]);
                ylim([-0.4 1.2]);
                zlim([0 0.65]);
                view(0,90);    
            elseif BaseGaitType == 12
                xlim([-0.4 1.4]);
                ylim([-0.35 0.7]);
                zlim([0 0.65]); 
                view(0,90);
            elseif BaseGaitType == 13
                xlim([-0.4 1]);
                ylim([-0.85 0.35]);
                zlim([0 0.65]);
                view(0,90); 
            end 
            cdata = print(h,'-RGBImage','-r120');
            frm(time) = im2frame(cdata);
            hold on
        end
        if BaseGaitType == 11
            v = VideoWriter('Combination_gait_1','MPEG-4');   
        elseif BaseGaitType == 12
            v = VideoWriter('Combination_gait_2','MPEG-4');
        elseif BaseGaitType == 13
            v = VideoWriter('Combination_gait_3','MPEG-4'); 
        end 
        v.FrameRate = 40;
        open(v);
        writeVideo(v,frm);
        close(v);
    end
end

