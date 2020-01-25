-module(anonymous_f).
-compile([export_all,debug_info]).


%% anonymous functions: special kind of inline function , which are like any function except they don't have a nmae ,thus they can't be recursive

% syntax 

% fun(Args1) ->
% Expression1, Exp2, ..., ExpN;
% (Args2) ->
% Expression1, Exp2, ..., ExpN;
% (Args3) ->
% Expression1, Exp2, ..., ExpN
% end


% very beautiful is the ability to make abstractions on very low level using anonymous f


% in shell   : 

% horf:map(func(X)->X+1 end,[2,4,6]).  

% 11> PrepareAlarm = fun(Room) ->
% 11>                     io:format("Alarm set in ~s.~n",[Room]),
% 11>                     fun() -> io:format("Alarm tripped in ~s! Call Batman!~n",[Room]) end
% 11>                   end.

%% Clouser : in the second anonymous func() the value of [Room] is taken from the parent function 
%% the clouser concept is based on the scope of function


% in plus2()  
% A and B  - variables are bound to the plus2 scope 
%		   - can be refered anywhere inside plus2 -- even in an anonymous function

plus2(X)->
	A = 1,
	B = X + 1,
	F = fun()-> B + A end,  % F variable (which becomes a function) will inherit the scope of plus2(X)
	F().					% so F can access A & B
	

% LIFE RULE : parents cannot inherit from children

%% in this version of plus2 
%% variable C is bound to the scope of function F and the parent function cannot access it 
%% so the expression C. will not compile properly 
% plus2(X)->
	% B = X + 1,
	% F = fun()-> C = B + 1 end,
	% F(),
	% C.





%% Another good feature : is that the inherited scope in the anonymous function can be carried outside the parent functions 

a() -> 
	Secrte = "pony",
	fun() -> Secrte end .
	
b(F) -> "functions a() password is "++F().




% TRAP 
%% trying to redefine the scope of variable A , [using = compares 2 with A (bound to 1)]
% base() ->
% A = 1,
% (fun() -> A = 2 end)().

%% shadowing : describe the act of defining a new variable that has the same name as one that was in the parent scope

% compiling here will give "Warning: variable 'A' shadowed in 'fun'"
base() ->
A = 1,
(fun(A) -> A = 2 end)(2).


% Update: Starting with version 17.0

%% we said before the anonymous function cannot call them selves (because there is no name) !!

% BUT : in the update "INTERNAL NAME" is used , anonymous f. can be named but the name is visible only within the function scope
% MAIN Advantage : is that now we can have anonymous recursive functions

 

f() ->
	fun()->
	A = "Loop" , fun Loop() -> io:format("This is a ~s!" ,A++"p"), Loop() end
	
	end.

	
	
% % 18> f(PrepareAlarm), f(AlarmReady).
% % ok
% % 19> PrepareAlarm = fun(Room) ->
% % 19>    io:format("Alarm set in ~s.~n",[Room]),
% % 19>     fun Loop() ->
% % 19>        io:format("Alarm tripped in ~s! Call Batman!~n",[Room]),
% % 19>        timer:sleep(500),
% % 19>         Loop()
% % 19>     end
% % 19> end.

% The Loop variable refers to the anonymous function itself, 
% and within that scope, will be usable as any other similar variable pointing to an anonymous function. 
% This should generally make a lot of operations in the shell a lot less painful moving on forward.





















