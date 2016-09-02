function [ca,numknowncards,secret] = notinhand(ca,card,player,numcards,numknowncards,secret)
%makes given cell an 'X'
ca{card,player} = 'X';
cellplot(ca)
pause(.5)

%checks if all players have 'X's for a card
% if no one has it, it must be in the envelope
[m,n] = size(ca);
counter=0;
for i=1:n %count all the 'X's for a given card
    counter = counter + lookincell(ca{card,i},'X');
end
if (counter == n) %if number of 'X's == numplayers
    secret=[secret card]
end

%should also check if the number of possible cards match the number
% of unknown cards, if so, mark them all known
playerhas=0;
playerdoesnthave=0;
for i=1:m %count all the 'X's for a given card
    playerhas = playerhas + lookincell(ca{i,player},'O');
    playerdoesnthave = playerdoesnthave + lookincell(ca{i,player},'X');
end
if (m-playerhas-playerdoesnthave == numcards(player)-numknowncards(player))
    %if the number of possible cards == the number of unknown cards for
    %that player, set all those to 'O'
    for i=1:m %set all the 'O's
        if (~lookincell(ca{i,player},'O') && (~lookincell(ca{i,player},'X'))
            [ca,numknowncards] = inhand(ca,numcards,numknowncards,i,player);
        end
    end
end
