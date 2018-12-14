%% Variables you can play around with
% Look below for how to set up A) and B)

%Here are things to set up for 2 if you want to play around
chanceToMutate = .04; %Between 0 and 1 as it is a probability
maxSpeed = 3; %50 is MAX possible
maxJumpChance = 1; %Between 0 and 1 as it is a probability
maxJumpDistance = 10; %50 is MAX possible
mutateVector = [chanceToMutate,maxSpeed, maxJumpChance, maxJumpDistance];

epochs = 30;
populationSize = 30;


%% Setting up global variables
global mutVector;
close all;
tp = (0:0.001:1)';
yp = sin(2*pi*50*tp) + 2*sin(2*pi*120*tp);
yn = yp + 0.5*randn(size(tp));
global t;
t = tp(1:50);
global y;
y = yn(1:50);
global duration;
duration = 150;

%% Code for part a)

mutVector = [0,5,1,10]; %mutate with 0 probability
%Create population of size 2.
PARENTS = popGen(mutVector, 2);
[c1,c2] = crossover(PARENTS(1,:), PARENTS(2,:), mutVector);
CHILDREN = [c1;c2];

%% Code for part b)
MUTANT_CHILDREN = zeros(size(CHILDREN));
mutVector = [1,5,1,10]; %mutate with 1 probability
MUTANT_CHILDREN(1,:) = mut(CHILDREN(1,:));
MUTANT_CHILDREN(2,:) = mut(CHILDREN(2,:));

%% Code for part c)
%MutVector format is:
%[mutationChance, maxSpeed, maxJumpProbability, MaxJumpDistance]
mutVector = mutateVector;
popSize = populationSize;
runTimes = epochs;
starter = popGen(mutVector, popSize);
parents = starter;

fitness = zeros(runTimes,1);
for i = 1:runTimes
    avgFitness = 0;
    
    %Calculate fitness for each individual
    for j = 1:popSize
        [score,pos] = validation(parents(j,:));
        avgFitness = avgFitness + score;
    end
    %Store average fitness to look at
    fitness(i) = avgFitness/popSize;
    %Create the next generation of kids
    parents = managePop(parents, mutVector);
end

%Graph the starters on the graph. 
%% Starters
figure
subplot(2,1,1);
plot(t,y);
title(['Starter Performance with avgFitness score of ' num2str(fitness(2))]);
xlim([0 0.05]);
hold on;
positionIndex = zeros(1,popSize);
xVals = zeros(1,popSize);
yVals = zeros(1,popSize);
for i = 1:popSize
    [score,positionIndex(i)] = validation(starter(i,:));
    yVals(i) = y(positionIndex(i));
    xVals(i) = t(positionIndex(i));
end
scatter(xVals, yVals);
hold off;

u1 = unique(yVals);
psize1 = size(u1);
xx1 = zeros(1,psize1(2)); % occurances
x1 = zeros(1,psize1(2)); % x-axis position
for i = 1:psize1(2)
    for j = 1:popSize
        if(u1(i) == yVals(j))
            xx1(i) = xx1(i) + 1;
            x1(i) = xVals(j);
        end
    end
end
subplot(2,1,2);
bar(x1,xx1);
xlim([0 0.05]);
title('First Generation');
colormap(jet);


%% testing graphs
figure
subplot(2,1,1);
plot(t,y);
title(['Children Performance with avgFitness score of ' num2str(fitness(runTimes))]);
xlim([0 0.05]);
hold on;
positionIndex = zeros(1,popSize);
xVals = zeros(1,popSize);
yVals = zeros(1,popSize);
for i = 1:popSize
    [score,positionIndex(i)] = validation(parents(i,:));
    yVals(i) = y(positionIndex(i));
    xVals(i) = t(positionIndex(i));
end
scatter(xVals, yVals);
hold off;

u1 = unique(yVals);
psize1 = size(u1);
xx1 = zeros(1,psize1(2)); % occurances
x1 = zeros(1,psize1(2)); % x-axis position
for i = 1:psize1(2)
    for j = 1:popSize
        if(u1(i) == yVals(j))
            xx1(i) = xx1(i) + 1;
            x1(i) = xVals(j);
        end
    end
end
subplot(2,1,2);
bar(x1,xx1);
xlim([0 0.05]);
title('Last Generation');
colormap(jet);
