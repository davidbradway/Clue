function [ca,numknowncards] = checkforlonenumbers(ca,numcards,numknowncards,card,player)
%this function loops through each number found in that cell
% and checks if any of the remaining numbers that column
% are lone numbers, if so they should be made "O"
[m,n] = size(ca);
string=ca{card,player};

for i=1:length(string) %for each number in that cell,
    matches = 0;
    has=0;
    for j=1:m %check each card in that player's hand
        if (j ~= card)
            if (lookincell(ca(m,player),string(i))
                matches = matches + 1;
                has = i;
            end
        end
    end
    if (matches == 1)
        [ca,numknowncards] = inhand(ca,numcards,numknowncards,i,player);
    end
end
ca{card,player}='X';
