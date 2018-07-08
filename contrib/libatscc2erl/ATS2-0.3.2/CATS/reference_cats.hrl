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
