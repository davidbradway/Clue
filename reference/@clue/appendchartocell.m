function [ca] = appendchartocell(ca,number)
%To append a number to the end of a cell array string
 ca{1,1}=[ca{1,1} num2char(number)]
 cellplot(ca)
 pause(.5)
