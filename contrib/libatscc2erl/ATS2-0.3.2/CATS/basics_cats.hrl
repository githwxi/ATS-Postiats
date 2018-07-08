%%
%%%%%%
%
% HX-2015-07:
% for Erlang code
% translated from ATS
%
%%%%%%
%%

%%
%%%%%%
% beg of [basics_cats.hrl]
%%%%%%
%%

%% ****** ****** %%

-define(ATSCKiseqz(X), X =:= 0).
-define(ATSCKisneqz(X), X =/= 0).

%% ****** ****** %%

-define(ATSCKpat_int(X, I), X =:= I).
-define(ATSCKpat_bool(X, B), X =:= B).

%% ****** ****** %%

-define(ATSCKpat_string(X, S), X =:= S).

%% ****** ****** %%

-define(ATSCKpat_con0(X, TAG), X =:= TAG).
-define(ATSCKpat_con1(X, TAG), (is_tuple(X) andalso (element(1, X) =:= TAG))).

%% ****** ****** %%

-define(ATSCKptrisnull(X), X =:= atscc2erl_null).
-define(ATSCKptriscons(X), X =/= atscc2erl_null).

%% ****** ****** %%

-define(ATSSELcon(P, I), element(I+1, P)).
-define(ATSSELboxrec(P, I), element(I+1, P)).

%% ****** ****** %%

-define(ATSfunclo_fun(F), (F)).
-define(ATSfunclo_clo(F), (element(1, F))).

%% ****** ****** %%
%%
-define(ATSINSmove_void(), atscc2erl_void).
%%
%% ****** ****** %%
%%
%%fun%%
atscc2erl_caseof_deadcode
  (_FILE, _LINE) -> exit('atscc2erl_caseof_deadcode').
%%
%% ****** ****** %%

-define(ATSINScaseof_fail(ERRMSG), exit({'atscc2erl_caseof_fail', ERRMSG})).

%% ****** ****** %%

%%fun%%
ats2erlpre_string2atom(S) -> list_to_atom(S).
%%fun%%
ats2erlpre_atom2string(S) -> atom_to_list(S).

%% ****** ****** %%
%%
%%fun%%
atspre_lazy2cloref(Arg) -> exit('atspre_lazy2cloref').
%%
%% ****** ****** %%

%%
%% HX-2015-10-25:
%% Commenting out
%% implementation in basics.dats
%%
ats2erlpre_cloref0_app
  (F) -> ?ATSfunclo_clo(F)(F).
ats2erlpre_cloref1_app
  (F, X1) -> ?ATSfunclo_clo(F)(F, X1).
ats2erlpre_cloref2_app
  (F, X1, X2) -> ?ATSfunclo_clo(F)(F, X1, X2).
ats2erlpre_cloref3_app
  (F, X1, X2, X3) -> ?ATSfunclo_clo(F)(F, X1, X2, X3).
%%

%% ****** ****** %%
%%
ats2erlpre_cloref2fun0(F) ->
  fun() -> ats2erlpre_cloref0_app(F) end.
ats2erlpre_cloref2fun1(F) ->
  fun(X1) -> ats2erlpre_cloref1_app(F, X1) end.
ats2erlpre_cloref2fun2(F) ->
  fun(X1, X2) -> ats2erlpre_cloref2_app(F, X1, X2) end.
ats2erlpre_cloref2fun3(F) ->
  fun(X1, X2, X3) -> ats2erlpre_cloref3_app(F, X1, X2, X3) end.
%%
%% ****** ****** %%

%% end of [basics_cats.hrl] %%
