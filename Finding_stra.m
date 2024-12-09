function stra=Finding_stra(model)
%% TR-6
if model.type == 2
    a = model.lrmin;
    b = model.lrmax; 
    judgebasetype1=sum(ismember(model.base,model.PT1));
    if judgebasetype1 == 3 
         if sum(ismember(model.base,[1 5 9])) == 3
            if sum(ismember(model.rollaxis,[1 5])) == 2
               stra = [a a a b b a];             
            elseif  sum(ismember(model.rollaxis,[5 9])) == 2
               stra = [b a a a a b];
            elseif  sum(ismember(model.rollaxis,[9 1])) == 2
               stra = [a b b a a a];
            end
        end
        if sum(ismember(model.base,[1 6 11])) == 3
            if sum(ismember(model.rollaxis,[1 6])) == 2
               stra = [a a a b a b];
            elseif  sum(ismember(model.rollaxis,[6 11])) == 2
               stra = [b a a a b a];
            elseif  sum(ismember(model.rollaxis,[11 1])) == 2
               stra = [a b b a a a];
            end
        end
        if sum(ismember(model.base,[2 7 9])) == 3
            if sum(ismember(model.rollaxis,[2 7])) == 2
               stra = [a a b a b a];            
            elseif  sum(ismember(model.rollaxis,[7 9])) == 2
               stra = [a b a a a b];
            elseif  sum(ismember(model.rollaxis,[9 2])) == 2
               stra = [a b a b a a];
            end
        end
        if sum(ismember(model.base,[2 8 11])) == 3
            if sum(ismember(model.rollaxis,[2 8])) == 2
               stra = [a a b a a b];
            elseif  sum(ismember(model.rollaxis,[8 11])) == 2
               stra = [b a a a b a];
            elseif  sum(ismember(model.rollaxis,[11 2])) == 2
               stra = [a b a b a a];
            end
        end
        if sum(ismember(model.base,[3 5 10])) == 3
            if sum(ismember(model.rollaxis,[3 5])) == 2
               stra = [a a a b b a];             
            elseif  sum(ismember(model.rollaxis,[5 10])) == 2
               stra = [a b a a a b];
            elseif  sum(ismember(model.rollaxis,[10 3])) == 2
               stra = [b a b a a a];
            end
        end
        if sum(ismember(model.base,[3 6 12])) == 3
            if sum(ismember(model.rollaxis,[3 6])) == 2
               stra = [a a a b a b];
            elseif  sum(ismember(model.rollaxis,[6 12])) == 2
               stra = [a b a a b a];
            elseif  sum(ismember(model.rollaxis,[12 3])) == 2
               stra = [b a b a a a];
            end
        end
        if sum(ismember(model.base,[4 7 10])) == 3
            if sum(ismember(model.rollaxis,[4 7])) == 2
               stra = [a a b a b a];            
            elseif  sum(ismember(model.rollaxis,[7 10])) == 2
               stra = [a b a a a b];
            elseif  sum(ismember(model.rollaxis,[10 4])) == 2
               stra = [b a a b a a];
            end
        end
        if sum(ismember(model.base,[4 8 12])) == 3
            if sum(ismember(model.rollaxis,[4 8])) == 2
               stra = [a a b a a b];
            elseif  sum(ismember(model.rollaxis,[8 12])) == 2
               stra = [a b a a b a];
            elseif  sum(ismember(model.rollaxis,[12 4])) == 2
               stra = [b a a b a a];
            end
        end
    end
    judgebasetype2=sum(ismember(model.base,model.PT2));
    if judgebasetype2 == 3  
        if sum(ismember(model.base,[5 1 3])) == 3
            if sum(ismember(model.rollaxis,[5 1])) == 2
               stra = [a b b a a a];
            elseif  sum(ismember(model.rollaxis,[1 3])) == 2
               stra = [a a b a a b];
            elseif  sum(ismember(model.rollaxis,[3 5])) == 2
               stra = [b a b a a a];
            end
        end
        if sum(ismember(model.base,[6 1 3])) == 3
            if sum(ismember(model.rollaxis,[6 1])) == 2
               stra = [a b b a a a];
            elseif  sum(ismember(model.rollaxis,[1 3])) == 2
               stra = [a a b a b a];
            elseif  sum(ismember(model.rollaxis,[3 6])) == 2  
               stra = [b a b a a a];
            end
        end
        if sum(ismember(model.base,[9 5 7])) == 3
            if sum(ismember(model.rollaxis,[9 5])) == 2
               stra = [a a a b b a];
            elseif  sum(ismember(model.rollaxis,[5 7])) == 2
               stra = [a b a a b a];
            elseif  sum(ismember(model.rollaxis,[7 9])) == 2
               stra = [a a b a b a];
            end
        end
        if sum(ismember(model.base,[10 5 7])) == 3
            if sum(ismember(model.rollaxis,[10 5])) == 2
               stra = [a a a b b a];
            elseif  sum(ismember(model.rollaxis,[5 7])) == 2
               stra = [b a a a b a];
            elseif  sum(ismember(model.rollaxis,[7 10])) == 2  
               stra = [a a b a b a];
            end
        end
       if sum(ismember(model.base,[1 9 11])) == 3
            if sum(ismember(model.rollaxis,[1 9])) == 2
               stra = [b a a a a b];
            elseif  sum(ismember(model.rollaxis,[9 11])) == 2
               stra = [b a a b a a];
            elseif  sum(ismember(model.rollaxis,[11 1])) == 2
               stra = [b a a a b a];
            end
        end
        if sum(ismember(model.base,[2 9 11])) == 3
            if sum(ismember(model.rollaxis,[2 9])) == 2
               stra = [b a a a a b];
            elseif  sum(ismember(model.rollaxis,[9 11])) == 2
               stra = [b a b a a a];
            elseif  sum(ismember(model.rollaxis,[11 2])) == 2  
               stra = [b a a a b a];
            end
        end
        if sum(ismember(model.base,[12 6 8])) == 3
            if sum(ismember(model.rollaxis,[12 6])) == 2
               stra = [a a a b a b];
            elseif  sum(ismember(model.rollaxis,[6 8])) == 2
               stra = [b a a a a b];
            elseif  sum(ismember(model.rollaxis,[8 12])) == 2
               stra = [a a b a a b];
            end
        end
        if sum(ismember(model.base,[11 6 8])) == 3
            if sum(ismember(model.rollaxis,[11 6])) == 2
               stra = [a a a b a b];
            elseif  sum(ismember(model.rollaxis,[6 8])) == 2
               stra = [a b a a a b];
            elseif  sum(ismember(model.rollaxis,[8 11])) == 2  
               stra = [a a b a a b];
            end
        end
        if sum(ismember(model.base,[8 2 4])) == 3
            if sum(ismember(model.rollaxis,[8 2])) == 2
               stra = [a b a b a a];
            elseif  sum(ismember(model.rollaxis,[2 4])) == 2
               stra = [a a a b b a];
            elseif  sum(ismember(model.rollaxis,[4 8])) == 2
               stra = [b a a b a a];
            end
        end
        if sum(ismember(model.base,[7 2 4])) == 3
            if sum(ismember(model.rollaxis,[7 2])) == 2
               stra = [a b a b a a];
            elseif  sum(ismember(model.rollaxis,[2 4])) == 2
               stra = [a a a b a b];
            elseif  sum(ismember(model.rollaxis,[4 7])) == 2  
               stra = [b a a b a a];
            end
        end
       if sum(ismember(model.base,[4 10 12])) == 3
            if sum(ismember(model.rollaxis,[4 10])) == 2
               stra = [a b a a a b];
            elseif  sum(ismember(model.rollaxis,[10 12])) == 2
               stra = [a b b a a a];
            elseif  sum(ismember(model.rollaxis,[12 4])) == 2
               stra = [a b a a b a];
            end
        end
        if sum(ismember(model.base,[3 10 12])) == 3
            if sum(ismember(model.rollaxis,[3 10])) == 2
               stra = [a b a a a b];
            elseif  sum(ismember(model.rollaxis,[10 12])) == 2
               stra = [a b a b a a];
            elseif  sum(ismember(model.rollaxis,[12 3])) == 2  
               stra = [a b a a b a];
            end
        end
        return;
    end
end

%% TR-10
if model.type == 1
    a = model.lrmin;
    b = model.lrmax; 
    judgebasetype1=sum(ismember(model.base,model.PT1));
    if judgebasetype1>=3
        if sum(ismember(model.base,[9 13 1 3 16])) == 5
            if sum(ismember(model.rollaxis,[1 13])) == 2
               stra = [b a b b a b a b a b];             
            elseif  sum(ismember(model.rollaxis,[13 9])) == 2
               stra = [b a b a a a a a a a];
            elseif  sum(ismember(model.rollaxis,[9 16])) == 2
               stra = [b b b b b b a a a a];
            elseif  sum(ismember(model.rollaxis,[16 3])) == 2
               stra = [b b a b a a a b b b];
            elseif  sum(ismember(model.rollaxis,[3 1])) == 2
               stra = [a b b b b a b a a b];
            end
        end
        if sum(ismember(model.base,[2 4 20 12 17])) == 5
            if sum(ismember(model.rollaxis,[2 4])) == 2
               stra = [b a b b a b a b a b];
            elseif  sum(ismember(model.rollaxis,[2 17])) == 2
               stra = [a b b b b a b a a b];
            elseif  sum(ismember(model.rollaxis,[17 12])) == 2
               stra = [b b a b a a a b b b];
            elseif  sum(ismember(model.rollaxis,[12 20])) == 2
               stra = [b b b b b b a a a a];
            elseif  sum(ismember(model.rollaxis,[20 4])) == 2
               stra = [b b b a a a b a b b];
            end
        end
        return;
    end
    judgebasetype2=sum(ismember(model.base,model.PT2));
    if judgebasetype2>=3  
        if sum(ismember(model.base,[13 1 14 6 5])) == 5
            if sum(ismember(model.rollaxis,[1 13])) == 2
               stra = [0.8*a a a a b b b a b a];
            elseif  sum(ismember(model.rollaxis,[13 5])) == 2
               stra = [b a a 0.8*a b b b a b a];
            elseif  sum(ismember(model.rollaxis,[5 6])) == 2
               stra = [a b a b a a a b b a];
            elseif  sum(ismember(model.rollaxis,[6 14])) == 2
               stra = [b b a a b b a b a a];
            elseif  sum(ismember(model.rollaxis,[1 14])) == 2
                 stra = [a b b a b b b b a b];
            end
        end
        if sum(ismember(model.base,[17 2 15 5 6])) == 5
            if sum(ismember(model.rollaxis,[2 15])) == 2
               stra = [b a a b b b b a a b];
            elseif  sum(ismember(model.rollaxis,[15 5])) == 2
               stra = [b b a a b b b a a a];
            elseif  sum(ismember(model.rollaxis,[5 6])) == 2
               stra = [b a b a a a b a b a];
            elseif  sum(ismember(model.rollaxis,[6 17])) == 2
               stra = [a b 0.8*a a b b a b b a];
            elseif  sum(ismember(model.rollaxis,[2 17])) == 2
               stra = [a 0.8*a a a b b a b b a];
            end
        end
        if sum(ismember(model.base,[3 16 7 8 18])) == 5
            if sum(ismember(model.rollaxis,[3 16])) == 2
               stra = [a a 0.8*a a b b b b a a];
            elseif  sum(ismember(model.rollaxis,[16 7])) == 2
               stra = [a b b b a b a b b a];
            elseif  sum(ismember(model.rollaxis,[7 8])) == 2
               stra = [a a b a a b a b b b];
            elseif  sum(ismember(model.rollaxis,[8 18])) == 2
               stra = [b a b a b a b a a a];
            elseif  sum(ismember(model.rollaxis,[3 18])) == 2
               stra = [0.8*a a a a b b b b a b];
            end
        end
        if sum(ismember(model.base,[4 20 8 7 19])) == 5
            if sum(ismember(model.rollaxis,[4 19])) == 2
               stra = [a 0.8*a a a b b b b a b];
            elseif  sum(ismember(model.rollaxis,[19 7])) == 2
               stra = [a b a b a a a b b a];
            elseif  sum(ismember(model.rollaxis,[7 8])) == 2
               stra = [a a a b b a b a b b];
            elseif  sum(ismember(model.rollaxis,[8 20])) == 2
               stra = [b a b b b a b a b a];
            elseif  sum(ismember(model.rollaxis,[4 20])) == 2
               stra = [a a a a b b b b a 0.8*a];
            end
        end
        if sum(ismember(model.base,[1 3 18 10 14])) == 5
            if sum(ismember(model.rollaxis,[1 3])) == 2
               stra = [a a 0.8*a a a b b b b a];
            elseif  sum(ismember(model.rollaxis,[3 18])) == 2
               stra = [b a a b b a b a b b];
            elseif  sum(ismember(model.rollaxis,[18 10])) == 2
               stra = [b a b a b a b a b a];
            elseif  sum(ismember(model.rollaxis,[10 14])) == 2
               stra = [b b a a b b a a a a];
            elseif  sum(ismember(model.rollaxis,[1 14])) == 2
               stra = [a 0.8*a b a a b b b b a];
            end
        end
        if sum(ismember(model.base,[2 4 19 11 15])) == 5
            if sum(ismember(model.rollaxis,[2 4])) == 2
               stra = [a a a 0.8*a b a b b b a];
            elseif  sum(ismember(model.rollaxis,[4 19])) == 2
               stra = [a b b a a b a b b b];
            elseif  sum(ismember(model.rollaxis,[19 11])) == 2
               stra = [a b a b a b a b b a];
            elseif  sum(ismember(model.rollaxis,[11 15])) == 2
               stra = [b b a a b b a a a a];
            elseif  sum(ismember(model.rollaxis,[2 15])) == 2
               stra = [0.8*a a a b b a b b b a];
            end
        end
        if sum(ismember(model.base,[9 13 5 15 11])) == 5
            if sum(ismember(model.rollaxis,[5 15])) == 2
               stra = [a b a b a a b b b a];
            elseif  sum(ismember(model.rollaxis,[15 11])) == 2
               stra = [a a a b b a b a a b];
            elseif  sum(ismember(model.rollaxis,[11 9])) == 2
               stra = [a b a a b b a b b a];
            elseif  sum(ismember(model.rollaxis,[9 13])) == 2
               stra = [a 0.8*a a a b b a b b a];
            elseif  sum(ismember(model.rollaxis,[5 13])) == 2
               stra = [b a b b a a b b b a];
            end
        end
        if sum(ismember(model.base,[12 17 6 14 10])) == 5
            if sum(ismember(model.rollaxis,[6 14])) == 2
               stra = [b a b a a a b b b a];
            elseif  sum(ismember(model.rollaxis,[14 10])) == 2
               stra = [a a b a a b a b a b];
            elseif  sum(ismember(model.rollaxis,[10 12])) == 2
               stra = [b a a a b b b a b 0.8*a];
            elseif  sum(ismember(model.rollaxis,[12 17])) == 2
               stra = [0.8*a a a a b b b a b a];
            elseif  sum(ismember(model.rollaxis,[6 17])) == 2
               stra = [a b b b a a b b b a];
            end
        end
        if sum(ismember(model.base,[16 9 11 19 7])) == 5
            if sum(ismember(model.rollaxis,[7 16])) == 2
               stra = [a a 0.8*a b b a a b b b];
            elseif  sum(ismember(model.rollaxis,[16 9])) == 2
               stra = [a a a a b a b b b 0.8*a];
            elseif  sum(ismember(model.rollaxis,[9 11])) == 2
               stra = [b b a a b b b a a b];
            elseif  sum(ismember(model.rollaxis,[11 19])) == 2
               stra = [a a a b b b b a a b];
            elseif  sum(ismember(model.rollaxis,[7 19])) == 2
               stra = [a a b a a b a b a b];
            end
        end
        if sum(ismember(model.base,[20 12 10 18 8])) == 5
            if sum(ismember(model.rollaxis,[8 18])) == 2
               stra = [a a a b b a b a a b];
            elseif  sum(ismember(model.rollaxis,[18 10])) == 2
               stra = [a a b a b b a b a b];
            elseif  sum(ismember(model.rollaxis,[10 12])) == 2
               stra = [b b a a b b a b a b];
            elseif  sum(ismember(model.rollaxis,[12 20])) == 2
               stra = [a a 0.8*a a a b b b b a];
            elseif  sum(ismember(model.rollaxis,[8 20])) == 2
               stra = [a a b 0.8*a a b b b b a];
            end
        end
        return;
    end
end

end