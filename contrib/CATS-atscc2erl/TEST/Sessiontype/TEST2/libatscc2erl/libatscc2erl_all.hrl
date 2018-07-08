%%
%% Time of Generation:
%% Sun Jan 15 16:30:49 EST 2017
%%

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
% beg of [integer_cats.hrl]
%%%%%%
%%

%% ****** ****** %%
%%
%% HX: for signed integers
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_abs_int0(X) -> abs(X).
%%fun%%
ats2erlpre_abs_int1(X) -> abs(X).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_neg_int0(X) -> ( -X ).
%%fun%%
ats2erlpre_neg_int1(X) -> ( -X ).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_succ_int0(X) -> (X + 1).
%%fun%%
ats2erlpre_pred_int0(X) -> (X - 1).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_succ_int1(X) -> (X + 1).
%%fun%%
ats2erlpre_pred_int1(X) -> (X - 1).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_half_int0(X) -> (X div 2).
%%fun%%
ats2erlpre_half_int1(X) -> (X div 2).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_add_int0_int0(X, Y) -> (X + Y).
%%fun%%
ats2erlpre_sub_int0_int0(X, Y) -> (X - Y).
%%fun%%
ats2erlpre_mul_int0_int0(X, Y) -> (X * Y).
%%fun%%
ats2erlpre_div_int0_int0(X, Y) -> (X div Y).
%%fun%%
ats2erlpre_mod_int0_int0(X, Y) -> (X rem Y).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_add_int1_int1(X, Y) -> (X + Y).
%%fun%%
ats2erlpre_sub_int1_int1(X, Y) -> (X - Y).
%%fun%%
ats2erlpre_mul_int1_int1(X, Y) -> (X * Y).
%%fun%%
ats2erlpre_div_int1_int1(X, Y) -> (X div Y).
%%fun%%
ats2erlpre_mod_int1_int1(X, Y) -> (X rem Y).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_lt_int0_int0(X, Y) -> (X < Y).
%%fun%%
ats2erlpre_lte_int0_int0(X, Y) -> (X =< Y).
%%fun%%
ats2erlpre_gt_int0_int0(X, Y) -> (X > Y).
%%fun%%
ats2erlpre_gte_int0_int0(X, Y) -> (X >= Y).
%%fun%%
ats2erlpre_eq_int0_int0(X, Y) -> (X =:= Y).
%%fun%%
ats2erlpre_neq_int0_int0(X, Y) -> (X =/= Y).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_compare_int0_int0
  (X, Y) ->
%{
  if X > Y -> 1; X < Y -> -1; true -> 0 end.
%}
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_lt_int1_int1(X, Y) -> (X < Y).
%%fun%%
ats2erlpre_lte_int1_int1(X, Y) -> (X =< Y).
%%fun%%
ats2erlpre_gt_int1_int1(X, Y) -> (X > Y).
%%fun%%
ats2erlpre_gte_int1_int1(X, Y) -> (X >= Y).
%%fun%%
ats2erlpre_eq_int1_int1(X, Y) -> (X =:= Y).
%%fun%%
ats2erlpre_neq_int1_int1(X, Y) -> (X =/= Y).
%%
%% ****** ****** %%

%% end of [integer_cats.hrl] %%
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
% beg of [bool_cats.hrl]
%%%%%%
%%

%% ****** ****** %%
%%
%%fun%%
ats2erlpre_neg_bool0(X) -> not(X).
%%fun%%
ats2erlpre_neg_bool1(X) -> not(X).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_eq_bool0_bool0(X, Y) -> (X =:= Y).
%%fun%%
ats2erlpre_neq_bool0_bool0(X, Y) -> (X =/= Y).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_eq_bool1_bool1(X, Y) -> (X =:= Y).
%%fun%%
ats2erlpre_neq_bool1_bool1(X, Y) -> (X =/= Y).
%%
%% ****** ****** %%

%% end of [bool_cats.js] %%
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
% beg of [float_cats.hrl]
%%%%%%
%%

%% ****** ****** %%
%%
%%fun%%
ats2erlpre_neg_double(X) -> ( -X ).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_succ_double(X) -> (X + 1).
%%fun%%
ats2erlpre_pred_double(X) -> (X - 1).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_add_double_double(X, Y) -> (X + Y).
%%fun%%
ats2erlpre_sub_double_double(X, Y) -> (X - Y).
%%fun%%
ats2erlpre_mul_double_double(X, Y) -> (X * Y).
%%fun%%
ats2erlpre_div_double_double(X, Y) -> (X / Y).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_lt_double_double(X, Y) -> (X < Y).
%%fun%%
ats2erlpre_lte_double_double(X, Y) -> (X =< Y).
%%fun%%
ats2erlpre_gt_double_double(X, Y) -> (X > Y).
%%fun%%
ats2erlpre_gte_double_double(X, Y) -> (X >= Y).
%%fun%%
ats2erlpre_eq_double_double(X, Y) -> (X =:= Y).
%%fun%%
ats2erlpre_neq_double_double(X, Y) -> (X =/= Y).
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_compare_double_double
  (X, Y) ->
%{
  if X > Y -> 1; X < Y -> -1; true -> 0 end.
%}
%%
%% ****** ****** %%

%% end of [float_cats.hrl] %%
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
% beg of [reference_cats.hrl]
%%%%%%
%%

%% ****** ****** %%
%%
%%fun%%
ats2erlpre_ref(X) ->
  spawn(
    ?MODULE, ats2erlpre_ref_server_proc, [X]
  ). %% spawn
%%fun%%
ats2erlpre_ref_make_elt(X) ->
  spawn(
    ?MODULE, ats2erlpre_ref_server_proc, [X]
  ). %% spawn
%%
ats2erlpre_ref_server_proc(X) ->
  receive
    {Client, get_elt} ->
      Client ! {self(), X}, ats2erlpre_ref_server_proc(X);
    {Client, set_elt, Y} ->
      Client ! {self(), atscc2erl_void}, ats2erlpre_ref_server_proc(Y);
    {Client, exch_elt, Y} ->
      Client ! {self(), X}, ats2erlpre_ref_server_proc(Y);
    {Client, takeout} ->
      Client ! {self(), X}, ats2erlpre_ref_server_proc2()
  end.
ats2erlpre_ref_server_proc2() ->
  receive
    {Client, addback, X} -> 
      Client ! {self(), atscc2erl_void}, ats2erlpre_ref_server_proc(X)
  end.
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_ref_get_elt(Server) ->
  Server ! {self(), get_elt}, receive {Server, Res} -> Res end.
%%fun%%
ats2erlpre_ref_set_elt(Server, Y) ->
  Server ! {self(), set_elt, Y}, receive {Server, Res} -> Res end.
%%fun%%
ats2erlpre_ref_exch_elt(Server, Y) ->
  Server ! {self(), exch_elt, Y}, receive {Server, Res} -> Res end.
%%
%%fun%%
ats2erlpre_ref_takeout(Server) ->
  Server ! {self(), takeout}, receive {Server, Res} -> Res end.
ats2erlpre_ref_addback(Server, Y) ->
  Server ! {self(), addback, Y}, receive {Server, Res} -> Res end.
%%
%% ****** ****** %%
%%
%% HX: linear references
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_ref_vt(X) ->
  spawn(
    ?MODULE, ats2erlpre_ref_vt_server_proc, [X]
  ). %% spawn
%%fun%%
ats2erlpre_ref_vt_make_elt(X) ->
  spawn(
    ?MODULE, ats2erlpre_ref_vt_server_proc, [X]
  ). %% spawn
%%
ats2erlpre_ref_vt_server_proc(X) ->
  receive
    {Client, get_elt} ->
      Client ! {self(), X}, ats2erlpre_ref_vt_server_proc(X);
    {Client, set_elt, Y} ->
      Client ! {self(), atscc2erl_void}, ats2erlpre_ref_vt_server_proc(Y);
    {Client, exch_elt, Y} ->
      Client ! {self(), Y}, ats2erlpre_ref_vt_server_proc(Y);
    {Client, takeout} ->
      Client ! {self(), X}, ats2erlpre_ref_vt_server_proc2();
    {Client, getfree_elt} -> Client ! {self(), X} %% Server exits here
  end.
ats2erlpre_ref_vt_server_proc2() ->
  receive
    {Client, addback, X} -> 
      Client ! {self(), atscc2erl_void}, ats2erlpre_ref_vt_server_proc(X)
  end.
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlpre_ref_vt_get_elt(Server) ->
  Server ! {self(), get_elt}, receive {Server, Res} -> Res end.
%%fun%%
ats2erlpre_ref_vt_set_elt(Server, Y) ->
  Server ! {self(), set_elt, Y}, receive {Server, Res} -> Res end.
%%fun%%
ats2erlpre_ref_vt_exch_elt(Server, Y) ->
  Server ! {self(), exch_elt, Y}, receive {Server, Res} -> Res end.
%%
ats2erlpre_ref_vt_getfree_elt(Server) ->
  Server ! {self(), getfree_elt}, receive {Server, Res} -> Res end.
%%
%%fun%%
ats2erlpre_ref_vt_takeout(Server) ->
  Server ! {self(), takeout}, receive {Server, Res} -> Res end.
ats2erlpre_ref_vt_addback(Server, Y) ->
  Server ! {self(), addback, Y}, receive {Server, Res} -> Res end.
%%
%% ****** ****** %%

%% end of [reference_cats.hrl] %%
%%
%%%%%%
%
% HX-2015-09:
% for Erlang code
% translated from ATS
%
%%%%%%
%%

%%
%%%%%%
% beg of [file_cats.hrl]
%%%%%%
%%

%% ****** ****** %%
%%fun%%
ats2erlibc_filename_all2string
  (X) ->
  case X of
    _ when is_list(X) -> X;
    _ when is_binary(X) -> binary:bin_to_list(X)
  end.
%%
%% ****** ****** %%

%%fun%%
ats2erlibc_file_print_filename(X) -> io:format("~p", [X]).
%%fun%%
ats2erlibc_file_print_filename_all(X) -> io:format("~p", [X]).

%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2get_cwd_0_opt
  () ->
  case file:get_cwd() of
    {ok, Filename} ->
      ats2erlpre_option_some(Filename)
    ; %% Some(Filename)
    {error, _Reason_} ->
      ats2erlpre_option_none() %% None((*void*))
  end.
%%fun%%
ats2erlibc_file_ats2get_cwd_1_opt
  (Drive) ->
  case file:get_cwd(Drive) of
    {ok, Filename} ->
      ats2erlpre_option_some(Filename)
    ; %% Some(Filename)
    {error, _Reason_} ->
      ats2erlpre_option_none() %% None((*void*))
  end.
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2del_dir_opt
  (Dir) ->
  case
  file:del_dir(Dir)
  of %% of-case
    ok -> true; {error, _Reason_} -> false
  end. %% end-case
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2list_dir_opt
  (Dir) ->
  case
  file:list_dir(Dir)
  of %% case
    {ok, Filenames} ->
      ats2erlpre_option_some(Filenames)
    ; %% Some(Filename)
    {error, _Reason_} ->
      ats2erlpre_option_none() %% None((*void*))
  end.
%%
%%fun%%
ats2erlibc_file_ats2list_dir_all_opt
  (Dir) ->
  case
  file:list_dir_all(Dir)
  of %% case
    {ok, Filenames} ->
      ats2erlpre_option_some(Filenames)
    ; %% Some(Filename)
    {error, _Reason_} ->
      ats2erlpre_option_none() %% None((*void*))
  end.
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2make_dir_opt
  (Dir) ->
  case
  file:make_dir(Dir)
  of %% of-case
    ok -> true; {error, _Reason_} -> false
  end. %% end-case
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2make_link_opt
  (Existing, New) ->
  case
  file:make_link(Existing, New)
  of %% of-case
    ok -> true; {error, _Reason_} -> false
  end. %% end-case
%%
%%fun%%
ats2erlibc_file_ats2make_symlink_opt
  (Existing, New) ->
  case
  file:make_symlink(Existing, New)
  of %% of-case
    ok -> true; {error, _Reason_} -> false
  end. %% end-case
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2read_file_opt
  (Filename) ->
  case
  file:read_file(Filename)
  of %% case
    {ok, Binary} ->
      ats2erlpre_option_some(Binary)
    ; %% Some(Filename)
    {error, _Reason_} ->
      ats2erlpre_option_none() %% None((*void*))
  end.
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2rename_opt
  (Src, Dst) ->
  case
  file:rename(Src, Dst)
  of %% of-case
    ok -> true; {error, _Reason_} -> false
  end. %% end-case
%%
%% ****** ****** %%
%%
%%fun%%
ats2erlibc_file_ats2set_cwd_opt
  (Dir) ->
  case
  file:set_cwd(Dir)
  of %% of-case
    ok -> true; {error, _Reason_} -> false
  end. %% end-case
%%
%% ****** ****** %%

%% end of [file_cats.hrl] %%
%%%%%%
%%
%% The Erlang code is generated by atscc2erl
%% The starting compilation time is: 2017-1-15: 16h:30m
%%
%%%%%%
%%%%%%
%%
%% end-of-compilation-unit
%%
%%%%%%
%%%%%%
%%
%% The Erlang code is generated by atscc2erl
%% The starting compilation time is: 2017-1-15: 16h:30m
%%
%%%%%%

%%fun%%
f_ats2erlpre_list_patsfun_35__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_35(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_39__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_39(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_42__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_42(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_46__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_46(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_50__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_50(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_54__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_54(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_57__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_57(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_61__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_61(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_65__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_list_patsfun_65(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_69__closurerize(XEnv0, XEnv1) -> 
%{
  {fun({_, Cenv1, Cenv2}, XArg0) -> f_ats2erlpre_list_patsfun_69(Cenv1, Cenv2, XArg0) end, XEnv0, XEnv1}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_73__closurerize(XEnv0, XEnv1) -> 
%{
  {fun({_, Cenv1, Cenv2}, XArg0) -> f_ats2erlpre_list_patsfun_73(Cenv1, Cenv2, XArg0) end, XEnv0, XEnv1}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_77__closurerize(XEnv0, XEnv1) -> 
%{
  {fun({_, Cenv1, Cenv2}, XArg0) -> f_ats2erlpre_list_patsfun_77(Cenv1, Cenv2, XArg0) end, XEnv0, XEnv1}.
%}


%%fun%%
f_ats2erlpre_list_patsfun_81__closurerize(XEnv0, XEnv1) -> 
%{
  {fun({_, Cenv1, Cenv2}, XArg0) -> f_ats2erlpre_list_patsfun_81(Cenv1, Cenv2, XArg0) end, XEnv0, XEnv1}.
%}


%%fun%%
ats2erlpre_list_make_elt(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret2
%% var Tmp7
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_make_elt,
  Tmp7 = atscc2erl_null,
  f_ats2erlpre_list_loop_3(Arg1, Arg0, Tmp7).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_3(Env0, Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret3
%% var Tmp4
%% var Tmp5
%% var Tmp6
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_3,
  Tmp4 = ats2erlpre_gt_int1_int1(Arg0, 0),
  if
    Tmp4 ->
      Tmp5 = ats2erlpre_sub_int1_int1(Arg0, 1),
      Tmp6 = {Env0, Arg1},
      f_ats2erlpre_list_loop_3(Env0, Tmp5, Tmp6);
    %% if-then
    true ->
      Arg1
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_make_intrange_2(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret8
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_make_intrange_2,
  ats2erlpre_list_make_intrange_3(Arg0, Arg1, 1).
%} // end-of-function


%%fun%%
ats2erlpre_list_make_intrange_3(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret9
%% var Tmp20
%% var Tmp21
%% var Tmp22
%% var Tmp23
%% var Tmp24
%% var Tmp25
%% var Tmp26
%% var Tmp27
%% var Tmp28
%% var Tmp29
%% var Tmp30
%% var Tmp31
%% var Tmp32
%% var Tmp33
%% var Tmp34
%% var Tmp35
%% var Tmp36
%% var Tmp37
%% var Tmp38
%% var Tmp39
%% var Tmp40
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_make_intrange_3,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      Tmp20 = ats2erlpre_gt_int0_int0(Arg2, 0),
      if(not(?ATSCKpat_bool(Tmp20, true))) -> Casefun(Casefun, 2); true ->
        Tmp21 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
        if
          Tmp21 ->
            Tmp25 = ats2erlpre_sub_int0_int0(Arg1, Arg0),
            Tmp24 = ats2erlpre_add_int0_int0(Tmp25, Arg2),
            Tmp23 = ats2erlpre_sub_int0_int0(Tmp24, 1),
            Tmp22 = ats2erlpre_div_int0_int0(Tmp23, Arg2),
            Tmp28 = ats2erlpre_sub_int0_int0(Tmp22, 1),
            Tmp27 = ats2erlpre_mul_int0_int0(Tmp28, Arg2),
            Tmp26 = ats2erlpre_add_int0_int0(Arg0, Tmp27),
            Tmp29 = atscc2erl_null,
            f_ats2erlpre_list_loop1_6(Tmp22, Tmp26, Arg2, Tmp29);
          %% if-then
          true ->
            atscc2erl_null
          %% if-else
        end
      end;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      2 ->
      Tmp30 = ats2erlpre_lt_int0_int0(Arg2, 0),
      if(not(?ATSCKpat_bool(Tmp30, true))) -> Casefun(Casefun, 3); true ->
        Tmp31 = ats2erlpre_gt_int0_int0(Arg0, Arg1),
        if
          Tmp31 ->
            Tmp32 = ats2erlpre_neg_int0(Arg2),
            Tmp36 = ats2erlpre_sub_int0_int0(Arg0, Arg1),
            Tmp35 = ats2erlpre_add_int0_int0(Tmp36, Tmp32),
            Tmp34 = ats2erlpre_sub_int0_int0(Tmp35, 1),
            Tmp33 = ats2erlpre_div_int0_int0(Tmp34, Tmp32),
            Tmp39 = ats2erlpre_sub_int0_int0(Tmp33, 1),
            Tmp38 = ats2erlpre_mul_int0_int0(Tmp39, Tmp32),
            Tmp37 = ats2erlpre_sub_int0_int0(Arg0, Tmp38),
            Tmp40 = atscc2erl_null,
            f_ats2erlpre_list_loop2_7(Tmp33, Tmp37, Tmp32, Tmp40);
          %% if-then
          true ->
            atscc2erl_null
          %% if-else
        end
      end;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      atscc2erl_null;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop1_6(Arg0, Arg1, Arg2, Arg3) ->
%{
%%
%% knd = 0
%% var Tmpret10
%% var Tmp11
%% var Tmp12
%% var Tmp13
%% var Tmp14
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop1_6,
  Tmp11 = ats2erlpre_gt_int0_int0(Arg0, 0),
  if
    Tmp11 ->
      Tmp12 = ats2erlpre_sub_int0_int0(Arg0, 1),
      Tmp13 = ats2erlpre_sub_int0_int0(Arg1, Arg2),
      Tmp14 = {Arg1, Arg3},
      f_ats2erlpre_list_loop1_6(Tmp12, Tmp13, Arg2, Tmp14);
    %% if-then
    true ->
      Arg3
    %% if-else
  end.
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop2_7(Arg0, Arg1, Arg2, Arg3) ->
%{
%%
%% knd = 0
%% var Tmpret15
%% var Tmp16
%% var Tmp17
%% var Tmp18
%% var Tmp19
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop2_7,
  Tmp16 = ats2erlpre_gt_int0_int0(Arg0, 0),
  if
    Tmp16 ->
      Tmp17 = ats2erlpre_sub_int0_int0(Arg0, 1),
      Tmp18 = ats2erlpre_add_int0_int0(Arg1, Arg2),
      Tmp19 = {Arg1, Arg3},
      f_ats2erlpre_list_loop2_7(Tmp17, Tmp18, Arg2, Tmp19);
    %% if-then
    true ->
      Arg3
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_length(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret52
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_length,
  f_ats2erlpre_list_loop_14(Arg0, 0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_14(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret53
%% var Tmp55
%% var Tmp56
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_14,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Arg1;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp55 = ?ATSSELcon(Arg0, 1),
      Tmp56 = ats2erlpre_add_int1_int1(Arg1, 1),
      f_ats2erlpre_list_loop_14(Tmp55, Tmp56);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_last(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret57
%% var Tmp58
%% var Tmp59
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_last,
  Tmp58 = ?ATSSELcon(Arg0, 0),
  Tmp59 = ?ATSSELcon(Arg0, 1),
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Tmp59)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Tmp58;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      ats2erlpre_list_last(Tmp59);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_get_at(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret60
%% var Tmp61
%% var Tmp62
%% var Tmp63
%% var Tmp64
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_get_at,
  Tmp61 = ats2erlpre_eq_int1_int1(Arg1, 0),
  if
    Tmp61 ->
      Tmp62 = ?ATSSELcon(Arg0, 0),
      Tmp62;
    %% if-then
    true ->
      Tmp63 = ?ATSSELcon(Arg0, 1),
      Tmp64 = ats2erlpre_sub_int1_int1(Arg1, 1),
      ats2erlpre_list_get_at(Tmp63, Tmp64)
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_snoc(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret65
%% var Tmp66
%% var Tmp67
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_snoc,
  Tmp67 = atscc2erl_null,
  Tmp66 = {Arg1, Tmp67},
  ats2erlpre_list_append(Arg0, Tmp66).
%} // end-of-function


%%fun%%
ats2erlpre_list_extend(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret68
%% var Tmp69
%% var Tmp70
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_extend,
  Tmp70 = atscc2erl_null,
  Tmp69 = {Arg1, Tmp70},
  ats2erlpre_list_append(Arg0, Tmp69).
%} // end-of-function


%%fun%%
ats2erlpre_list_append(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret71
%% var Tmp72
%% var Tmp73
%% var Tmp74
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_append,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Arg1;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp72 = ?ATSSELcon(Arg0, 0),
      Tmp73 = ?ATSSELcon(Arg0, 1),
      Tmp74 = ats2erlpre_list_append(Tmp73, Arg1),
      {Tmp72, Tmp74};
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_mul_int_list(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret75
%% var Tmp80
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_mul_int_list,
  Tmp80 = atscc2erl_null,
  f_ats2erlpre_list_loop_21(Arg1, Arg0, Tmp80).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_21(Env0, Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret76
%% var Tmp77
%% var Tmp78
%% var Tmp79
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_21,
  Tmp77 = ats2erlpre_gt_int1_int1(Arg0, 0),
  if
    Tmp77 ->
      Tmp78 = ats2erlpre_sub_int1_int1(Arg0, 1),
      Tmp79 = ats2erlpre_list_append(Env0, Arg1),
      f_ats2erlpre_list_loop_21(Env0, Tmp78, Tmp79);
    %% if-then
    true ->
      Arg1
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_reverse(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret81
%% var Tmp82
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_reverse,
  Tmp82 = atscc2erl_null,
  ats2erlpre_list_reverse_append(Arg0, Tmp82).
%} // end-of-function


%%fun%%
ats2erlpre_list_reverse_append(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret83
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_reverse_append,
  f_ats2erlpre_list_loop_24(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_24(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret84
%% var Tmp85
%% var Tmp86
%% var Tmp87
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_24,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Arg1;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp85 = ?ATSSELcon(Arg0, 0),
      Tmp86 = ?ATSSELcon(Arg0, 1),
      Tmp87 = {Tmp85, Arg1},
      f_ats2erlpre_list_loop_24(Tmp86, Tmp87);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_concat(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret88
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_concat,
  f_ats2erlpre_list_auxlst_26(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_auxlst_26(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret89
%% var Tmp90
%% var Tmp91
%% var Tmp92
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_auxlst_26,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      atscc2erl_null;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp90 = ?ATSSELcon(Arg0, 0),
      Tmp91 = ?ATSSELcon(Arg0, 1),
      Tmp92 = f_ats2erlpre_list_auxlst_26(Tmp91),
      ats2erlpre_list_append(Tmp90, Tmp92);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_take(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret93
%% var Tmp94
%% var Tmp95
%% var Tmp96
%% var Tmp97
%% var Tmp98
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_take,
  Tmp94 = ats2erlpre_gt_int1_int1(Arg1, 0),
  if
    Tmp94 ->
      Tmp95 = ?ATSSELcon(Arg0, 0),
      Tmp96 = ?ATSSELcon(Arg0, 1),
      Tmp98 = ats2erlpre_sub_int1_int1(Arg1, 1),
      Tmp97 = ats2erlpre_list_take(Tmp96, Tmp98),
      {Tmp95, Tmp97};
    %% if-then
    true ->
      atscc2erl_null
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_drop(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret99
%% var Tmp100
%% var Tmp101
%% var Tmp102
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_drop,
  Tmp100 = ats2erlpre_gt_int1_int1(Arg1, 0),
  if
    Tmp100 ->
      Tmp101 = ?ATSSELcon(Arg0, 1),
      Tmp102 = ats2erlpre_sub_int1_int1(Arg1, 1),
      ats2erlpre_list_drop(Tmp101, Tmp102);
    %% if-then
    true ->
      Arg0
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_split_at(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret103
%% var Tmp104
%% var Tmp105
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_split_at,
  Tmp104 = ats2erlpre_list_take(Arg0, Arg1),
  Tmp105 = ats2erlpre_list_drop(Arg0, Arg1),
  {Tmp104, Tmp105}.
%} // end-of-function


%%fun%%
ats2erlpre_list_insert_at(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret106
%% var Tmp107
%% var Tmp108
%% var Tmp109
%% var Tmp110
%% var Tmp111
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_insert_at,
  Tmp107 = ats2erlpre_gt_int1_int1(Arg1, 0),
  if
    Tmp107 ->
      Tmp108 = ?ATSSELcon(Arg0, 0),
      Tmp109 = ?ATSSELcon(Arg0, 1),
      Tmp111 = ats2erlpre_sub_int1_int1(Arg1, 1),
      Tmp110 = ats2erlpre_list_insert_at(Tmp109, Tmp111, Arg2),
      {Tmp108, Tmp110};
    %% if-then
    true ->
      {Arg2, Arg0}
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_remove_at(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret112
%% var Tmp113
%% var Tmp114
%% var Tmp115
%% var Tmp116
%% var Tmp117
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_remove_at,
  Tmp113 = ?ATSSELcon(Arg0, 0),
  Tmp114 = ?ATSSELcon(Arg0, 1),
  Tmp115 = ats2erlpre_gt_int1_int1(Arg1, 0),
  if
    Tmp115 ->
      Tmp117 = ats2erlpre_sub_int1_int1(Arg1, 1),
      Tmp116 = ats2erlpre_list_remove_at(Tmp114, Tmp117),
      {Tmp113, Tmp116};
    %% if-then
    true ->
      Tmp114
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_takeout_at(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret118
%% var Tmp119
%% var Tmp120
%% var Tmp121
%% var Tmp122
%% var Tmp123
%% var Tmp124
%% var Tmp125
%% var Tmp126
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_takeout_at,
  Tmp119 = ?ATSSELcon(Arg0, 0),
  Tmp120 = ?ATSSELcon(Arg0, 1),
  Tmp121 = ats2erlpre_gt_int1_int1(Arg1, 0),
  if
    Tmp121 ->
      Tmp123 = ats2erlpre_sub_int1_int1(Arg1, 1),
      Tmp122 = ats2erlpre_list_takeout_at(Tmp120, Tmp123),
      Tmp124 = ?ATSSELboxrec(Tmp122, 0),
      Tmp125 = ?ATSSELboxrec(Tmp122, 1),
      Tmp126 = {Tmp119, Tmp125},
      {Tmp124, Tmp126};
    %% if-then
    true ->
      {Tmp119, Tmp120}
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_exists(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret127
%% var Tmp128
%% var Tmp129
%% var Tmp130
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_exists,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      false;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp128 = ?ATSSELcon(Arg0, 0),
      Tmp129 = ?ATSSELcon(Arg0, 1),
      Tmp130 = ?ATSfunclo_clo(Arg1)(Arg1, Tmp128),
      if
        Tmp130 ->
          true;
        %% if-then
        true ->
          ats2erlpre_list_exists(Tmp129, Arg1)
        %% if-else
      end;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_exists_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret131
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_exists_method,
  f_ats2erlpre_list_patsfun_35__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_35(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret132
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_35,
  ats2erlpre_list_exists(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_iexists(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret133
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_iexists,
  f_ats2erlpre_list_loop_37(Arg1, 0, Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_37(Env0, Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret134
%% var Tmp135
%% var Tmp136
%% var Tmp137
%% var Tmp138
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_37,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg1)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      false;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp135 = ?ATSSELcon(Arg1, 0),
      Tmp136 = ?ATSSELcon(Arg1, 1),
      Tmp137 = ?ATSfunclo_clo(Env0)(Env0, Arg0, Tmp135),
      if
        Tmp137 ->
          true;
        %% if-then
        true ->
          Tmp138 = ats2erlpre_add_int1_int1(Arg0, 1),
          f_ats2erlpre_list_loop_37(Env0, Tmp138, Tmp136)
        %% if-else
      end;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_iexists_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret139
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_iexists_method,
  f_ats2erlpre_list_patsfun_39__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_39(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret140
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_39,
  ats2erlpre_list_iexists(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_forall(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret141
%% var Tmp142
%% var Tmp143
%% var Tmp144
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_forall,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      true;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp142 = ?ATSSELcon(Arg0, 0),
      Tmp143 = ?ATSSELcon(Arg0, 1),
      Tmp144 = ?ATSfunclo_clo(Arg1)(Arg1, Tmp142),
      if
        Tmp144 ->
          ats2erlpre_list_forall(Tmp143, Arg1);
        %% if-then
        true ->
          false
        %% if-else
      end;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_forall_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret145
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_forall_method,
  f_ats2erlpre_list_patsfun_42__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_42(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret146
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_42,
  ats2erlpre_list_forall(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_iforall(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret147
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_iforall,
  f_ats2erlpre_list_loop_44(Arg1, 0, Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_44(Env0, Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret148
%% var Tmp149
%% var Tmp150
%% var Tmp151
%% var Tmp152
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_44,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg1)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      true;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp149 = ?ATSSELcon(Arg1, 0),
      Tmp150 = ?ATSSELcon(Arg1, 1),
      Tmp151 = ?ATSfunclo_clo(Env0)(Env0, Arg0, Tmp149),
      if
        Tmp151 ->
          Tmp152 = ats2erlpre_add_int1_int1(Arg0, 1),
          f_ats2erlpre_list_loop_44(Env0, Tmp152, Tmp150);
        %% if-then
        true ->
          false
        %% if-else
      end;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_iforall_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret153
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_iforall_method,
  f_ats2erlpre_list_patsfun_46__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_46(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret154
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_46,
  ats2erlpre_list_iforall(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_app(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_app,
  ats2erlpre_list_foreach(Arg0, Arg1).
%} // end-of-function


%%fun%%
ats2erlpre_list_foreach(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp157
%% var Tmp158
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_foreach,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      ?ATSINSmove_void();
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp157 = ?ATSSELcon(Arg0, 0),
      Tmp158 = ?ATSSELcon(Arg0, 1),
      ?ATSfunclo_clo(Arg1)(Arg1, Tmp157),
      ats2erlpre_list_foreach(Tmp158, Arg1);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_foreach_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret160
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_foreach_method,
  f_ats2erlpre_list_patsfun_50__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_50(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_50,
  ats2erlpre_list_foreach(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_iforeach(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_iforeach,
  f_ats2erlpre_list_aux_52(Arg1, 0, Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_aux_52(Env0, Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp164
%% var Tmp165
%% var Tmp167
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_aux_52,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg1)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      ?ATSINSmove_void();
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp164 = ?ATSSELcon(Arg1, 0),
      Tmp165 = ?ATSSELcon(Arg1, 1),
      ?ATSfunclo_clo(Env0)(Env0, Arg0, Tmp164),
      Tmp167 = ats2erlpre_add_int1_int1(Arg0, 1),
      f_ats2erlpre_list_aux_52(Env0, Tmp167, Tmp165);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_iforeach_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret168
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_iforeach_method,
  f_ats2erlpre_list_patsfun_54__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_54(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_54,
  ats2erlpre_list_iforeach(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_rforeach(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp171
%% var Tmp172
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_rforeach,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      ?ATSINSmove_void();
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp171 = ?ATSSELcon(Arg0, 0),
      Tmp172 = ?ATSSELcon(Arg0, 1),
      ats2erlpre_list_rforeach(Tmp172, Arg1),
      ?ATSfunclo_clo(Arg1)(Arg1, Tmp171);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_rforeach_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret174
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_rforeach_method,
  f_ats2erlpre_list_patsfun_57__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_57(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_57,
  ats2erlpre_list_rforeach(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_filter(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret176
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_filter,
  f_ats2erlpre_list_aux_59(Arg1, Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_aux_59(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret177
%% var Tmp178
%% var Tmp179
%% var Tmp180
%% var Tmp181
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_aux_59,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      atscc2erl_null;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp178 = ?ATSSELcon(Arg0, 0),
      Tmp179 = ?ATSSELcon(Arg0, 1),
      Tmp180 = ?ATSfunclo_clo(Env0)(Env0, Tmp178),
      if
        Tmp180 ->
          Tmp181 = f_ats2erlpre_list_aux_59(Env0, Tmp179),
          {Tmp178, Tmp181};
        %% if-then
        true ->
          f_ats2erlpre_list_aux_59(Env0, Tmp179)
        %% if-else
      end;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_filter_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret182
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_filter_method,
  f_ats2erlpre_list_patsfun_61__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_61(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret183
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_61,
  ats2erlpre_list_filter(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_map(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret184
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_map,
  f_ats2erlpre_list_aux_63(Arg1, Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_aux_63(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret185
%% var Tmp186
%% var Tmp187
%% var Tmp188
%% var Tmp189
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_aux_63,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      atscc2erl_null;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp186 = ?ATSSELcon(Arg0, 0),
      Tmp187 = ?ATSSELcon(Arg0, 1),
      Tmp188 = ?ATSfunclo_clo(Env0)(Env0, Tmp186),
      Tmp189 = f_ats2erlpre_list_aux_63(Env0, Tmp187),
      {Tmp188, Tmp189};
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_map_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret190
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_map_method,
  f_ats2erlpre_list_patsfun_65__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_65(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret191
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_65,
  ats2erlpre_list_map(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_foldleft(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret192
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_foldleft,
  f_ats2erlpre_list_loop_67(Arg2, Arg1, Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_67(Env0, Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret193
%% var Tmp194
%% var Tmp195
%% var Tmp196
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_67,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg1)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Arg0;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp194 = ?ATSSELcon(Arg1, 0),
      Tmp195 = ?ATSSELcon(Arg1, 1),
      Tmp196 = ?ATSfunclo_clo(Env0)(Env0, Arg0, Tmp194),
      f_ats2erlpre_list_loop_67(Env0, Tmp196, Tmp195);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_foldleft_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret197
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_foldleft_method,
  f_ats2erlpre_list_patsfun_69__closurerize(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_69(Env0, Env1, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret198
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_69,
  ats2erlpre_list_foldleft(Env0, Env1, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_ifoldleft(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret199
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_ifoldleft,
  f_ats2erlpre_list_loop_71(Arg2, 0, Arg1, Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_loop_71(Env0, Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret200
%% var Tmp201
%% var Tmp202
%% var Tmp203
%% var Tmp204
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_loop_71,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg2)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Arg1;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp201 = ?ATSSELcon(Arg2, 0),
      Tmp202 = ?ATSSELcon(Arg2, 1),
      Tmp203 = ats2erlpre_add_int1_int1(Arg0, 1),
      Tmp204 = ?ATSfunclo_clo(Env0)(Env0, Arg0, Arg1, Tmp201),
      f_ats2erlpre_list_loop_71(Env0, Tmp203, Tmp204, Tmp202);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_ifoldleft_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret205
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_ifoldleft_method,
  f_ats2erlpre_list_patsfun_73__closurerize(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_73(Env0, Env1, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret206
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_73,
  ats2erlpre_list_ifoldleft(Env0, Env1, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_list_foldright(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret207
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_foldright,
  f_ats2erlpre_list_aux_75(Arg1, Arg0, Arg2).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_aux_75(Env0, Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret208
%% var Tmp209
%% var Tmp210
%% var Tmp211
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_aux_75,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Arg1;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp209 = ?ATSSELcon(Arg0, 0),
      Tmp210 = ?ATSSELcon(Arg0, 1),
      Tmp211 = f_ats2erlpre_list_aux_75(Env0, Tmp210, Arg1),
      ?ATSfunclo_clo(Env0)(Env0, Tmp209, Tmp211);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_foldright_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret212
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_foldright_method,
  f_ats2erlpre_list_patsfun_77__closurerize(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_77(Env0, Env1, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret213
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_77,
  ats2erlpre_list_foldright(Env0, Arg0, Env1).
%} // end-of-function


%%fun%%
ats2erlpre_list_ifoldright(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret214
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_ifoldright,
  f_ats2erlpre_list_aux_79(Arg1, 0, Arg0, Arg2).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_aux_79(Env0, Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret215
%% var Tmp216
%% var Tmp217
%% var Tmp218
%% var Tmp219
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_aux_79,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg1)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      Arg2;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp216 = ?ATSSELcon(Arg1, 0),
      Tmp217 = ?ATSSELcon(Arg1, 1),
      Tmp219 = ats2erlpre_add_int1_int1(Arg0, 1),
      Tmp218 = f_ats2erlpre_list_aux_79(Env0, Tmp219, Tmp217, Arg2),
      ?ATSfunclo_clo(Env0)(Env0, Arg0, Tmp216, Tmp218);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_list_ifoldright_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret220
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list_ifoldright_method,
  f_ats2erlpre_list_patsfun_81__closurerize(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_list_patsfun_81(Env0, Env1, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret221
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_list_patsfun_81,
  ats2erlpre_list_ifoldright(Env0, Arg0, Env1).
%} // end-of-function

%%%%%%
%%
%% end-of-compilation-unit
%%
%%%%%%
%%%%%%
%%
%% The Erlang code is generated by atscc2erl
%% The starting compilation time is: 2017-1-15: 16h:30m
%%
%%%%%%

%%fun%%
ats2erlpre_option_some(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_option_some,
  {Arg0}.
%} // end-of-function


%%fun%%
ats2erlpre_option_none() ->
%{
%%
%% knd = 0
%% var Tmpret1
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_option_none,
  atscc2erl_null.
%} // end-of-function


%%fun%%
ats2erlpre_option_unsome(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret2
%% var Tmp3
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_option_unsome,
  Tmp3 = ?ATSSELcon(Arg0, 0),
  Tmp3.
%} // end-of-function


%%fun%%
ats2erlpre_option_is_some(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret4
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_option_is_some,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptrisnull(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      true;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      false;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
ats2erlpre_option_is_none(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret5
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_option_is_none,
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(?ATSCKptriscons(Arg0)) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      true;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      false;
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function

%%%%%%
%%
%% end-of-compilation-unit
%%
%%%%%%
%%%%%%
%%
%% The Erlang code is generated by atscc2erl
%% The starting compilation time is: 2017-1-15: 16h:30m
%%
%%%%%%

%%fun%%
f_ats2erlpre_intrange_patsfun_4__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_4(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_9__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_9(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_11__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_11(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_13__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_13(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_16__closurerize(XEnv0, XEnv1) -> 
%{
  {fun({_, Cenv1, Cenv2}, XArg0) -> f_ats2erlpre_intrange_patsfun_16(Cenv1, Cenv2, XArg0) end, XEnv0, XEnv1}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_20__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_20(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_23__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_23(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_30__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_30(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_34__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_34(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_38__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_ats2erlpre_intrange_patsfun_38(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_ats2erlpre_intrange_patsfun_42__closurerize(XEnv0, XEnv1, XEnv2) -> 
%{
  {fun({_, Cenv1, Cenv2, Cenv3}, XArg0) -> f_ats2erlpre_intrange_patsfun_42(Cenv1, Cenv2, Cenv3, XArg0) end, XEnv0, XEnv1, XEnv2}.
%}


%%fun%%
ats2erlpre_int_repeat_lazy(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp1
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_repeat_lazy,
  Tmp1 = atspre_lazy2cloref(Arg1),
  ats2erlpre_int_repeat_cloref(Arg0, Tmp1).
%} // end-of-function


%%fun%%
ats2erlpre_int_repeat_cloref(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_repeat_cloref,
  f_ats2erlpre_intrange_loop_2(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop_2(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp4
%% var Tmp6
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop_2,
  Tmp4 = ats2erlpre_gt_int0_int0(Arg0, 0),
  if
    Tmp4 ->
      ?ATSfunclo_clo(Arg1)(Arg1),
      Tmp6 = ats2erlpre_sub_int0_int0(Arg0, 1),
      f_ats2erlpre_intrange_loop_2(Tmp6, Arg1);
    %% if-then
    true ->
      ?ATSINSmove_void()
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_int_repeat_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret7
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_repeat_method,
  f_ats2erlpre_intrange_patsfun_4__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_4(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_4,
  ats2erlpre_int_repeat_cloref(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_int_exists_cloref(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret9
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_exists_cloref,
  ats2erlpre_intrange_exists_cloref(0, Arg0, Arg1).
%} // end-of-function


%%fun%%
ats2erlpre_int_forall_cloref(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret10
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_forall_cloref,
  ats2erlpre_intrange_forall_cloref(0, Arg0, Arg1).
%} // end-of-function


%%fun%%
ats2erlpre_int_foreach_cloref(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_foreach_cloref,
  ats2erlpre_intrange_foreach_cloref(0, Arg0, Arg1).
%} // end-of-function


%%fun%%
ats2erlpre_int_exists_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret12
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_exists_method,
  f_ats2erlpre_intrange_patsfun_9__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_9(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret13
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_9,
  ats2erlpre_int_exists_cloref(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_int_forall_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret14
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_forall_method,
  f_ats2erlpre_intrange_patsfun_11__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_11(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret15
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_11,
  ats2erlpre_int_forall_cloref(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_int_foreach_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret16
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_foreach_method,
  f_ats2erlpre_intrange_patsfun_13__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_13(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_13,
  ats2erlpre_int_foreach_cloref(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_int_foldleft_cloref(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret18
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_foldleft_cloref,
  ats2erlpre_intrange_foldleft_cloref(0, Arg0, Arg1, Arg2).
%} // end-of-function


%%fun%%
ats2erlpre_int_foldleft_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret19
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_foldleft_method,
  f_ats2erlpre_intrange_patsfun_16__closurerize(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_16(Env0, Env1, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret20
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_16,
  ats2erlpre_int_foldleft_cloref(Env0, Env1, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_int_list_map_cloref(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret21
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_list_map_cloref,
  f_ats2erlpre_intrange_aux_18(Arg0, Arg1, 0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_aux_18(Env0, Env1, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret22
%% var Tmp23
%% var Tmp24
%% var Tmp25
%% var Tmp26
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_aux_18,
  Tmp23 = ats2erlpre_lt_int1_int1(Arg0, Env0),
  if
    Tmp23 ->
      Tmp24 = ?ATSfunclo_clo(Env1)(Env1, Arg0),
      Tmp26 = ats2erlpre_add_int1_int1(Arg0, 1),
      Tmp25 = f_ats2erlpre_intrange_aux_18(Env0, Env1, Tmp26),
      {Tmp24, Tmp25};
    %% if-then
    true ->
      atscc2erl_null
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_int_list_map_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret27
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_list_map_method,
  f_ats2erlpre_intrange_patsfun_20__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_20(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret28
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_20,
  ats2erlpre_int_list_map_cloref(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_int_list0_map_cloref(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret29
%% var Tmp30
%% var Tmp31
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_list0_map_cloref,
  Tmp30 = ats2erlpre_gte_int1_int1(Arg0, 0),
  if
    Tmp30 ->
      Tmp31 = ats2erlpre_int_list_map_cloref(Arg0, Arg1),
      Tmp31;
    %% if-then
    true ->
      atscc2erl_null
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_int_list0_map_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret32
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int_list0_map_method,
  f_ats2erlpre_intrange_patsfun_23__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_23(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret33
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_23,
  ats2erlpre_int_list0_map_cloref(Env0, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_int2_exists_cloref(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret34
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int2_exists_cloref,
  ats2erlpre_intrange2_exists_cloref(0, Arg0, 0, Arg1, Arg2).
%} // end-of-function


%%fun%%
ats2erlpre_int2_forall_cloref(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret35
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int2_forall_cloref,
  ats2erlpre_intrange2_forall_cloref(0, Arg0, 0, Arg1, Arg2).
%} // end-of-function


%%fun%%
ats2erlpre_int2_foreach_cloref(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_int2_foreach_cloref,
  ats2erlpre_intrange2_foreach_cloref(0, Arg0, 0, Arg1, Arg2).
%} // end-of-function


%%fun%%
ats2erlpre_intrange_exists_cloref(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret37
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_exists_cloref,
  f_ats2erlpre_intrange_loop_28(Arg0, Arg1, Arg2).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop_28(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret38
%% var Tmp39
%% var Tmp40
%% var Tmp41
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop_28,
  Tmp39 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
  if
    Tmp39 ->
      Tmp40 = ?ATSfunclo_clo(Arg2)(Arg2, Arg0),
      if
        Tmp40 ->
          true;
        %% if-then
        true ->
          Tmp41 = ats2erlpre_add_int0_int0(Arg0, 1),
          f_ats2erlpre_intrange_loop_28(Tmp41, Arg1, Arg2)
        %% if-else
      end;
    %% if-then
    true ->
      false
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_intrange_exists_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret42
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_exists_method,
  f_ats2erlpre_intrange_patsfun_30__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_30(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret43
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_30,
  ats2erlpre_intrange_exists_cloref(?ATSSELboxrec(Env0, 0), ?ATSSELboxrec(Env0, 1), Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_intrange_forall_cloref(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret44
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_forall_cloref,
  f_ats2erlpre_intrange_loop_32(Arg0, Arg1, Arg2).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop_32(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret45
%% var Tmp46
%% var Tmp47
%% var Tmp48
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop_32,
  Tmp46 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
  if
    Tmp46 ->
      Tmp47 = ?ATSfunclo_clo(Arg2)(Arg2, Arg0),
      if
        Tmp47 ->
          Tmp48 = ats2erlpre_add_int0_int0(Arg0, 1),
          f_ats2erlpre_intrange_loop_32(Tmp48, Arg1, Arg2);
        %% if-then
        true ->
          false
        %% if-else
      end;
    %% if-then
    true ->
      true
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_intrange_forall_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret49
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_forall_method,
  f_ats2erlpre_intrange_patsfun_34__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_34(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret50
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_34,
  ats2erlpre_intrange_forall_cloref(?ATSSELboxrec(Env0, 0), ?ATSSELboxrec(Env0, 1), Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_intrange_foreach_cloref(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_foreach_cloref,
  f_ats2erlpre_intrange_loop_36(Arg0, Arg1, Arg2).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop_36(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmp53
%% var Tmp55
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop_36,
  Tmp53 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
  if
    Tmp53 ->
      ?ATSfunclo_clo(Arg2)(Arg2, Arg0),
      Tmp55 = ats2erlpre_add_int0_int0(Arg0, 1),
      f_ats2erlpre_intrange_loop_36(Tmp55, Arg1, Arg2);
    %% if-then
    true ->
      ?ATSINSmove_void()
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_intrange_foreach_method(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret56
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_foreach_method,
  f_ats2erlpre_intrange_patsfun_38__closurerize(Arg0).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_38(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_38,
  ats2erlpre_intrange_foreach_cloref(?ATSSELboxrec(Env0, 0), ?ATSSELboxrec(Env0, 1), Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_intrange_foldleft_cloref(Arg0, Arg1, Arg2, Arg3) ->
%{
%%
%% knd = 0
%% var Tmpret58
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_foldleft_cloref,
  f_ats2erlpre_intrange_loop_40(Arg3, Arg0, Arg1, Arg2, Arg3).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop_40(Env0, Arg0, Arg1, Arg2, Arg3) ->
%{
%%
%% knd = 0
%% var Tmpret59
%% var Tmp60
%% var Tmp61
%% var Tmp62
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop_40,
  Tmp60 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
  if
    Tmp60 ->
      Tmp61 = ats2erlpre_add_int0_int0(Arg0, 1),
      Tmp62 = ?ATSfunclo_clo(Arg3)(Arg3, Arg2, Arg0),
      f_ats2erlpre_intrange_loop_40(Env0, Tmp61, Arg1, Tmp62, Env0);
    %% if-then
    true ->
      Arg2
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_intrange_foldleft_method(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp63
%% var Tmp64
%% var Tmpret65
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange_foldleft_method,
  Tmp63 = ?ATSSELboxrec(Arg0, 0),
  Tmp64 = ?ATSSELboxrec(Arg0, 1),
  f_ats2erlpre_intrange_patsfun_42__closurerize(Tmp63, Tmp64, Arg1).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_patsfun_42(Env0, Env1, Env2, Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret66
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_patsfun_42,
  ats2erlpre_intrange_foldleft_cloref(Env0, Env1, Env2, Arg0).
%} // end-of-function


%%fun%%
ats2erlpre_intrange2_exists_cloref(Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmpret67
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange2_exists_cloref,
  f_ats2erlpre_intrange_loop1_44(Arg2, Arg3, Arg4, Arg0, Arg1, Arg2, Arg3, Arg4).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop1_44(Env0, Env1, Env2, Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmpret68
%% var Tmp69
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop1_44,
  Tmp69 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
  if
    Tmp69 ->
      f_ats2erlpre_intrange_loop2_45(Env0, Env1, Env2, Arg0, Arg1, Arg2, Arg3, Env2);
    %% if-then
    true ->
      false
    %% if-else
  end.
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop2_45(Env0, Env1, Env2, Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmpret70
%% var Tmp71
%% var Tmp72
%% var Tmp73
%% var Tmp74
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop2_45,
  Tmp71 = ats2erlpre_lt_int0_int0(Arg2, Arg3),
  if
    Tmp71 ->
      Tmp72 = ?ATSfunclo_clo(Arg4)(Arg4, Arg0, Arg2),
      if
        Tmp72 ->
          true;
        %% if-then
        true ->
          Tmp73 = ats2erlpre_add_int0_int0(Arg2, 1),
          f_ats2erlpre_intrange_loop2_45(Env0, Env1, Env2, Arg0, Arg1, Tmp73, Arg3, Arg4)
        %% if-else
      end;
    %% if-then
    true ->
      Tmp74 = ats2erlpre_add_int0_int0(Arg0, 1),
      f_ats2erlpre_intrange_loop1_44(Env0, Env1, Env2, Tmp74, Arg1, Env0, Env1, Arg4)
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_intrange2_forall_cloref(Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmpret75
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange2_forall_cloref,
  f_ats2erlpre_intrange_loop1_47(Arg2, Arg3, Arg0, Arg1, Arg2, Arg3, Arg4).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop1_47(Env0, Env1, Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmpret76
%% var Tmp77
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop1_47,
  Tmp77 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
  if
    Tmp77 ->
      f_ats2erlpre_intrange_loop2_48(Env0, Env1, Arg0, Arg1, Arg2, Arg3, Arg4);
    %% if-then
    true ->
      true
    %% if-else
  end.
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop2_48(Env0, Env1, Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmpret78
%% var Tmp79
%% var Tmp80
%% var Tmp81
%% var Tmp82
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop2_48,
  Tmp79 = ats2erlpre_lt_int0_int0(Arg2, Arg3),
  if
    Tmp79 ->
      Tmp80 = ?ATSfunclo_clo(Arg4)(Arg4, Arg0, Arg2),
      if
        Tmp80 ->
          Tmp81 = ats2erlpre_add_int0_int0(Arg2, 1),
          f_ats2erlpre_intrange_loop2_48(Env0, Env1, Arg0, Arg1, Tmp81, Arg3, Arg4);
        %% if-then
        true ->
          false
        %% if-else
      end;
    %% if-then
    true ->
      Tmp82 = ats2erlpre_add_int0_int0(Arg0, 1),
      f_ats2erlpre_intrange_loop1_47(Env0, Env1, Tmp82, Arg1, Env0, Env1, Arg4)
    %% if-else
  end.
%} // end-of-function


%%fun%%
ats2erlpre_intrange2_foreach_cloref(Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_intrange2_foreach_cloref,
  f_ats2erlpre_intrange_loop1_50(Arg2, Arg3, Arg0, Arg1, Arg2, Arg3, Arg4).
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop1_50(Env0, Env1, Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmp85
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop1_50,
  Tmp85 = ats2erlpre_lt_int0_int0(Arg0, Arg1),
  if
    Tmp85 ->
      f_ats2erlpre_intrange_loop2_51(Env0, Env1, Arg0, Arg1, Arg2, Arg3, Arg4);
    %% if-then
    true ->
      ?ATSINSmove_void()
    %% if-else
  end.
%} // end-of-function


%%fun%%
f_ats2erlpre_intrange_loop2_51(Env0, Env1, Arg0, Arg1, Arg2, Arg3, Arg4) ->
%{
%%
%% knd = 0
%% var Tmp87
%% var Tmp89
%% var Tmp90
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__ats2erlpre_intrange_loop2_51,
  Tmp87 = ats2erlpre_lt_int0_int0(Arg2, Arg3),
  if
    Tmp87 ->
      ?ATSfunclo_clo(Arg4)(Arg4, Arg0, Arg2),
      Tmp89 = ats2erlpre_add_int0_int0(Arg2, 1),
      f_ats2erlpre_intrange_loop2_51(Env0, Env1, Arg0, Arg1, Tmp89, Arg3, Arg4);
    %% if-then
    true ->
      Tmp90 = ats2erlpre_succ_int0(Arg0),
      f_ats2erlpre_intrange_loop1_50(Env0, Env1, Tmp90, Arg1, Env0, Env1, Arg4)
    %% if-else
  end.
%} // end-of-function

%%%%%%
%%
%% end-of-compilation-unit
%%
%%%%%%

%% ****** ****** %%

%% end of [output/libatscc2erl_all.hrl] %%
