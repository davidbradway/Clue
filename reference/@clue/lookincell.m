function [D] = lookincell(ca,pattern)
%returns 1's whereever the string was found
D = ~isempty(strfind(char(ca),pattern));
