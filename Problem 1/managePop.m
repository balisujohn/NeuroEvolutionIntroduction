%Breed the current population with considering fitness 
function population = managePop(curr, mutVector)
%% Variable set up 
    popSize = size(curr,1); %How many members are in the initial set
    fitness = zeros(popSize,1); %Where we will describe fitness for items
    breedingChances = zeros(popSize,1); %How many chances each get
    totalFit = 0; %Pre-load totalfitness for aggregation.
    numTotalBreed = popSize * 2; %2 is arbitrary, could be any value. 
    %2 awards high performers more chances while limiting very low performers
    
%% Fitness Calculation
    for i = 1:popSize
        currFit = fitnessTest(curr(i,:));
        
        %Keep track of individual fitness as well as total.
        totalFit = totalFit + currFit;
        fitness(i) = currFit;
    end
    
    %Combine the fitness array onto the curr population
    manager = [curr,fitness];
%% Sort by Fitness
    %Create 'unfair' breeding - the top performant one gets most mating
    %Sort matrix by the fitness value, ascending order (low at top, best at
    %bottom)
    [~,id] = sort(manager(:,4));
    manager = manager(id,:);

%% Calculate breed amount based on fitness
   %We gave an estimate, but since we use a ceil function, we may get a few
   %more breeding opportunities that we expected.
   actualTotalBreed = 0; %accounts for extra chances
   for i = 1:popSize
       %This is our breedcalcuation function
       breedTimes = ceil(manager(i,4) / totalFit * numTotalBreed);
       actualTotalBreed = breedTimes + actualTotalBreed;
       breedingChances(i) = breedTimes;
   end
   
   %add on breeding chances to our parent's array.
   manager = [manager,breedingChances];

%% Create new Population
   %Use the breeding chances to calculate the children
   %Parents will not be a part of the next set.
   
   %This is sized so that every breed will result in 2 children, 
   %and every creature in the population will need it's genome + fitness
   population = zeros(actualTotalBreed*2,4); 
   
   for i = 1:actualTotalBreed
       %Select 2 things to breed 
       %Code could be more efficient by removing a parent from the array
       %after it has 0 chances.
       
       %Choose father
       selected = false;
       while(~selected) 
           r = rand;
           if(manager(ceil(r*popSize),5) > 0)
               father = manager(ceil(r*popSize),:); 
               selected = true;
               %Now has one less chance to breed
               father(5) = father(5) - 1;
           end
       end
       %find mother. I could add a function, but Its finals week and I just
       %want this to work, you feel me?
       selected = false;
       while(~selected) 
           r = rand;
           if(manager(ceil(r*popSize),5) > 0)
               mother = manager(ceil(r*popSize),:);
               selected = true;
               %Now has one less chance to breed
               mother(5) = mother(5) - 1;
           end
       end
       
       [c1,c2] = crossover(mother, father, mutVector);
       
       %family = zeros(4,5)
       %family(1:2,:) = [mother;father];
       %family(3:4,1:3) = [c1;c2]; Testing constructions to see what
       %parents produce. 
       
       %Add resultant to population matrix, with no fitness score.
       population(i*2-1,:) = [c1,0];
       population(i*2,:) = [c2,0];
    
   end
   
%% Calculate new pop fitness
for i = 1:(actualTotalBreed*2)
        population(i,4) = fitnessTest(population(i,:));
end   

%% Sort array by fitness
[~,id] = sort(population(:,4));
population = population(id,:);

%% Split off fitness score return top X perfomers
%The 3 comes from the size of the genome. 
population = population(actualTotalBreed*2-popSize:actualTotalBreed*2,1:3);
%want the performers on the bottom (highest fitness) so...
%do actualTotalBreed*2-popSize -> actualTotalBreed
    
    
    
    
    
         
        
    
    
    
