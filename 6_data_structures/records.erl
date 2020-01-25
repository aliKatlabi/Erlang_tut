-module(records).
-compile([export_all,debug_info]).

% records are used for a small data structures , to access attribute by name

-record(idea ,{ id = 0,
				domain = "erl" ,
				craziness = typical, %% typical is default value
				details = []}). 	 %% [] also default 
				


% this function is not tidy at all bu t was a good training on warnngs like :
% head mismatch : where all clauses of function should have the same arity (number of arguments)
% [some] clause cannot match 


idea_gen(Id , Domain , Craziness , Details) when Details =/= nodetail, Craziness=/=nocraziness->
	#idea{id = Id , domain = Domain , craziness =Craziness , details = Details};

idea_gen(Id , Domain , Craziness ,nodetail )when Craziness=/=nocraziness->
	#idea{id = Id , domain = Domain , craziness =Craziness};
	
idea_gen(Id , Domain, nocraziness, nodetail )->
	#idea{id = Id , domain = Domain }
	.
	
% records:idea_gen(1,Erlang, veryCrazy , "how about naming it langErl").

% the OUTPUT : {idea,1,"erlang",very,"how about naming it langErl"} it is just a tuple !!?

%% what to do is making the shell know about this record by reading it from he module 
%% we use the command rr(records).

% #idea{id = 1,domain = "erlang",craziness = very,
      % details = "how about naming it langErl"}





%% let's do some EXTRACTING  .. two ways ... 
%% first one is using the '.'

% 26> NewIdea = #idea{id=2,domain="erl",details="just kidding"}.
% 27> NewIdea#idea.details.
% "just kidding"

% nested records 

% 9> BiggerIdea = #idea{details = #idea{details = "nested"}}.

% #idea{id = 0,domain = "erl",craziness = typical,
      % details = #idea{id = 0,domain = "erl",
                      % craziness = typical,
                      % details = "nested"}}


%% extracting from nested ... 
%%> BiggerIdea#idea.details#idea.details.


%% GOOD feature about records 
% it can be used in functons head for pattern matching , also in guards 


%% remember the mess above in idea_gen(..) function



idea_gen_2(#idea{id = Id , domain = Domain , craziness =super , details = Details})->
	#idea{id = Id , domain = Domain , craziness = super , details = Details};

idea_gen_2(#idea{id = Id , domain = Domain , craziness = high , details = Details })->
	#idea{id = Id , domain = Domain , craziness = high , details = Details};
	
idea_gen_2(#idea{details = Details})->
	#idea{details = Details}
	.


-record(user , {id,name,group,age}).



admin_panel(#user{name=Name, group=admin}) ->
	Name ++ " is allowed!";
admin_panel(#user{name=Name}) ->
	Name ++ " is not allowed".
 

%% can extend user without problem

adult_section(U = #user{}) when U#user.age >= 18 ->
	%% Show stuff that can't be written in such a text
	allowed;
adult_section(_) ->
	%% redirect to sesame street site
	forbidden.


% updating an existing record 

update_idea(Idea)->
	Details = Idea#idea.details,
	NewIdea = Idea#idea{details = ["updated details : "|Details]},
	{updated, NewIdea}.
	


% SHARING RECORDS acrose different modules 

%% is done with the help of header files 
%% - by creating header file "records.hrl"
%% - writing the record in it 
%% - then it can be included in other modules writing -include("records.hrl")


-include("records.hrl").


fromOutside()-> 
	#outsider{name = "sharable"}.
	











