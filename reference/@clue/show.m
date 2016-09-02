function [ca,numknowncards,sequential] = show(ca,numcards,numknowncards,cards,player,sequential)
%inputs: ca is cell array
%        numcards is needed for 'inhand' function
%        numknowncards is needed for 'inhand' function
%        cards is array of three card incides guessed
%        player is player index
%        sequential is counter - show index
%player showed one of the three cards to another person
numberpossible = 0;
for i=1:length(cards)
    if(lookincell(ca{cards(i),player},'O')) %check each cell for 'O's 
        %if we already know the 'show'er has one of those cards,
        % then we don't learn anything new here...
        return
    elseif(~lookincell(ca{cards(i),player},'X')) %if not 'X', then it is possible
        numberpossible = numberpossible+1;
    end
end
%if did not return, then no 'O's
for i=1:length(cards)
    if(~lookincell(ca{cards(i),player},'X')) %not 'X's
        if(numberpossible==1) %if only 1 possible, mark it X
            [ca,numknowncards] = inhand(ca,numcards,numknowncards,cards(i),player);
        else %enter sequential number
            [ca] = appendchartocell(ca,sequential);
        end
    end
end
sequential = sequential + 1;
