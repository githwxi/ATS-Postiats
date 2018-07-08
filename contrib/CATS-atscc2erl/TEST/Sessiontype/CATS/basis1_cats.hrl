%%%%%%
%%
%% Session-typed channels
%%
%%%%%%
%%
%% Author: Hongwei Xi
%% Authoremail: gmhwxiATgmailDOTcom
%%
%% Start time: July, 2015
%%
%%%%%%
%%
%% HX-2015-07:
%% A serious limitation with this implementation:
%% it is unable to support chanposneg_link efficiently
%%
%%%%%%
%%
%% A positive channel is a pid: Chpos
%% A negative channel is a pair of pids: {Chpos, Chneg}
%%
%%%%%%
%%
libats2erl_session_chanpos_send
  (Chpos, X) -> Chpos ! {self(), X}.
libats2erl_session_channeg_recv
  ({Chpos, Chneg}, X) -> Chneg ! {Chpos, X}.
%%
%%%%%%
%%
libats2erl_session_chanpos_recv
  (Chpos) -> receive {Chpos, X} -> X end.
libats2erl_session_channeg_send
  ({Chpos, Chneg}) ->
  Chpos ! {self()}, receive {Chneg, X} -> X end.
%%
%%%%%%
%%
libats2erl_session_chanpos_nil_wait(Chpos) ->
  receive {Chpos, libats2erl_session_channeg_close} -> libats2erl_session_channeg_close end.
libats2erl_session_channeg_nil_close({Chpos, Chneg}) ->
  Chneg ! {Chpos, libats2erl_session_channeg_close}, Chpos ! libats2erl_session_chanpos_xfer_close.
%%
%%%%%%
%%
libats2erl_session_chanpos_xfer() ->
  receive
    {Client} ->
    receive
      ChposX = {_Chpos, _X} -> Client ! ChposX, libats2erl_session_chanpos_xfer()
    end;
    X = libats2erl_session_chanpos_xfer_close -> X
  end.
%%
%%%%%%
%%
libats2erl_session_chanposneg_link
  (Chpos1, Chposneg2) ->
  spawn(
    ?MODULE
  , libats2erl_session_chanposneg_link_np
  , [Chpos1, self(), Chposneg2]
  ), %% spawn
  libats2erl_session_chanposneg_link_pn(Chpos1, Chposneg2).
%%
libats2erl_session_chanposneg_link_pn
  (Chpos1, Chposneg2) ->
%%
%%io:format("libats2erl_session_chanposneg_link_pn: Chpos1 = ~p~n", [Chpos1]),
%%io:format("libats2erl_session_chanposneg_link_pn: Chposneg2 = ~p~n", [Chposneg2]),
%%
  X = libats2erl_session_chanpos_recv(Chpos1),
%%
%%io:format("libats2erl_session_chanposneg_link_pn: X = ~p~n", [X]),
%%
  {Chpos2, Chneg2} = Chposneg2,
  if
    (X=:=libats2erl_session_channeg_close) ->
      Chpos1 ! libats2erl_session_chanpos_xfer_close,
      Chpos2 ! {Chneg2, libats2erl_session_channeg_close};
    true ->
      Chneg2 ! {Chpos2, X},
      libats2erl_session_chanposneg_link_pn(Chpos1, Chposneg2)
  end.
%%
libats2erl_session_chanposneg_link_np
  (Chpos1, Chneg1, Chposneg2) ->
%%
%%io:format("libats2erl_session_chanposneg_link_np: Chpos1 = ~p~n", [Chpos1]),
%%io:format("libats2erl_session_chanposneg_link_np: Chneg1 = ~p~n", [Chneg1]),
%%io:format("libats2erl_session_chanposneg_link_np: Chposneg2 = ~p~n", [Chposneg2]),
%%
  X = libats2erl_session_channeg_send(Chposneg2),
%%
%%io:format("libats2erl_session_chanposneg_link_np: X = ~p~n", [X]),
%%
  if
    (X =:=libats2erl_session_channeg_close) ->
      libats2erl_session_channeg_nil_close(Chposneg2);
    true ->
      Chpos1 ! {Chneg1, X},
      libats2erl_session_chanposneg_link_np(Chpos1, Chneg1, Chposneg2)
  end.
%%
%%%%%%
%%
libats2erl_session_channeg_create
  (Fserv) ->
  Chpos = spawn(?MODULE, libats2erl_session_chanpos_xfer, []),
  Chneg = spawn(?MODULE, ats2erlpre_cloref1_app, [Fserv, Chpos]),
%%
%%io:format("libats2erl_session_channeg_create: Chpos = ~p~n", [Chpos]),
%%io:format("libats2erl_session_channeg_create: Chneg = ~p~n", [Chneg]),
%%
  {Chpos, Chneg}.
%%
libats2erl_session_channeg_createnv
  (Fserv, Env) ->
  Chpos = spawn(?MODULE, libats2erl_session_chanpos_xfer, []),
  Chneg = spawn(?MODULE, ats2erlpre_cloref2_app, [Fserv, Env, Chpos]),
%%
%%io:format("libats2erl_session_channeg_createnv: Chpos = ~p~n", [Chpos]),
%%io:format("libats2erl_session_channeg_createnv: Chneg = ~p~n", [Chneg]),
%%
  {Chpos, Chneg}.
%%
%%%%%%
%%
%% HX-2015-07-04:
%% This is all for internal use!
%%
libats2erl_session_chanpos2_send
  (Chpos, X) ->
  libats2erl_session_chanpos_send(Chpos, X).
libats2erl_session_channeg2_recv
  (Chposneg, X) ->
  libats2erl_session_channeg_recv(Chposneg, X).
%%
libats2erl_session_chanpos2_recv
  (Chpos) -> libats2erl_session_chanpos_recv(Chpos).
libats2erl_session_channeg2_send
  (Chposneg) -> libats2erl_session_channeg_send(Chposneg).
%%
%%%%%%
%%
%% Service creation and request
%%
%%%%%%
%%
libats2erl_session_chansrvc_create
  (Fserv) ->
  spawn(
    ?MODULE
  , libats2erl_session_chansrvc_create_server, [Fserv]
  ). %% spawn
libats2erl_session_chansrvc_create_server
  (Fserv) ->
  receive
    {Client} ->
      Chposneg = libats2erl_session_channeg_create(Fserv),
      Client ! Chposneg,
      libats2erl_session_chansrvc_create_server(Fserv)
  end.
%%
libats2erl_session_chansrvc_request
  (Chsrvc) ->
  Chsrvc ! {self()},
  receive Chposneg = {_Chpos, _Chneg} -> Chposneg end.
%%
%% HX: For convenience: chansrvc2
%%
libats2erl_session_chansrvc2_create
  (Fserv) ->
  spawn(
    ?MODULE
  , libats2erl_session_chansrvc2_create_server, [Fserv]
  ). %% spawn
libats2erl_session_chansrvc2_create_server
  (Fserv) ->
  receive
    {Client, Env} ->
      Chposneg =
      libats2erl_session_channeg_createnv(Fserv, Env),
      Client ! Chposneg,
      libats2erl_session_chansrvc2_create_server(Fserv)
  end.
%%
libats2erl_session_chansrvc2_request
  (Env, Chsrvc) ->
  Chsrvc ! {self(), Env},
  receive Chposneg = {_Chpos, _Chneg} -> Chposneg end.
%%
%% HX: For registering (persistent) services
%%
libats2erl_session_chansrvc_register(Name, Ch) -> register(Name, Ch).
libats2erl_session_chansrvc2_register(Name, Ch) -> register(Name, Ch).
%%
%%%%%%

%%%%%% end of [basis_cats.hrl] %%%%%%
