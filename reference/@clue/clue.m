function [ca,n,playernames,numcards,numknowncards] = clue()
%one time stuff at game start...
n=input('How many players: ');
playernames=cell(1,n);
numcards=zeros(1,n);

for i=1:n  %get player names and numbers of cards
 disp(['Player ' num2str(i) ': '])
 playernames{i}=input('Enter name: ','s');
 numcards(i)=input('Enter numcards dealt: ');
end

%input your player number
me=input('input your player number: ');

ca = cell(21,n);
cardnames={'Ballroom';'Billiard Room';'Conservatory';'Dining Room';...
           'Hall';'Kitchen';'Library';'Lounge';'Study';'Candlestick';...
           'Knife';'Pipe';'Revolver';'Rope';'Wrench';'Mr. Green';...
           'Col. Mustard';'Ms. Peacock';'Prof. Plum';'Miss Scarlett';...
           'Mrs. White'};

numknowncards=zeros(1,n);

h=figure(1);
set(h,'Position',[61 39 156 889]);
cellplot(ca)
pause(.5)


numsandnames=[num2cell([1:21]') cardnames]
for i=1:numcards(me);
 j=input('Enter the number of a card in your hand: ');
 [ca,numknowncards] = inhand(ca,numcards,numknowncards,j,me);
end

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

%cellplot(ca)
