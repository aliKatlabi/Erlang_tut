-module(recursion).
-compile([debug_info,export_all]).

-export([fac/1,len/1,tail_fac/1]).


fac(N) when N==0-> 1;		%or fac(0)->1;
fac(N) when N>0 -> N*fac(N-1).


% recursivly getting the length of list 
len([]) -> 0;
len([_|T]) -> 1 + len(T).


%% Tail Recurson TR 

% this is called tail recursion where you define the head and in the body t calls the tail (same function with [[extra]] parameter can be used as accumulator ).
% the accumulator parameter can be used for instante operatons (like adding 1 in len) instead of stacking recurisive values (like 1's) 

tail_fac(N) -> tail_fac(N,1).

tail_fac(0,Acc) -> Acc;
tail_fac(N,Acc) when N > 0 -> tail_fac(N-1,N*Acc).

%% the difference

% when it was N*fac(N-1) this is pushed to the stack each time fac(..) is called which is consuming more space
% in tail_fac(N-1,N*Acc) we have only two place in memory (the parameters) and in those places we change the values




% once the basic recursive function is found it becomes easy to find the TR which basically moving the operation into the parameters section

dupicalte(0,_)->
	[];
dupicalte(N,Term) when N>0 -> 
	[Term|dupicalte(N-1,Term)].
	
	
tail_duplicate(N,Term)->
	tail_duplicate(N,Term,[]).

tail_duplicate(0,_,List)->
	List;
tail_duplicate(N,Term,List) when N>0->
	tail_duplicate(N-1,Term,[Term|List]).



%% tail recurson || while loop

% it looks like a 	while (N>0){ 
%						 List = [Term|List] 
%			       		 N=N-1}



reverse([])->[];
reverse([H|T])->reverse(T)++[H].

tail_reverse(L)->tail_reverse(L,[]).

tail_reverse([],R)->R;
tail_reverse([H|T],R)->
	tail_reverse(T,[H|R]).

% Lists:reverse/1 is more efficient 


sublist(_,0) -> [];
sublist([],_) -> [];
sublist([H|T],N) when N > 0 -> [H|sublist(T,N-1)].


tail_sublist(L,N)->tail_sublist(L,[],N).

tail_sublist(_,Subl,0)->Subl;
tail_sublist([],Subl,_)->Subl;
tail_sublist([H|T],Subl,N) when N>0 ->tail_sublist(T,Subl++[H],N-1).



lenient_zip([],_) -> [];
lenient_zip(_,[]) -> [];
lenient_zip([X|Xs],[Y|Ys]) -> [{X,Y}|lenient_zip(Xs,Ys)].


tail_zip(L1,L2)->tail_zip(L1,L2,[]).

tail_zip([],[],Z)->Z;
tail_zip([],_,Z)->Z;
tail_zip(_,[],Z)->Z;
tail_zip([X|Tx],[Y|Ty],Z)->tail_zip(Tx,Ty,[{X,Y}|Z]).


%% tail-call optimisation (TCO) :  when the virtual machine sees a function calling itself in a tail position (the last expression to be evaluated in a function), it eliminates the current stack frame
%% Last Call Optimisation (LCO) :  last expression to be evaluated in a function body is another function call. When that happens, as with TCO, the Erlang VM avoids storing the stack frame.

% TCO is special ase of LCO
% always DO tail funtions


%% https://learnyousomeerlang.com/recursion
%% can be check HOW to Build a Tree .. But I got the point of tail recursion




