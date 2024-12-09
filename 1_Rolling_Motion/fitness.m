function f=fitness(individual,model)
% The following are the codes for the shortest or longest bar length
for i=1:size(model.rod,1)
    if individual(i)==0
        model.lr(i)=model.lrmin;
    elseif individual(i)==1
        model.lr(i)=model.lrmax;
    end
end
model.x=model.x(1:(end-1),:);
[model.x,~] = dynrlx(model);
model.x = adjustcor(model);
[f,~,~] = masscenter(model);
end