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
%% HX: A channel is a pair of chques
%%
libats2erl_session_channeg_create
  (Fserv) ->
  Chq0 = libats2erl_session_chque(),
  Chq1 = libats2erl_session_chque(),
  Chpos = libats2erl_session_chanpos(Chq0, Chq1),
  Chneg = libats2erl_session_channeg(Chq0, Chq1),
  _Server_ = spawn(?MODULE, ats2erlpre_cloref1_app, [Fserv, Chpos]),
%%
%%io:format("libats2erl_session_channeg_create: Chpos = ~p~n", [Chpos]),
%%io:format("libats2erl_session_channeg_create: Chneg = ~p~n", [Chneg]),
%%
  Chneg.
%%
libats2erl_session_channeg_createnv
  (Fserv, Env) ->
  Chq0 = libats2erl_session_chque(),
  Chq1 = libats2erl_session_chque(),
  Chpos = libats2erl_session_chanpos(Chq0, Chq1),
  Chneg = libats2erl_session_channeg(Chq0, Chq1),
  _Server_ = spawn(?MODULE, ats2erlpre_cloref2_app, [Fserv, Env, Chpos]),
%%
%%io:format("libats2erl_session_channeg_createnv: Chpos = ~p~n", [Chpos]),
%%io:format("libats2erl_session_channeg_createnv: Chneg = ~p~n", [Chneg]),
%%
  Chneg.
%%
%%%%%%
%%
libats2erl_session_chque() ->
  spawn(
    ?MODULE, libats2erl_session_chque_server, []
  ). %% spawn
libats2erl_session_chque_server() ->
  receive
    {Client, chque_remove} ->
      receive
        {_, chque_close} ->
          Client !
          {self(), {chque_close}}; %% terminated
        {_, chque_insert, X} ->
          Client !
          {self(), {chque_insert, X}},
          libats2erl_session_chque_server();
	{_, chque_qinsert, Chq} ->
          Client ! {self(), {chque_qinsert, Chq}} %% terminated
      end
  end.
%%
libats2erl_session_chque_remove
  (Chque) ->
  Chque ! {self(), chque_remove},
  receive {Chque, Opt} -> Opt end.
%%
libats2erl_session_chque_remove_close
  (Chque) ->
  Chque ! {self(), chque_remove},
  receive
    {Chque, Opt} ->
    case Opt of
      {chque_close} -> atscc2erl_void;
      {chque_qinsert, Chque2} -> libats2erl_session_chque_remove_close(Chque2)
    end
  end.
%%
libats2erl_session_chque_close
  (Chque) -> Chque ! {self(), chque_close}.
libats2erl_session_chque_insert
  (Chque, X) -> Chque ! {self(), chque_insert, X}.
libats2erl_session_chque_qinsert
  (Chque, X) -> Chque ! {self(), chque_qinsert, X}.
%%
%%%%%%
%%
%% HX: For positive channel
%%
%%%%%%
%%
libats2erl_session_chanpos
  (Chq0, Chq1) ->
  spawn(
    ?MODULE, libats2erl_session_chanpos_server, [Chq0, Chq1]
  ). %% spawn
libats2erl_session_chanpos_server
  (Chq0, Chq1) ->
  receive
    {_, chanpos_send, X} ->
      %% Asynchronous
      libats2erl_session_chque_insert(Chq0, X),
      libats2erl_session_chanpos_server(Chq0, Chq1);
    {Client, chanpos_recv} ->
      libats2erl_session_chanpos_server_recv(Chq0, Chq1, Client);
    {Client, chanposneg_link} -> Client ! {self(), {Chq0, Chq1}}
  end.
libats2erl_session_chanpos_server_recv
  (Chq0, Chq1, Client) ->
  Opt =
  libats2erl_session_chque_remove(Chq1),
  case Opt of
    {chque_close} -> %% Chq1 terminated
      Client ! {self()},
      libats2erl_session_chque_close(Chq0);
    {chque_insert, X} ->
      Client ! {self(), X},
      libats2erl_session_chanpos_server(Chq0, Chq1);
    {chque_qinsert, Chq1_2} -> %% Chq1 terminated
      libats2erl_session_chanpos_server_recv(Chq0, Chq1_2, Client)
  end.
%%
libats2erl_session_chanpos_send
  (Chpos, X) ->
  %%Asynchronous
  Chpos ! {self(), chanpos_send, X}.
libats2erl_session_chanpos_recv(Chpos) ->
  Chpos ! {self(), chanpos_recv}, receive {Chpos, X} -> X end.
libats2erl_session_chanpos_nil_wait(Chpos) ->
  Chpos ! {self(), chanpos_recv}, receive {Chpos} -> atscc2erl_void end.
%%
%%%%%%
%%
%% HX: For negative channel
%%
%%%%%%
%%
libats2erl_session_channeg
  (Chq0, Chq1) ->
  spawn(
    ?MODULE, libats2erl_session_channeg_server, [Chq0, Chq1]
  ). %% spawn
libats2erl_session_channeg_server
  (Chq0, Chq1) ->
  receive
    {_, channeg_recv, X} ->
      %% Asynchronous
      libats2erl_session_chque_insert(Chq1, X),
      libats2erl_session_channeg_server(Chq0, Chq1);
    {Client, channeg_send} ->
      libats2erl_session_channeg_server_send(Chq0, Chq1, Client);
    {Client, channeg_close} -> Client ! {self(), {Chq0, Chq1}};
    {Client, chanposneg_link} -> Client ! {self(), {Chq0, Chq1}}
  end.
libats2erl_session_channeg_server_send
  (Chq0, Chq1, Client) ->
  Opt =
  libats2erl_session_chque_remove(Chq0),
  case Opt of
    {chque_insert, X} ->
      Client ! {self(), X},
      libats2erl_session_channeg_server(Chq0, Chq1);
    {chque_qinsert, Chq0_2} -> %% Chq0 terminated
      libats2erl_session_channeg_server_send(Chq0_2, Chq1, Client)
  end.
%%
libats2erl_session_channeg_recv
  (Chneg, X) ->
  %%Asynchronous
  Chneg!{self(), channeg_recv, X}, atscc2erl_void.
libats2erl_session_channeg_send(Chneg) ->
  Chneg!{self(), channeg_send}, receive {Chneg, X} -> X end.
%%
libats2erl_session_channeg_nil_close(Chneg) ->
  Chneg!{self(), channeg_close},
  receive {Chneg, {Chq0, Chq1}} ->
    libats2erl_session_chque_close(Chq1), libats2erl_session_chque_remove_close(Chq0)
  end.
%%
%%%%%%
%%
%% HX: chanposneg_link is crucial!!!
%%
%%%%%%
%%
libats2erl_session_chanposneg_link
  (Chpos, Chneg) ->
  Chpos ! {self(), chanposneg_link},
  {Chqx0, Chqx1} = receive {Chpos, XX} -> XX end,
  Chneg ! {self(), chanposneg_link},
  {Chqy0, Chqy1} = receive {Chneg, YY} -> YY end,
  libats2erl_session_chque_qinsert(Chqx0, Chqy0),
  libats2erl_session_chque_qinsert(Chqy1, Chqx1),
  atscc2erl_void.
%%
%%%%%%
%%
%% HX-2015-07-04:
%% This is all for internal use!
%%
%%%%%%
%%
libats2erl_session_chanpos2_send
  (Chpos, X) ->
  libats2erl_session_chanpos_send(Chpos, X).
libats2erl_session_channeg2_recv
  (Chneg, X) ->
  libats2erl_session_channeg_recv(Chneg, X).
%%
libats2erl_session_chanpos2_recv
  (Chpos) -> libats2erl_session_chanpos_recv(Chpos).
libats2erl_session_channeg2_send
  (Chneg) -> libats2erl_session_channeg_send(Chneg).
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
      Chneg = libats2erl_session_channeg_create(Fserv),
      Client ! {self(), Chneg},
      libats2erl_session_chansrvc_create_server(Fserv)
  end.
%%
libats2erl_session_chansrvc_request
  (Chsrvc) ->
  Chsrvc ! {self()},
  receive {_Chsrvc_, Chneg} -> Chneg end.
%%
libats2erl_session_chansrvc_register
  (Service_name, Chsrvc) -> register(Service_name, Chsrvc).
%%
%%%%%%
%%
%% HX: For convenience: chansrvc2
%%
%%%%%%
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
      Chneg =
      libats2erl_session_channeg_createnv(Fserv, Env),
      Client ! {self(), Chneg},
      libats2erl_session_chansrvc2_create_server(Fserv)
  end.
%%
libats2erl_session_chansrvc2_request
  (Env, Chsrvc) ->
  Chsrvc ! {self(), Env},
  receive {_Chsrvc_, Chneg} -> Chneg end.
%%
libats2erl_session_chansrvc2_register
  (Service_name, Chsrvc) -> register(Service_name, Chsrvc).
%%
%%%%%% end of [basis2_cats.hrl] %%%%%%
