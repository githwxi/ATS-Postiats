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
%% HX: A channel is a list of chques
%%
libats2erl_session_mchannel_create3
  (Fserv) ->
  Chq0 = libats2erl_session_chque(),
  Chq1 = libats2erl_session_chque(),
  Chq2 = libats2erl_session_chque(),
  Chqlst = [Chq0, Chq1, Chq2],
  Chan0 = libats2erl_session_mchannel(0, Chqlst),
  Chan1 = libats2erl_session_mchannel(1, Chqlst),
  Chan2 = libats2erl_session_mchannel(2, Chqlst),
  Chanlst = [Chan1, Chan2],
  _Server_ = spawn(?MODULE, ats2erlpre_cloref1_app, [Fserv, Chan0]),
%%
%%io:format("libats2erl_session_channeg_create: Chan0 = ~p~n", [Chan0]),
%%io:format("libats2erl_session_channeg_create: Chanlst = ~p~n", [Chanlst]),
%%
  Chanlst
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
        {_, chque_close, Id} ->
          Client !
          {self(), {chque_close, Id}}; %% terminate
        {_, chque_insert, Id, X} ->
          Client !
          {self(), {chque_insert, Id, X}},
          libats2erl_session_chque_server(); %% continue
      end
  end.
%%
libats2erl_session_chque_remove
  (Chq) ->
  Chq ! {self(), chque_remove},
  receive {Chq, Opt} -> Opt end.
%%
libats2erl_session_chque_close
  (Chq, Id) -> Chq ! {self(), chque_close, Id}.
libats2erl_session_chque_insert
  (Chq, Id, X) -> Chq ! {self(), chque_insert, Id, X}.
%%
%%%%%%
%
% HX: Channels for session-communication
%
%%%%%%
%%
libats2erl_session_mchannel
  (Chqs, Id) ->
  spawn(
    ?MODULE, libats2erl_session_mchannel_server, [Chqs, Id]
  ). %% spawn
libats2erl_session_mchannel_server
  (Chqs, Id) ->
  receive
    {_, channel_close} ->
      %% Asynchronous
      libats2erl_session_chque_close(Chqs, Id),
      libats2erl_session_chque_remove_close(Chqs, Id);
    {_, channel_send, Id2, X} ->
      %% Asynchronous
      Chq2 = element(Id2+1, Chqs),
      libats2erl_session_chque_insert(Chq2, Id, X),
      libats2erl_session_mchannel_server(Chqs, Id);
    {Client, channel_recv, Id1} ->
      libats2erl_session_mchannel_server_recv(Chqs, Id, Client, Id1)
  end.
libats2erl_session_mchannel_server_recv
  (Chqs, Id, Client, Id1) ->
  Chq = element(Id+1, Chqs),
  Opt =
  libats2erl_session_chque_remove(Chq),
  case Opt of
    {chque_close, Id1} -> %% Chq terminated
      Client ! {self()},
      libats2erl_session_chque_close(Chq0);
    {chque_insert, Id1, X} ->
      Client ! {self(), X},
      libats2erl_session_channel_server(Chqs, Id);
  end.
%%
libats2erl_session_channel_send
  (Chan, Id1, Id2, X) ->
  %%Asynchronous
  Chan!{self(), channel_send, Id2, X}.
libats2erl_session_channel_recv
  (Chan, Id1, Id2) ->
  Chan!{self(), channel_recv, Id1}, receive {Chan, X} -> X end.
libats2erl_session_channel_nil_wait
  (Chan, Id1) ->
  Chan!{self(), channel_recv, Id1},
  receive {Chan} -> atscc2erl_void end.
libats2erl_session_channel_nil_close
  (Chan, Id1) ->
  Chan!{self(), channel_close}, receive {Chan, Chqs} -> atscc2erl_void end.
%%
