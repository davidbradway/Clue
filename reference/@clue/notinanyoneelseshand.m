function [ca] = notinanyoneelseshand(ca,card,player)
[m,n]=size(ca);
for i=1:n
 if i~=player %exclude player who has card
  %check every other cell in that row 'card'
  if(isempty(ca{card,i})) %if cell was blank make it a 'X'
   [ca] = notinhand(ca,card,i);
  else %there was at least one number, check if any of those are lone numbers
   [ca,numknowncards] = checkforlonenumbers(ca,numcards,numknowncards,card,i);
  end
 end
end
