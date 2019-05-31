load('myParamSet_40DendNaF_GP1axonless_full.mat');

originalSet = myParamSet;

myParamSet = zeros(1,25);
myParamSet(25) = 1;
for i = 81:1:81
    for j = 1:1:24 %parameter values...index 25 is a placeholder for the fitness of the parameter set
        myParamSet(j) = originalSet(j) * 10^(-0.602 + rand*1.204); %pick a random new value for the parameter set between 25% and 400% of original value, with an equal probability of shrinking or increasing each value
    end
    save(['myParamSet_randomSets' num2str(i) '.mat'],'myParamSet')
end