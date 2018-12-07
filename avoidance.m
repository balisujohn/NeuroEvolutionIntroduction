


boardSize = 7;

[Adj,W,thresh] = learnAvoidance(boardSize);
demo(Adj,W,thresh,boardSize)

function demo(Adj,W,thresh,boardSize)
 [playerPos, hunterPos, playerDirection] = initMicroWorld(boardSize);
output = zeros(1,8);
   while 1
       
        hunterPos = advanceHunter(playerPos, hunterPos);
        damage = 0;
        if isequal(hunterPos, playerPos)
        damage = 1;
        end
        distance = distanceToWallOrHunter(playerPos,hunterPos,playerDirection,boardSize)
        if abs(distance) > 7
            distance = (distance / abs(distance)) * 7;
        end
      
        inputData = [1 damage (dec2bin(distance) - '0')] % matlab is pretty cool
        input = NE.combine(output, inputData);
        
      
               output = NE.advance(Adj,W, input, thresh)';
               
       
        
        decision = output(1,6:8)
        [playerPos, playerDirection] = movePlayer(playerPos,playerDirection,boardSize,decision);
         
        visualizeBoard(playerPos, playerDirection, hunterPos, boardSize)
        pause(.5)

   end
end

function [Adj, W, thresh] = learnAvoidance(boardSize)
    
    [Adj, W, thresh] = NE.randTopology(8);
    bestScore = 0;
    %counter = 0
    while bestScore < 100
       % counter = counter + 1
        
        [mAdj,mW,mThresh] = NE.mutate(Adj,W,thresh,8);
       
             
       
        score = evaluateAvoidance(mAdj, mW, mThresh,boardSize);
        
        if score > bestScore
        Adj = mAdj;
        W = mW;
        thresh = mThresh;
        bestScore = score
        end
    
    end
    
    
    
    
end


function visualizeBoard(playerPos, playerDirection, hunterPos, boardSize)
directions = ['>','v','<','^'];
display = zeros(boardSize, boardSize);
x = hunterPos(1)
y = hunterPos(2)
display(hunterPos(1), hunterPos(2)) = 1;
display(playerPos(1),playerPos(2)) = playerDirection
end

function [playerPos, hunterPos, playerDirection] = initMicroWorld(boardSize)
playerPos = randi([1,boardSize],2,1);
hunterPos = randi([1,boardSize],2,1);
playerDirection = randi([1,4]);
end

function newHunterPos = advanceHunter(playerPos, hunterPos)
newHunterPos = hunterPos;
if rand() > .8
    travelDirection = playerPos - hunterPos;
    
        if abs(abs(travelDirection(1)) > abs(travelDirection(2)) && travelDirection(1))
            assert(travelDirection(1)~=0)
            newHunterPos(1) = hunterPos(1) + travelDirection(1) / abs(travelDirection(1));
        elseif(travelDirection(2)~= 0)
            newHunterPos(2) = hunterPos(2) + travelDirection(2) / abs(travelDirection(2));
            assert(travelDirection(2)~=0)
        end
    
end
end

function [newPlayerPos,newPlayerDirection] = movePlayer(playerPosition,playerDirection, boardSize, decision)
assert(playerDirection > 0 && playerDirection < 5)
moving = 0;
newPlayerPos = playerPosition;
newPlayerDirection = playerDirection;
moveDirection = 0;
if isequal(decision,[1 1 1])
    moveDirection = playerDirection;
    moving = 1;
elseif isequal(decision,[1 1 0])
    moveDirection = mod((playerDirection),4)+1;
    moving = 1;
elseif isequal(decision,[1 0 1])
    moveDirection = mod((playerDirection+1),4)+1;
    moving = 1;

elseif isequal(decision,[1 0 0])
        moveDirection = mod((playerDirection+2),4)+1;
        moving = 1;      
elseif isequal(decision,[0 1 1])
    newPlayerDirection = mod((playerDirection),4)+1;
elseif isequal(decision,[0 1 0])
    newPlayerDirection = mod((playerDirection+2),4)+1;
end
assert((moveDirection >0 && moveDirection < 5)||moving == 0)
if moving == 1 
    if moveDirection == 1 % right
        if playerPosition(2) < boardSize 
            newPlayerPos(2) = playerPosition(2) +  1;
        end
    elseif moveDirection ==2 %down
                if playerPosition(1) < boardSize 
                    newPlayerPos(1) = playerPosition(1) +  1;
                end

    elseif moveDirection == 3 %left
                if playerPosition(2) >1 
                    newPlayerPos(2) = playerPosition(2) - 1;
                end

    elseif moveDirection == 4 %up
        if playerPosition(1) > 1
            newPlayerPos(1) = playerPosition(1) - 1;
        end
    end


end


end

function distance =  distanceToWallOrHunter(playerPos, hunterPos, playerDirection,boardSize)
if playerDirection == 1 % right
    if playerPos(1) == hunterPos(1) && hunterPos(2) >= playerPos(2)
        distance = hunterPos(2) - playerPos(2);
    else
        distance = (1 + boardSize) - playerPos(2);
    end
        
    elseif playerDirection == 2 % down
    if playerPos(2) == hunterPos(2) && hunterPos(1) >= playerPos(1)
        distance = hunterPos(1) - playerPos(1);
    else
       distance = (1+boardSize) - playerPos(1);
    end
       
elseif playerDirection == 3 % left
    if playerPos(1) == hunterPos(1) && hunterPos(2) <= playerPos(2)
        distance = playerPos(2)-hunterPos(2);
    else
        distance = playerPos(2);
    end
        
        
else  % up
    
      if playerPos(2) == hunterPos(2) && hunterPos(1) <= playerPos(1)
        distance = playerPos(1) - hunterPos(1);
    else
        distance = playerPos(1);
      end
    
end

end

function score = evaluateAvoidance(Adj, W, thresh,boardSize)
[playerPos, hunterPos, playerDirection] = initMicroWorld(boardSize);
maxTime = 1000.0;
trials = 100.0;
score = 0.0;
for i = 1:trials
    output = zeros(1,8);

    health = 10;
    time = 0;
    while (time < maxTime) && (health > 0)
        time = time + 1;
        score = score +1;
        hunterPos = advanceHunter(playerPos, hunterPos);
        damage = 0;
        if isequal(hunterPos, playerPos)
        damage = 1;
        health = health - 1;
        end
        distance = distanceToWallOrHunter(playerPos,hunterPos,playerDirection,boardSize);
        if abs(distance) > 7
            distance = (distance / abs(distance)) * 7;
        end
        
%          damage = damage
%          t0 = (dec2bin(distance))
%          t1 = ((dec2bin(distance)) - '0')
%          t2 = zeros(1,3)
%         
        inputData = [1 damage (dec2bin(distance) - '0')]; % matlab is pretty cool
        input = NE.combine(output, inputData);
        
       % for c = 1:5
         output = NE.advance(Adj,W, input, thresh)';
%      %          output = output;
%                input = input;
       %        input = NE.combine( output, inputData);
    %    end
        
        decision = output(1,6:8);
       [playerPos, playerDirection] = movePlayer(playerPos,playerDirection,boardSize,decision);
        
        
    end
end
    score = ((score /(trials * maxTime)) * 100.0)/.95;


end

