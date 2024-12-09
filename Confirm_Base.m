function model = Confirm_Base(model)
%% TR-10
if model.type == 1
    for i=1:2 
        judgebasetype1=sum(ismember(model.base,model.PT1(i,:)));
        if judgebasetype1>=3 
            model.base=model.PT1(i,:);
            model.basestate=1;
            return;
        end
    end
    for i=1:10
        judgebasetype2=sum(ismember(model.base,model.PT2(i,:)));
        if judgebasetype2>=3 
            model.base=model.PT2(i,:);
            model.basestate=2;
            return;
        end
    end
end
%% TR-6
if model.type == 2
    for i=1:8 
        judgebasetype1=sum(ismember(model.base,model.PT1(i,:)));
        if judgebasetype1>=3  
            model.base=model.PT1(i,:);
            model.basestate=1;
            return;
        end
    end
    for i=1:12
        judgebasetype2=sum(ismember(model.base,model.PT2(i,:)));
        if judgebasetype2>=3 
            model.base=model.PT2(i,:);
            model.basestate=2;
            return;
        end
    end
end

end