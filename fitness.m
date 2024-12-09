function f=fitness(individual,model)
for i=1:size(model.rod,1)
    if individual(i)==0
        model.lr(i)=model.lrmin;
    elseif individual(i)==1
        model.lr(i)=model.lrmax;
    end
end

[model.x,~] = dynrlx(model);
model.x = adjustcor(model);
[f,~,~] = masscenter(model);

end