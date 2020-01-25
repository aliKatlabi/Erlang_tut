-module(recursion).
-compile([debug_info,export_all]).

-export([]).


-spec fac(number()) -> number().
fac(N) when N==0-> 1;		%or fac(0)->1;
fac(N) when N>0 -> N*fac(N-1).

