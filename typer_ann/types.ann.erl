-module(types).
-export([and_/2]).

-compile([debug_info,export_all]).
% BIF : built-in functions

% Erlang is dynamicaly typed : varialbe can match with and be anything {X,Y} can be {atom,123} or {"string",<<"binary stuff">>}
% Erlang is strongly typed there are no implicit type conversions between terms 6 = 1+ "5" is bad argument

%% type conversions 
% is done by 'casting' type to another using BIF form (erlang:) module




%% To Guard a Data Type (checking the type of argument using guards)
%  using the erlang: module (BIF) funtions like "is_'type'(..)"




-spec and_(_,_) -> boolean().
and_(false,_)->false;
and_(_,false)->false;
and_(true,true)->true.

% under success typing the inferred type of the function would be and(_,_) -> bool()

%% for success typing : typer app can be used 

%using ((typer.exe)) on this module will induce that and_ is and_(_,_)->boolean().

