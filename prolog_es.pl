begin :-
	writeln('Welcome to the ES about DOTA heroes!'),
	writeln('I am going to ask questions about DOTA hero features.'),
	writeln('Please answer "yes." or "no.".'),
	writeln('Ready?'),
	read(Response),
	evaluateResponse(Response),
	endingProcedure.
	
endingProcedure :-
	retractall(stat_fact),
	retractall(stat_fact(_)),
	retractall(stat_negative_fact(_)),
	retractall(attack_type_fact),
	retractall(attack_type_fact(_)),
	retractall(attack_type_negative_fact(_)),
	retractall(primary_role_fact),
	retractall(primary_role_fact(_)),
	retractall(primary_role_negative_fact(_)),
	retractall(secondary_role_fact),
	retractall(secondary_role_fact(_)),
	retractall(secondary_role_negative_fact(_)),
	writeln('To try again, just type "begin.".').
	
evaluateResponse(Response) :-
	( Response == yes ->
		writeln('========================================'),
		writeln('Beginning Query!'),
		writeln('========================================'),
		startQuery;
	  Response == no ->
		writeln('Bye!');
		writeln('Your response has to be either "yes." or "no.".'),
			read(RetryResponse),
			evaluateResponse(RetryResponse)
	).
	
startQuery :-
	( hero(Hero) ->
		writeln('========================================'),
		format('~w~w.\n', ['I think your hero is ', Hero]),
		userFeedback;
		writeln('Hmm, I could not figure this one out...')
	).	
	
userFeedback :-
	writeln('Did I get it right? (Answer with "yes." or "no.")'),
	read(Response),
	writeln('========================================'),
	( Response == yes ->
		writeln('Not a surprise, I am always right.'),
		writeln('========================================');
	  Response == no ->
		writeln('I suppose I need more information about DOTA heroes.'),
		writeln('========================================');
		writeln('Your response has to be "yes." or "no.".'),
		userFeedback
	).

:- dynamic stat_fact/0.	
:- dynamic stat_fact/1.
:- dynamic stat_negative_fact/1.	
:- dynamic attack_type_fact/0.
:- dynamic attack_type_fact/1.
:- dynamic attack_type_negative_fact/1.
:- dynamic primary_role_fact/0.
:- dynamic primary_role_fact/1.
:- dynamic primary_role_negative_fact/1.
:- dynamic secondary_role_fact/0.	
:- dynamic secondary_role_fact/1.
:- dynamic secondary_role_negative_fact/1.
	
primary_stat(Question) :-
	( stat_fact(Question) ->
		true;
		stat_negative_fact(Question) ->
			false;
			( stat_fact ->
				false;
				format('~w?~n', [Question]),
				Answer = read(yes),
				( Answer ->
					assert(stat_fact(Question)),
					assert(stat_fact);
					assert(stat_negative_fact(Question)),
					false
				)	
			)
	).
	
attack_type(Question) :-
	( attack_type_fact(Question) ->
		true;
		attack_type_negative_fact(Question) ->
			false;
				( attack_type_fact ->
					false;
					format('~w?~n', [Question]),
					Answer = read(yes),
					( Answer ->
						assert(attack_type_fact(Question)),
						assert(attack_type_fact);
						assert(attack_type_negative_fact(Question)),
						false
					)
				)	
	).
	
primary_role(Question) :-
	( primary_role_fact(Question) ->
		true;
		primary_role_negative_fact(Question) ->
			false;
			( primary_role_fact ->
				false;
				format('~w?~n', [Question]),
				Answer = read(yes),
				( Answer ->
					assert(primary_role_fact(Question)), assert(primary_role_fact);
					assert(primary_role_negative_fact(Question)), false
				)
			)	
	).
	
secondary_role(Question) :-
	( secondary_role_fact(Question) ->
		true;
		secondary_role_negative_fact(Question) ->
			false;
			( secondary_role_fact ->
				false;
				format('~w?~n', [Question]),
				Answer = read(yes),
				( Answer ->
					assert(secondary_role_fact(Question)), assert(secondary_role_fact);
					assert(secondary_role_negative_fact(Question)), false
				)
			)	
	).
	
hero(sven) :- primary_stat('strength'), attack_type('melee'), primary_role('primary carry'), secondary_role('secondary disabler').
hero(earthshaker) :- primary_stat('strength'), attack_type('melee'), primary_role('primary support'), secondary_role('secondary initiator').
hero(io) :- primary_stat('strength'), attack_type('range'), primary_role('primary support'), secondary_role('secondary escape').
hero(huskar) :- primary_stat('strength'), attack_type('range'), primary_role('primary carry'), secondary_role('secondary durable').
hero(magnus) :- primary_stat('strength'), attack_type('melee'), primary_role('primary initiator'), secondary_role('secondary disabler').
hero(juggernaut) :- primary_stat('agility'), attack_type('melee'), primary_role('primary carry'), secondary_role('secondary pusher').
hero(nyx_assassin) :- primary_stat('agility'), attack_type('melee'), primary_role('primary disabler'), secondary_role('secondary nuker').
hero(venomancer) :- primary_stat('agility'), attack_type('range'), primary_role('primary support'), secondary_role('secondary nuker').
hero(sniper) :- primary_stat('agility'), attack_type('range'), primary_role('primary carry'), secondary_role('secondary nuker').
hero(riki) :- primary_stat('agility'), attack_type('melee'), primary_role('primary carry'), secondary_role('secondary escape').
hero(lich) :- primary_stat('intelligence'), attack_type('range'), primary_role('primary support'), secondary_role('secondary nuker').
hero(necrophos) :- primary_stat('intelligence'), attack_type('range'), primary_role('primary carry'), secondary_role('secondary nuker').
hero(ogre_magi) :- primary_stat('intelligence'), attack_type('melee'), primary_role('primary support'), secondary_role('secondary nuker').
hero(puck) :- primary_stat('intelligence'), attack_type('range'), primary_role('primary initiator'), secondary_role('secondary disabler').
hero(enigma) :- primary_stat('intelligence'), attack_type('range'), primary_role('primary disabler'), secondary_role('secondary jungler').
