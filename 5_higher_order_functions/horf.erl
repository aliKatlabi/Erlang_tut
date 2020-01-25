-module(horf).
-compile([export_all,debug_info]).

%% it is important to be able to pass a function as an argument (will be bound to a viarable to be used) to another function

% Higher Order Function : the function that can accpet other functions as an argument (in the way explaind above)

% this behaviour is rooted in mathmatics ,mainly lambda calculus 

one() -> 1.
two() -> 2.

add(X,Y) -> X() + Y().

% add(..) will not accept atoms or numbers // will only accept functions in this way ...  add(fun horf:one/0, fun horf:two/0)

% this notation has to be added to pass a function  : 
% fun Module:Function/Arity [[ it tells the VM to use that specific function, and then bind it to a variable ]]


%% compile it c(horf). and try horf:add(fun horf:one/0, fun horf:two/0).

% this behavior helps to build abstract functions like map()


map(_,[])->[];
map(F,[H|T]) -> [F(H)|map(F,T)].

incr(X) -> X+1.
decr(X) -> X-1.


%% compile it c(horf). and try horf:map(fun horf:incr/1, [1,2,3,4,5]).









