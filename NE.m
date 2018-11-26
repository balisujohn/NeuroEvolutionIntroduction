
    
    






%simple advance test
%o = advance(Ad, W, inputs ,thresh)


%mutation tests
%[test1,test2]= neuronCountMutation(Ad, thresh,4)
%test3 = connectivityMutation(Ad)
%test4 = weightMutation(W)
%test5 = thresholdMutation(thresh)
%[Ad, W, thresh] = mutate(Ad, W, thresh, 2)

test1 = [0 1 0 ]
test2 = [0 0 1]
test3 = combine(test1, test2)

xorTest()


    %learningFunctions
    function result = xorTest()
    
    [Adj, W, thresh] = randTopology(10);
    score = 0;
    bestScore = 0
    while score < 4;
        score = 0;
        
        [mAdj,mW,mThresh] = mutate(Adj,W,thresh,10);
        
       inputs = [1 1 1 0;
                 1 0 1 0;
                 1 1 0 0;
                 1 0 0 0];
       %negative one signifies that we aren't checking the output  
       outputs = [-1 -1 -1 0;
                  -1 -1 -1 1;
                  -1 -1 -1 1;
                  -1 -1 -1 0];
          
             
        for i = 1:size(inputs,1);
        input = inputs(i,:);
        goalOutput = outputs(i,:);
        observedOutput = zeros(1,size(goalOutput,2));
        testMAdj = mAdj;
        testMW = mW;
        testMThresh = mThresh;
        
        %running the network
        for c = 1:10
        observedOutput = advance(testMAdj,testMW,input, testMThresh);
        tbi = [inputs(i,:) zeros(1, size(observedOutput',2) - size(inputs,2))];
        input = combine(tbi,  observedOutput');
        end
        
        for c = 1:size(goalOutput,2)
         if goalOutput(1,c) > 0 && (goalOutput(1,c) == observedOutput(c,1))
            score = score +1 ;
         end
        end
        
        
        end
        
        if score > bestScore
        Adj = mAdj;
        W = mW;
        thresh = mThresh;
        bestScore = score
        end
    
    end
    
    result = bestScore;
    
    end

    %runtime functions
    
    function [Adj, W, thresh] = randTopology(size)
    %creates a random adjacency matrix
    Adj = randi([0 1],size,size);
    for i = 1:size;
    Adj(i,i) = 0;
    end

    %creates weight matrix
    W = rand(size,size).* 5 ;

    %creates a random threshold vectors
    thresh = rand(size,1).* 10;
    
    end

    function outputs = advance(Adj , W, i , t)
    assert(size(i,1) == 1)
     if size(i,2) < size(W,2);
    i = [i zeros(1, size(W,2) - size(i,2))];
    end
    Wa = W .* Adj;
    s = Wa * i';
   % s = atanh(s);
    outputs = (s-t)>0;
    
    end
   
    
    %mutation functions
    
    function [newAdj,newWeights,newThresh] = mutate(Adj, weights, thresh, minSize)
    newAdj = Adj;
    newWeights = weights ;
    newThresh = thresh;
    [newWeights, newAdj, newThresh] = neuronCountMutation(newAdj, newWeights ,newThresh, minSize);
    newAdj = connectivityMutation(newAdj);
    newWeights = weightMutation(newWeights);
    newThresh = thresholdMutation(newThresh);
    end
    
    
    
    function [newWeights, newAdj, newThresh] = neuronCountMutation(Adj, weights,  thresh, minSize)
    
    if rand(1,1) > .5
        newThresh = [thresh ; rand(1,1)] ;
        newWeights = [[weights zeros(size(weights,1), 1)];zeros(1,size(weights,1)+1)];
        newAdj = [[Adj zeros(size(Adj,1), 1)];zeros(1,size(Adj,1)+1)];
    elseif size(Adj,1) >minSize 
        newThresh = thresh(1:size(thresh,1)-1, :);
        newWeights = weights(1:size(weights,1)-1,1:size(weights,2)-1);
        newAdj = Adj(1:size(Adj,1)-1,1:size(Adj,2)-1);
    else
        newThresh = thresh;
        newWeights = weights;
        newAdj = Adj;
    end
    
    end
    
    
    function newAdj = connectivityMutation(Adj)
    
    output = Adj;
    for i = 1:size(Adj,1)
        for c = 1:size(Adj,1)
        if rand(1,1) > .7 && i ~= c 
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
               output(i,c) = output(i,c) + rand(1,1) - .05;
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
   
    %utility functions
    
    function combined = combine(outputs, inputs)
    combined = outputs | inputs | [1  zeros(1, size(inputs,2)-1)];
    
    end
    
    
    
    
    
    

    
    
    
