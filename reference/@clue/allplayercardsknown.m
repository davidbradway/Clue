function [ca] = allplayercardsknown(ca,player)
%this function sets all non 'O' cards of one player to 'X'
[m,numrows] = size(ca);
for i=1:m
    if(~strcmp(char(ca{i,player}),'O'))
        [ca] = notinhand(ca,i,player,secret);
    end
end
