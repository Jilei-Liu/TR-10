classdef tensegrity_6_bar
%Tensegrity Class
    properties
        %===============================================================
        rod = [1 2;3 4;5 6;7 8;9 10;11 12];
        cable = [1 5;1 6;1 9;1 11;2 7;2 8;2 9;2 11;3 5;3 6;3 10;3 12;
            4 7;4 8;4 10;4 12;5 9;5 10;6 11;6 12;7 9;7 10;8 11;8 12];
        string = [1 13;2 13;3 13;4 13;5 13;6 13;7,13;8,13;9,13;10,13;11,13;12,13];
        PT1 = [1 5 9;1 6 11;2 7 9;2 8 11;3 5 10;3 6 12;4 7 10;4 8 12];% Closed triangle
        PT2 = [5 1 3;6 1 3;9 5 7;10 5 7;1 9 11;2 9 11;
            12 6 8;11 6 8;8 2 4;7 2 4;4 10 12;3 10 12];% Open triangle
        %===============================================================
        % Rod drive limit
        lrmax=0.825;
        lrmin=0.525;
        % Stiffness
        k_rod = 30000*1000;
        k_cable=2.148*1000;
        k_string=0.1*1000;
        % Damping
        c_rod = 200;
        c_cable = 200;
        c_string = 5;
        %==============================================================
        c = [];
        base = [];
        basestate=[];
        rollaxis = [];
        lr = [];
        lc = [];
        ls = [];
        x = [];
        energy = [];
        innerspace = [];
    end

    methods
        function obj = tensegrity_6_bar   
            num_edge = size(obj.rod,1)+size(obj.cable,1)+size(obj.string,1); 
            num_node=2*size(obj.rod,1)+1;
            obj.c = zeros(num_edge,num_node); 
            for i = 1:size(obj.rod,1)
                obj.c(i,obj.rod(i,1)) = 1;
                obj.c(i,obj.rod(i,2)) = -1;
            end 
            for i = 1:size(obj.cable,1)
                obj.c(i+size(obj.rod,1),obj.cable(i,1)) = 1;
                obj.c(i+size(obj.rod,1),obj.cable(i,2)) = -1;
            end 
            for i = 1:size(obj.string,1)
                obj.c(i+size(obj.rod,1)+size(obj.cable,1),obj.string(i,1)) = 1;
                obj.c(i+size(obj.rod,1)+size(obj.cable,1),obj.string(i,2)) = -1;
            end 
        end

        function obj = iniStatic(obj) 
            num_node=2*size(obj.rod,1);

            obj.x = 1*max(obj.lr)*rand(num_node,3); 
            [obj.x,obj.energy] = dynrlx(obj); 

            obj.x = adjustcor(obj);
            x0=[mean(obj.x(obj.string(:,1),1)) mean(obj.x(obj.string(:,1),2)) mean(obj.x(obj.string(:,1),3))];
            obj.x= [obj.x; x0];
        end
    end
end