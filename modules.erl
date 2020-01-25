% -ModuleAttribut(...).

-module(modules).%this module name
-export([sq/1,liconc/2,func3/3,print/1]). %Module Interface :functions can be called from outside ([func/arity(number of ards),func2/2,...])


-compile([debug_info,export_all]). % same as compiling fro shell with these flages
				   % like c(useless,[debug_info,export_all]).
%% Erlang Macros
%% defined as module Attribute
%% -define(MACRO , some_value)

-define(sub(A,B) , A-B).

-author("Ali Katlabi").


%% function : Name(Args)-> Body.
%% Name has to be an tom
%% Body is one more erlang expressons(sxpr followed by . and space) seperated by commas
%% RETURN is the last logical expression in the function (automatically returned)

sq(A)->
	A*A.

liconc(A,B)->
	C = A++B,
	[ok|C].

func3(A,B,C)->
	?sub(A,B)*C.

print(A)->
	io:format(A).

%% calling function from forgein module M:F(A)
%% OR we can impoer io like .. ( import(io , [format/1])

%  Compiling 

%using 
% $ erlc flags file.erl  in command line
% compile:file(file.erl)  inside the module OR in shell [will appear after compiling with c()]
% c(file)  in shell only

