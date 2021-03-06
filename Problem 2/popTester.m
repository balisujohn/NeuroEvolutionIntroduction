%% popTester
%Tests out different bits of code with the populationManager, crossover,
%mut, and population generator.
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
duration = 1000;
%% Test 1 GOOD
%Does the test produce feasible results during one iteration?
%Success: Has a 6 in the final output, using test fitness function as the
%jump distance
pop = [1,2,3;4,5,6];
mutVector = [0,1,1,1];

%test1 = managePop(pop, mutVector);

%% Test 2 GOOD
%Success: Only 6 in the final output.
pop = [1,2,3;4,5,6;7,8,6;9,10,6;11,12,6;13,14,7;15,16,1;17,18,2];
mutVector = [0,1,1,1];
test2 = pop;
for i = 1:5
    %test2 = managePop(test2, mutVector);
end

%% Test 3 GOOD
%Does the mutation vector act?
%Success: a number above 6 appears in the output after many iterations.
pop = [1,.3,3;4,.3,6;7,.8,6];
mutVector = [.1,10,1,50]; %.1 percent chance of movement, max jump of 50
test3 = pop;
for i = 1:50
    %test3 = managePop(test3, mutVector);
end
%This is random - have gotten results in which 43.96 is used though. 

%% Test 4 GOOD
%Check the popGen function to generate the initial population
mutVector = [.05,4,1,10];
sizeOfPop = 20;
pop = popGen(mutVector, sizeOfPop);
test4=pop;

for i = 1:500
    test4 = managePop(test4, mutVector);
end
test4 = test4
[score,pos] = validation(test4(1,:))
