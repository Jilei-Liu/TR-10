classdef tensegrity_10_bar
    properties
        type = 1;
        rod = [1 17; 2 13; 3 12; 4 9; 5 19; 6 18; 7 10; 8 11; 14 15; 16 20];     
        cable = [1,3; 1,13; 1,14; 2,4; 2,15; 2,17; 3,16; 3,18; 4,19; 4,20;
                 5,6; 5,13; 5,15; 6,14; 6,17; 7,8; 7,16; 7,19; 8,18; 8,20; 
                 9,11; 9,13; 9,16; 10,12; 10,14; 10,18; 11,15; 11,19; 12,17; 12,20];
        string = [1 21;2 21;3 21;4 21;5 21;6 21;7 21;8 21;9 21;10 21;
                 11 21;12 21;13 21;14 21;15 21;16 21;17 21;18 21;19 21;20 21];
        PT1 = [9 13 1 3 16; 2 4 20 12 17];
        PT2 = [13 1 14 6 5;17 2 15 5 6;3 16 7 8 18;4 20 8 7 19;1 3 18 10 14;
               2 4 19 11 15;9 13 5 15 11;12 17 6 14 10;16 9 11 19 7;20 12 10 18 8];
        %===============================================================
        lrmax=0.825;
        lrmin=0.525;
        k_rod = 30000*1000;
        k_cable=2.46*1000;
        k_string=0.1*1000;
        c_rod = 200;
        c_cable = 200;
        c_string = 5;
        %===============================================================
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
        function obj = tensegrity_10_bar  
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