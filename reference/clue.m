for i=[]
clear
format compact

data_names=['ProfPlum';'ColMustd';'Mr.Green';...
'MsPeacck';'MrsWhite';'MsScrlet';...
'Ballroom';'Cnsrvtry';'DiningRm';...
'Kitchen ';'Library ';'Study   ';...
'Cndlstck';'Knife   ';'LeadPipe';...
'Rope    ';'Revolver';'Wrench  '];



clc,n=input('How many players? ');

clc,disp('Enter your own name, and then clockwise');
for i=1:n
 player(i).name=input(['Enter name #' num2str(i) ': '], 's');
end

clc,disp('How many cards did each player get? ')
for i=1:n
 player(i).num_cards = input([player(i).name ': ']);
end

clc,disp('What cards did you get? ');
disp('#  Card')
for i=1:18
 disp([int2str(i) ' ' data_names(i,:)]);
end

disp('Enter your cards');
for i=1:player(1).num_cards
 temp_card = input('Enter number of card: ');
 player(1).card(i) = temp_card;
 holders(temp_card)=1;
 disp([player(1).name ' has ' data_names(temp_card,:)]);
end

disp('# Name')
for i=1:n
 disp([int2str(i) ' ' player(i).name]);
end
start_num=input('Which player is first? ');
j=start_num;
guess_num=1;

game_is_not_over = 1;
while(game_is_not_over)
 for i=1:n
  clc
  disp([' Player ' j ', ' player(j).name]);
  s = input('Suspect number: ');
  r = input('Room number: ');
  w = input('Weapon number: ');
  guess_num=guess_num+1;

  show=1;
  k=j+1;
  while(no_show)
   player(k).doesnthave(player(k).doesnthave_num+1)=s;
   player(k).doesnthave(player(k).doesnthave_num+2)=r;
   player(k).doesnthave(player(k).doesnthave_num+3)=w;
   player(k).doesnthave_num=player(k).doesnthave_num+3;

  end

  if j==1 %it's 'my' turn

  else %it's not 'my' turn
   %keep track of what other people guessed

   j=j+1;
   j=mod(j,n);
  end
 end
end

end

mu=1; pl=2; gr=3; pe=4; sc=5; wh=6; 
kn=7; ca=8; re=9; ro=10; pi=11; wr=12;
ha=13; lo=14; di=15; ki=16; ba=17; co=18; bi=19; li=20; st=21;
numCards=21;

numPlayers=6;

count = 1;

c{count}=logic;

for i=1:length(c),c{i},end

d=NaN(numCards,numPlayers+1)
player=2;
card=4;
d((player-1)*numCards+(card-1)+1)=true
d(card,setdiff([1:numPlayers+1],player))=false;
d

