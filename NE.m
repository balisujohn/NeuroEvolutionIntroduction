
    
    

%creates a random adjacency matrix
Ad = randi([0 1],5,5)
for i = 1:size(Ad,2)
Ad(i,i) = 0
end

%creates weight matrix
W = rand(5,5).* 5 

%creates a random threshold vectors
thresh = rand(5,1).* 10

inputs = [1 ; 1 ; 1 ; 1; 1]

[Ad, W, thresh] = mutate(Ad, W, thresh, 2)


%simple advance test
%o = advance(Ad, W, inputs ,thresh)


%mutation tests
%[test1,test2]= neuronCountMutation(Ad, thresh,4)
%test3 = connectivityMutation(Ad)
%test4 = weightMutation(W)
%test5 = thresholdMutation(thresh)
    
    function outputs = advance(Adj , W, i , t)
    Wa = W .* Adj
    s = Wa * i
   % s = atanh(s)
    o = (s-t)>0
    outputs = o
    end
    
    %mutation functions
    
    function [newAdj,newWeights,newThresh] = mutate(Adj, weights, thresh, minSize)
    newAdj = Adj;
    newWeights = weights ;
    newThresh = thresh;
    [newWeights, newAdj, newThresh] = neuronCountMutation(newAdj,newWeights ,newThresh, minSize);
    newAdj = connectivityMutation(newAdj);
    newWeights = weightMutation(newWeights);
    newThresh = thresholdMutation(newThresh);
    end
    
    
    
    function [newWeights, newAdj, newThresh] = neuronCountMutation(Adj, weights,  thresh, minSize)
    
    if rand(1,1) > .5
        newThresh = [thresh ; rand(1,1)] ;
        newWeights = [[Adj zeros(size(Adj,1), 1)];zeros(1,size(Adj,1)+1)];
        newAdj = [[Adj zeros(size(Adj,1), 1)];zeros(1,size(Adj,1)+1)];
    elseif size(Adj,1) >minSize
        newThresh = thresh(1:size(thresh,1)-1, :);
        newWeights = weights(1:size(weights,1)-1,1:size(weights,2)-1);
        newAdj = Adj(1:size(Adj,1)-1,1:size(Adj,2)-1);
    end
    
    end
    
    
    function newAdj = connectivityMutation(Adj)
    
    output = Adj;
    for i = 1:size(Adj,1)
        for c = 1:size(Adj,1)
        if rand(1,1) > .9 && i ~= c 
               output(i,c) = xor(output(i,c),1) ;
        end
        end
    end
     newAdj = output;
    end
    
    function newWeights = weightMutation(weights)
    
      output = weights;
    for i = 1:size(weights,1)
        for c = 1:size(weights,1)
        if rand(1,1) > .9 && i ~= c 
               output(i,c) = output(i,c) + rand(1,1) - .5;
        end
        end
    end
     newWeights = output;
    
    end
    
    
    function newThresh = thresholdMutation(thresh)
    output = thresh;
    for i = 1:size(thresh,2)
        output(i,1) = output(i,1) + rand(1,1) - .5;
    
    end
    newThresh = output;
    
    end
   
    
    
    
    
    
    

    
    
    
