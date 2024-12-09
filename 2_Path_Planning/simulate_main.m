clear;
clc;
close all;
%================================
% Need to select and modify TensegrityRobotType as needed in the simulate and mass_change_mar files
% Suggest setting a breakpoint at line 40 to check if the structure is formed.
% The configuration exists in mirror image, when defining the roll axis,
% TR-10 takes 2 below and 4 above the configuration; TR-6 takes 1 below and 5 above the configuration; 
% If it is not formed or there is a mirror phenomenon, it can be rerun.
%================================
% Choose the tensegrity configuration : 1. 10-bar 30-cable Tensegrity Robot(TR-10)；2.6-bar 24-cable Tensegrity Robot(TR-6).
TensegrityRobotType = 1;
%Select path type: 1.Straight; 3.Triangle; 4.Quadrilateral; 5.Pentagon; 6.Hexagon.
PathType = 1;
%===================================================================
% Setting of various configuration parameters
if TensegrityRobotType == 1
    model = tensegrity_10_bar;                    % Initialize a tensorgravity class and name it model
    model.lr = 0.525*ones(size(model.rod,1),1);   % Define bar length
    model.lc = 0.15*ones(size(model.cable,1),1);  % Define cable length
    model.ls = 0.15*ones(size(model.string,1),1); % Define string length
    model.base = [2 4 20 12 17];                  % Define the bottom surface
    model.rollaxis = [2 4];                       % Define the roll axis, the configuration exists in mirror image, take 2 below and 4 above the configuration
    model.basestate = 1;                          % Define the type of bottom surface
end
if TensegrityRobotType == 2
    model = tensegrity_6_bar;
    model.lr = 0.525*ones(size(model.rod,1),1);
    model.lc = 0.3*ones(size(model.cable,1),1);
    model.ls = 0.3*ones(size(model.string,1),1);
    model.base = [1 5 9];
    model.rollaxis = [1 5];                       % Define the roll axis, with a mirrored configuration where 1 is located below and 5 is located above
    model.basestate = 1;
end
%===================================================================
model = iniStatic(model);                         % Initialize the tensegrity
figure(2);
plotting_M(model);
view(5,20)
axis on;                                          % Suggest setting a breakpoint here
grid on;
figure(1);
 if PathType == 1                                 %1.Straight
    Alltarget=[0 0 0;
               2 0 0;];
 elseif PathType == 3                             %3.Triangle
    Alltarget=[0 0 0;
            1.5 0 0;
            1.5*cosd(60) 1.5*sind(60) 0;
            0 0 0;];
 elseif PathType == 4                             %4.Quadrilateral
    Alltarget=[0 0 0; 
            1.5 0 0;
            1.5 1.5 0;
            0 1.5 0;
            0 0 0;];
 elseif PathType == 5                             %5.Pentagon
    Alltarget=[0 0 0; 
            1.5 0 0;
            1.5*(1+cosd(72)) 1.5*sind(72) 0;
            1.5/2 1.5*(cosd(54)+sind(72)) 0;
            -1.5*cosd(72) 1.5*sind(72) 0;
            0 0 0;];
 elseif PathType == 6                             %6.Hexagon
    Alltarget=[0 0 0;  
            1.5 0 0;
            1.5*(1+cosd(60)) 1.5*sind(60) 0;
            1.5 3*sind(60) 0;
            0 3*sind(60) 0;
            -1.5*cosd(60) 1.5*sind(60) 0;
            0 0 0;];
 end

xlabel('$$X(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
ylabel('$$Y(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
zlabel('$$Z(m)$$',"FontSize",12,"Interpreter","latex","FontSmoothing","on","FontWeight","normal");
axis equal

scatter3(Alltarget(:,1),Alltarget(:,2),Alltarget(:,3),100,'red','filled','p');
line(Alltarget(:,1),Alltarget(:,2),Alltarget(:,3),'LineStyle','-','Color','g','LineWidth',1.5);
target=Alltarget(1,:);
model = Finding_RollAxis(target,model);
plotting_M2(model);
axis equal;

Allstra=[];
Allbasestate=[model.basestate];
Allbase=[model.base];
%========================================================
%TR-10
if TensegrityRobotType == 1
    Allbasecoor=[model.x(model.base(1),:),model.x(model.base(2),:),...
            model.x(model.base(3),:),model.x(model.base(4),:),...
            model.x(model.base(5),:)];
end
%TR-6
if TensegrityRobotType == 2
    Allbasecoor=[model.x(model.base(1),:),model.x(model.base(2),:),...
            model.x(model.base(3),:)];
end
%========================================================
Allx=[];
Allf_rod = [];
Allf_cable = [];
Alllen_cable = [];
Allf_string = [];
Alllen_string = [];
Allfct = [];
Allff = [];
Allmc = [];
Allenergy = [];
Allv_in = [];
Allv_out = [];
Allv_ratio = [];
Allt=0;

max_f_rod=0;
max_len_cable=0;
max_len_string=0;

target_num=1;
while target_num<size(Alltarget,1)+1
    target=Alltarget(target_num,:);
    model = Finding_RollAxis(target,model);
    while (model.rollaxis~=[0 0])
        if isempty(model.base)
            stra1=0.525*ones(1,node_num/2); 
        else
            stra1=Finding_stra(model); 
        end
        Allstra=[Allstra;stra1];
        stra=[model.lr'; stra1];
        model.lr=stra1';

        node_num=size(model.x,1);
        t_rank = straDiv(stra);

        global tstra;
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
        options = odeset('Mass',@mass_change_bar,'MStateDependence','none','MassSingular','no');
        clear t;
        clear y;
        [t,y] = ode15s(@(t,y) tensegrity_ode(t,y,tstra,model),tspan,y0,options);

        f_rod = zeros(size(y,1),size(model.rod,1));
        f_cable = zeros(size(y,1),size(model.cable,1));
        len_cable = zeros(size(y,1),size(model.cable,1));
        f_string = zeros(size(y,1),size(model.string,1));
        len_string = zeros(size(y,1),size(model.string,1));
        fct = zeros(size(y,1),3*node_num);
        ff = zeros(size(y,1),3*node_num);
        mc = zeros(size(y,1),3);
        m = diag(ones(node_num,1));
        energy = zeros(size(y,1),1);
        v_in = zeros(size(y,1),1);
        v_out = zeros(size(y,1),1);
        v_ratio= zeros(size(y,1),1);
        posi = zeros(node_num,3,size(y,1));
        for time = 1:size(y,1)
            for i = 1:node_num
                posi(i,:,time) = y(time,3*i-2:3*i)';
            end
            model.x=posi(:,:,time);
            [f_rod(time,:),f_cable(time,:),f_string(time,:),len_cable(time,:),...
                len_string(time,:),fct(time,:),ff(time,:),mc(time,:),...
                energy(time,:),v_in(time,:),v_ratio(time,:)] = ...
                tensegrity_output(t(time),y(time,:)',tstra,model,m);
        end
        figure(1);
        plot(mc(:,1),mc(:,2),LineWidth=1.5,Color='b');
        axis equal;
        view(0,90);
        hold on
         
        for i=1:node_num
            model.x(i,:)=y( size(y,1) , 3*i-2:3*i )';
        end

        model.base=baseteller( fct(size(y,1),:) );
        model = Confirm_Base(model);

        Allx=[Allx;y(:,1:size(y,2)/2)];
        Allbasestate=[Allbasestate;model.basestate];
        Allbase=[Allbase;model.base];
        %========================================================
        %TR-10
        if TensegrityRobotType == 1
            Allbasecoor=[model.x(model.base(1),:),model.x(model.base(2),:),...
                    model.x(model.base(3),:),model.x(model.base(4),:),...
                    model.x(model.base(5),:)];
        end
        %TR-6
        if TensegrityRobotType == 2
            Allbasecoor=[model.x(model.base(1),:),model.x(model.base(2),:),...
                    model.x(model.base(3),:)];
        end
        %========================================================
        Allf_rod = [Allf_rod; f_rod];
        Allf_cable = [Allf_cable; f_cable];
        Alllen_cable = [Alllen_cable; len_cable];
        Allf_string = [Allf_string; f_string];
        Alllen_string = [Alllen_string; len_string];
        Allfct = [Allfct; fct];
        Allff = [Allff; ff];
        Allmc = [Allmc; mc];
        Allenergy = [Allenergy; energy];
        Allv_in = [Allv_in; v_in];
        Allv_out = [Allv_out; v_out];
        Allv_ratio = [Allv_ratio; v_ratio];
        Allt=Allt+size(t,1)/10;
%====================================================
% Is it reset after rolling
IsReset = 1;                                   % Should each basic gait be reset after rolling? Yes 1, No 0
    if (IsReset)
        stra1=0.525*ones(1,(node_num-1)/2);
        Allstra=[Allstra;stra1]; 
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
        options = odeset('Mass',@mass_change_bar,'MStateDependence','none','MassSingular','no');
        clear t;
        clear y;
        [t,y] = ode15s(@(t,y) tensegrity_ode(t,y,tstra,model),tspan,y0,options);

       for time = 1:size(y,1)
            for i = 1:node_num
                posi(i,:,time) = y(time,3*i-2:3*i)';
            end
            model.x=posi(:,:,time);
            [f_rod(time,:),f_cable(time,:),f_string(time,:),len_cable(time,:),...
                len_string(time,:),fct(time,:),ff(time,:),mc(time,:),...
                energy(time,:),v_in(time,:),v_ratio(time,:)] = ...
                tensegrity_output(t(time),y(time,:)',tstra,model,m);
       end

        figure(1);
        plot(mc(:,1),mc(:,2),LineWidth=1.5,Color='b');
        axis equal;
        view(0,90);
        hold on

        for i=1:node_num
            model.x(i,:)=y( size(y,1) , 3*i-2:3*i )';
        end

        model.base=baseteller( fct(size(y,1),:) );
        model = Confirm_Base(model);
        model = Finding_RollAxis(target,model);

        Allx=[Allx;y(:,1:size(y,2)/2)];
        Allbasestate=[Allbasestate;model.basestate];
        Allbase=[Allbase;model.base];
        %========================================================
        %TR-10
        if TensegrityRobotType == 1
            Allbasecoor=[model.x(model.base(1),:),model.x(model.base(2),:),...
                    model.x(model.base(3),:),model.x(model.base(4),:),...
                    model.x(model.base(5),:)];
        end
        %TR-6
        if TensegrityRobotType == 2
            Allbasecoor=[model.x(model.base(1),:),model.x(model.base(2),:),...
                    model.x(model.base(3),:)];
        end
        %========================================================
        Allf_rod = [Allf_rod; f_rod];
        Allf_cable = [Allf_cable; f_cable];
        Alllen_cable = [Alllen_cable; len_cable];
        Allf_string = [Allf_string; f_string];
        Alllen_string = [Alllen_string; len_string];
        Allfct = [Allfct; fct];
        Allff = [Allff; ff];
        Allmc = [Allmc; mc];
        Allenergy = [Allenergy; energy];
        Allv_in = [Allv_in; v_in];
        Allv_out = [Allv_out; v_out];
        Allv_ratio = [Allv_ratio; v_ratio];
        Allt=Allt+size(t,1)/10;

        figure(1);
        plotting_M2(model);
        axis equal;
        hold on
    end
        if max_f_rod<max(max(f_rod))
           max_f_rod=max(max(f_rod));
        end
        if max_len_cable<max(max(len_cable))
            max_len_cable=max(max(len_cable));
        end
        if max_len_string<max(max(len_string))
           max_len_string=max(max(len_string));
        end
    end
    target_num=target_num+1;
end

Allmc_distance = 0;
numPoints = size(Allmc, 1);
for i = 1:numPoints-1
    currentPoint = Allmc(i, :);
    nextPoint = Allmc(i + 1, :);
    mc_distance = sqrt(sum((nextPoint - currentPoint) .^ 2));
    Allmc_distance = Allmc_distance + mc_distance;
end

save('DataSave.mat',...
    "Allbase","Allbasecoor","Allbasestate","Allt","Allmc","Allff", ...
    "Allfct","Alllen_cable","Allf_cable","Alllen_string","Allf_string", ...
    "Allf_rod","Allstra",'Allx', ...
    "Allenergy","Allv_in","Allv_out","Allv_ratio","Allmc_distance");
