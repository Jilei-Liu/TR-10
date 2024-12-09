function model = Finding_RollAxis(target,model)
% Determine the roll axis based on the current position and target point of the structure
% Each change in configuration requires the replacement of the "roll axis determination part" of the function based on the condition of the bottom surface
%% TR-10
if model.type == 1
    xv = [model.x(model.base(1),1),model.x(model.base(2),1),model.x(model.base(3),1),...
        model.x(model.base(4),1),model.x(model.base(5),1)];
    yv = [model.x(model.base(1),2),model.x(model.base(2),2),model.x(model.base(3),2),...
        model.x(model.base(4),2),model.x(model.base(5),2)];
    xq = target(1,1);
    yq = target(1,2);
    [in,on] = inpolygon(xq,yq,xv,yv);
    
    base=model.base;
    distance=zeros(length(base),1);
    for i=1:length(base)
        l=target-model.x(base(i),:);
        l(3)=0;
        distance(i)=norm(l);
    end

    if in ==1 || on ==1 || mean(distance)<model.lrmin/2
      model.rollaxis = [0 0];
      return;
    end  

    T = target;
    T(3) = 0;    
    P1=model.x(model.base(1),:);
    P2=model.x(model.base(2),:);
    P3=model.x(model.base(3),:); 
    P4=model.x(model.base(4),:);
    P5=model.x(model.base(5),:);
    
    P1(3)=0;
    P2(3)=0;
    P3(3)=0; 
    P4(3)=0;
    P5(3)=0;
    
    P=(P1+P2+P3+P4+P5)/5;
    PT = T-P;
    PP1 = 1*((P1-P)+(P2-P));
    PP2 = 1*((P2-P)+(P3-P));
    PP3 = 1*((P3-P)+(P4-P));  
    PP4 = 1*((P4-P)+(P5-P));
    PP5 = 1*((P5-P)+(P1-P));
    
    P1T = PT - PP1;
    P2T = PT - PP2;
    P3T = PT - PP3;
    P4T = PT - PP4;
    P5T = PT - PP5;

    judgebasetype1=sum(ismember(model.base,model.PT1));
    if judgebasetype1>=4  
        distance=[norm(P1T ) norm(P2T) norm(P3T) norm(P4T) norm(P5T)];
        [~,I]=min(distance);
        switch I
            case 1
                model.rollaxis=[model.base(1) model.base(2)];
            case 2
                model.rollaxis=[model.base(2) model.base(3)];
            case 3
                model.rollaxis=[model.base(3) model.base(4)];
            case 4
                model.rollaxis=[model.base(4) model.base(5)];
            case 5
                model.rollaxis=[model.base(5) model.base(1)];
        end
    end
    judgebasetype2=sum(ismember(model.base,model.PT2));
    if judgebasetype2>=3  
        P4T = [9999 9999 0];
        distance=[norm(P1T) norm(P2T) norm(P3T) norm(P4T) norm(P5T)]; 
        [~,I]=min(distance);
        switch I
            case 1
                model.rollaxis=[model.base(1) model.base(2)];
            case 2
                model.rollaxis=[model.base(2) model.base(3)];
            case 3
                model.rollaxis=[model.base(3) model.base(4)];
            case 4
                model.rollaxis=[model.base(4) model.base(5)];
            case 5
                model.rollaxis=[model.base(5) model.base(1)];
        end
    end
end
%% TR-6
if model.type == 2
    xv = [model.x(model.base(1),1),model.x(model.base(2),1),model.x(model.base(3),1)];
    yv = [model.x(model.base(1),2),model.x(model.base(2),2),model.x(model.base(3),2)];
    xq = target(1,1);
    yq = target(1,2);
    [in,on] = inpolygon(xq,yq,xv,yv);
    
    base=model.base;
    distance=zeros(length(base),1);
    for i=1:length(base)
        l=target-model.x(base(i),:);
        l(3)=0;
        distance(i)=norm(l);
    end

    if in ==1 || on ==1 || mean(distance)<model.lrmin/2
      model.rollaxis = [0 0];
      return;
    end
    
    T = target;
    T(3) = 0;
    
    P1=model.x(model.base(1),:);
    P2=model.x(model.base(2),:);
    P3=model.x(model.base(3),:); 
    
    P1(3)=0;
    P2(3)=0;
    P3(3)=0;
    
    P=(P1+P2+P3)/3;
    PT = T-P;
    PP1 = 1*((P1-P)+(P2-P));
    PP2 = 1*((P2-P)+(P3-P));
    PP3 = 1*((P3-P)+(P1-P));  
    
    P1T = PT - PP1;
    P2T = PT - PP2;
    P3T = PT - PP3;
      
    judgebasetype1=sum(ismember(model.base,model.PT1));
    if judgebasetype1>=3  
        distance=[norm(P1T ) norm(P2T) norm(P3T)];
        [~,I]=min(distance);
        switch I
            case 1
                model.rollaxis=[model.base(1) model.base(2)];
            case 2
                model.rollaxis=[model.base(2) model.base(3)];
            case 3
                model.rollaxis=[model.base(3) model.base(1)];
        end
    end
    judgebasetype2=sum(ismember(model.base,model.PT2));
    if judgebasetype2>=3  
        P2T = [9999 9999 0];
        distance=[norm(P1T) norm(P2T) norm(P3T)]; 
        [~,I]=min(distance);
        switch I
            case 1
                model.rollaxis=[model.base(1) model.base(2)]; 
            case 2
                model.rollaxis=[model.base(2) model.base(3)];
            case 3
                model.rollaxis=[model.base(3) model.base(1)];
        end
    end
end

end
