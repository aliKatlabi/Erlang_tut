-module(func).
-compile([export_all,debug_info]).

-export([identify/2,same/2]).

%% one way to express "if else" in Erlang 
%% instead the workflow blocks are dfined using what's called "function clauses"
%% function clause are seperated using ';'
%%
%%  


identify(male,Name)->
	io:format("He is ~s~n",[Name]);
identify(female,Name)->
	io:format("She is ~s~n",[Name]);
identify(_,Name)->
	io:format("~s~n",[Name]).


% patern matching 

head([H|_])->
	H.
% a function to return the head of a list
% as you remember the las expression is the return value 

second([_,X|_])-> X. % you guessed it!


%% concentrating on more Pattern matching 



same(X,X)->
	true;
same(_,_)->
	false.

% same(4,4) bind 4 to X (not X cannot be bound again) 
%			try to bind the other 4 to X but it' bound so it compares it (as we know we can bind again with equal value)
%			so X can take the other 4 => first block executed returning true.
%			otherwise if it's othe value than 4 it will go to the other block


valid_time({Date = {Y,M,D}, Time = {H,Min,S}}) ->
io:format("The Date tuple (~p) says today is: ~p/~p/~p,~n",[Date,Y,M,D]),
io:format("The time tuple (~p) indicates: ~p:~p:~p.~n", [Time,H,Min,S]);
valid_time(_) ->
io:format("Stop feeding me wrong data!~n").


% it is possipe to use = in the function head 
% it helps to refer to the whole tuple{Y,M,D} not just Y M D themselves..

%% note 
%% we can put anything in valid_time({{atom,"txt",123},{any,any,any})
%% and it is not restricted with a range 
%% to solve this we use (((Guards)))

%% Guards ...............

% Guards are additional clauses that can go in a function's head 
% to make pattern matching more expressive


% Guards are basically mixed Conditons after function head using (when keyword)
% f(Z) when Z<10;Z>100->body.
% ';' is used as orelse ',' used as andelse
% ';' and ',' they catch exceptions (orelse , andelse they don't)

right_age(X) when X >= 16, X =< 104 ->
	true;
right_age(_) ->
	false.

%% What the if  ...............

% same as Guard's sytax But outside of functions clauses heads 


% in erlang everything must return somthing 

heh_fine() ->
	if true-> works end  %return true 
	,				% andelse 
	if true-> works end  %return true
	,				% andelse
	if false->fails 	%return false => evaluate to false always 
	end.

% heh_fine() give a warning that the guard evaluates to 'false'
% 
%% if end in erlang is not like other languages.
%% if the conditon in 'if' is false the guard will not succed 
%% we need to force the true on it (which means the 'else' or 'default' in switch)

% in ordinary cases conditon might fail 
%		-> also the guard will if there is not other branch(true branch)



oh_god(N) ->
if N =:= 2 -> might_succeed;
true -> always_does  %% this is Erlang's if's 'else!'
end.

%% oh_god(4) will return exception if true pranch in not there 


%% in case of ...............

% case..of is like the the whole function head 

append_set(X,[])->
	[X];
append_set(X,Set)->
	case lists:member(X,Set) of 
		true -> Set;
		false -> [X|Set]
	end.

% we said case .. of is like a Head function So we can put guards(logic expression) on it 

% case .. of pattern Guards ->... end.

beach(Temperature) ->
	case Temperature of
		{celsius, N} when N >= 20, N =< 45 ->
			'favorable';
		{kelvin, N} when N >= 293, N =< 318 ->
			'scientifically favorable';
		{fahrenheit, N} when N >= 68, N =< 113 ->
			'favorable in the US';
		_ ->
			'avoid beach'
end.


















