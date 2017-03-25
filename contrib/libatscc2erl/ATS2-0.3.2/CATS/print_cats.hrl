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
% beg of [print_cats.hrl]
%%%%%%
%%

%% ****** ****** %%
%%
%%fun%%
ats2erlpre_print_int(X) -> io:format("~B", [X]).
%%
%%fun%%
ats2erlpre_print_bool(X) ->
  ats2erlpre_print_string(if X->"true"; true->"false" end).
%%
%%fun%%
ats2erlpre_print_double(X) -> io:format("~f", [X]).
%%fun%%
ats2erlpre_print_string(X) -> io:format("~s", [X]).
%%
%%fun%%
ats2erlpre_print_ERLval(X) -> io:format("~p", [X]).
%%
%%fun%%
ats2erlpre_print_newline() -> io:format("~n", []).
%%
%% ****** ****** %%

%% end of [print_cats.hrl] %%
