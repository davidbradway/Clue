function [ca,n,playernames,numcards,numknowncards] = clue()
% %one time stuff at game start...
% n=input('How many players: ');
% playernames=cell(1,n);
% numcards=zeros(1,n);
% 
% for i=1:n  %get player names and numbers of cards
%  disp(['Player ' num2str(i) ': '])
%  playernames{i}=input('Enter name: ','s');
%  numcards(i)=input('Enter numcards dealt: ');
% end
% 
% %input your player number
% me=input('input your player number: ');
% 
% ca = cell(21,n);
% cardnames={'Ballroom';'Billiard Room';'Conservatory';'Dining Room';...
%            'Hall';'Kitchen';'Library';'Lounge';'Study';'Candlestick';...
%            'Knife';'Pipe';'Revolver';'Rope';'Wrench';'Mr. Green';...
%            'Col. Mustard';'Ms. Peacock';'Prof. Plum';'Miss Scarlett';...
%            'Mrs. White'};
% 
% numknowncards=zeros(1,n);
% 
% h=figure(1);
% set(h,'Position',[61 39 156 889]);
% cellplot(ca)
% pause(.5)
% 
% 
% numsandnames=[num2cell([1:21]') cardnames]
% for i=1:numcards(me);
%  j=input('Enter the number of a card in your hand: ');
%  [ca,numknowncards] = inhand(ca,numcards,numknowncards,j,me);
% end

load cluedata.mat

sequential=1;

clc
for i=1:n
    %show player names
    disp([num2str(i) ': ' playernames{i}])
end
j = input('Enter number of guesser, or 99 to quit: ');

while(j~=99)
    numsandnames
    for i=1:3;
        k(i)=input('Enter the number of a card guessed: ');
    end
    
    for i=0:n-2
        counter=mod(j+i,n)+1;
        disp(['Did player ' num2str(counter) ', ' char(playernames{counter}) ', have a card?'])       
        if(input('Enter 1 if yes: ')==1)
            %player has one of those three cards
            [ca,numknowncards,sequential] = show(ca,numcards,numknowncards,k,counter,sequential);
            %enter sequential number into those cells
            break
        else %player did not have any of those three cards
            %mark the three cards as 'X'
            for card=1:3
                %keyboard
                [ca,numknowncards,secret] = notinhand(ca,k(card),counter,numcards,numknowncards,secret);
            end
        end
    end
    clc
    for i=1:n
        %show player names
        disp([num2str(i) ': ' playernames{i}])
    end
    j = input('Enter number of guesser, or 99 to quit: ');
end

save cluedata.mat

%cellplot(ca)

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

function [ca] = allplayercardsknown(ca,player)
%this function sets all non 'O' cards of one player to 'X'
[m,numrows] = size(ca);
for i=1:m
    if(~strcmp(char(ca{i,player}),'O'))
        [ca] = notinhand(ca,i,player,secret);
    end
end

function [D] = lookincell(ca,pattern)
%returns 1's whereever the string was found
D = ~isempty(strfind(char(ca),pattern));

function [ca] = appendchartocell(ca,number)
%To append a number to the end of a cell array string
 ca{1,1}=[ca{1,1} num2char(number)]
 cellplot(ca)
 pause(.5)
