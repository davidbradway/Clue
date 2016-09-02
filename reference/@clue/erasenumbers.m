function [ca] = erasenumbers(ca,card,player)
%this function loops through each number found in that cell
% and erases all matching numbers in cells of that column
[m,n] = size(ca);
string=ca{card,player};

for i=1:length(string) %for each number in that cell,
    for j=1:m %check each card in that player's hand
        if (lookincell(ca(m,player),string(i))
            %remove that character from that cell
            [token, remain] = strtok(ca(m,player),string(i));
            if (length(remain) > 1)
                ca{m,player}=[token remain(2:end)];
            else
                ca{m,player}=token;
            end
        end
    end
end
