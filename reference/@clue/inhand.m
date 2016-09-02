function [ca,numknowncards] = inhand(ca,numcards,numknowncards,card,player)
 %first check if that cell has any other numbers in it.
  if(~isempty(ca{card,player})) %if cell did, we want to erase those numbers
   [ca] = erasenumbers(ca,card,player);
  end
 %either way, place a 'O'
 ca{card,player}='O';
 cellplot(ca)
 pause(.5)
 numknowncards(player)=numknowncards(player)+1;
 if(numcards(player) == numknowncards(player))
   [ca] = allplayercardsknown(ca,player);  %all other cards are 'X'
 end
 [ca] = notinanyoneelseshand(ca,card,player); %if this player has it, the others don't
