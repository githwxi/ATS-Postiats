%%
%% Time of Generation:
%% Sat May 20 14:51:08 EDT 2017
%%

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
%%%%%%
%%
%% The Erlang code is generated by atscc2erl
%% The starting compilation time is: 2017-5-20: 14h:50m
%%
%%%%%%

%%fun%%
f_libats2erl_session_sslist_patsfun_5__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_libats2erl_session_sslist_patsfun_5(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
libats2erl_session_chanpos_list_nil(Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_chanpos_list_nil,
  libats2erl_session_chanpos2_send(Arg0, 0).
%} // end-of-function


%%fun%%
libats2erl_session_chanpos_list_cons(Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_chanpos_list_cons,
  libats2erl_session_chanpos2_send(Arg0, 1).
%} // end-of-function


%%fun%%
libats2erl_session_channeg_list(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret2
%% var Tmp3
%% var Tmp4
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_channeg_list,
  Tmp3 = libats2erl_session_channeg2_send(Arg0),
  Tmp4 = ats2erlpre_eq_int0_int0(Tmp3, 0),
  if
    Tmp4 ->
      0;
    %% if-then
    true ->
      1
    %% if-else
  end.
%} // end-of-function


%%fun%%
libats2erl_session_list2sslist(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret5
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list2sslist,
  libats2erl_session_channeg_create(f_libats2erl_session_sslist_patsfun_5__closurerize(Arg0)).
%} // end-of-function


%%fun%%
f_libats2erl_session_sslist_fserv_4(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp7
%% var Tmp8
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_sslist_fserv_4,
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
      libats2erl_session_chanpos_list_nil(Arg0),
      libats2erl_session_chanpos_nil_wait(Arg0);
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp7 = ?ATSSELcon(Arg1, 0),
      Tmp8 = ?ATSSELcon(Arg1, 1),
      libats2erl_session_chanpos_list_cons(Arg0),
      libats2erl_session_chanpos_send(Arg0, Tmp7),
      f_libats2erl_session_sslist_fserv_4(Arg0, Tmp8);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
f_libats2erl_session_sslist_patsfun_5(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_sslist_patsfun_5,
  f_libats2erl_session_sslist_fserv_4(Arg0, Env0).
%} // end-of-function


%%fun%%
libats2erl_session_sslist2list(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret13
%% var Tmp19
%% var Tmp20
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_sslist2list,
  Tmp20 = atscc2erl_null,
  Tmp19 = f_libats2erl_session_sslist_loop_7(Arg0, Tmp20),
  ats2erlpre_list_reverse(Tmp19).
%} // end-of-function


%%fun%%
f_libats2erl_session_sslist_loop_7(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret14
%% var Tmp15
%% var Tmp17
%% var Tmp18
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_sslist_loop_7,
  Tmp15 = libats2erl_session_channeg_list(Arg0),
  begin
  Casefunx1 =
  fun (Casefun, Tmplab) ->
    %switch(Tmplab) {
    case Tmplab of
      %% ATSbranchseq_beg
      1 ->
      if(not(?ATSCKpat_con0(Tmp15, 0))) -> Casefun(Casefun, 4); true ->
        Casefun(Casefun, 2)
      end;
      2 ->
      libats2erl_session_channeg_nil_close(Arg0),
      Arg1;
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp17 = libats2erl_session_channeg_send(Arg0),
      Tmp18 = {Tmp17, Arg1},
      f_libats2erl_session_sslist_loop_7(Arg0, Tmp18);
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
%% The starting compilation time is: 2017-5-20: 14h:50m
%%
%%%%%%

%%fun%%
libats2erl_session_chanpos_list(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret0
%% var Tmp1
%% var Tmp2
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_chanpos_list,
  Tmp1 = libats2erl_session_chanpos2_recv(Arg0),
  Tmp2 = ats2erlpre_eq_int0_int0(Tmp1, 0),
  if
    Tmp2 ->
      0;
    %% if-then
    true ->
      1
    %% if-else
  end.
%} // end-of-function


%%fun%%
libats2erl_session_channeg_list_nil(Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_channeg_list_nil,
  libats2erl_session_channeg2_recv(Arg0, 0).
%} // end-of-function


%%fun%%
libats2erl_session_channeg_list_cons(Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_channeg_list_cons,
  libats2erl_session_channeg2_recv(Arg0, 1).
%} // end-of-function

%%%%%%
%%
%% end-of-compilation-unit
%%
%%%%%%
%%%%%%
%%
%% The Erlang code is generated by atscc2erl
%% The starting compilation time is: 2017-5-20: 14h:50m
%%
%%%%%%

%%fun%%
f_libats2erl_session_ssarray_patsfun_5__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_libats2erl_session_ssarray_patsfun_5(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_libats2erl_session_ssarray_patsfun_8__closurerize(XEnv0) -> 
%{
  {fun({_, Cenv1}, XArg0) -> f_libats2erl_session_ssarray_patsfun_8(Cenv1, XArg0) end, XEnv0}.
%}


%%fun%%
f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__chanpos_arrsz(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_chanpos_arrsz,
  libats2erl_session_chanpos_send(Arg0, Arg1).
%} // end-of-function


%%fun%%
f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__channeg_arrsz(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret1
%% var Tmp2
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_channeg_arrsz,
  Tmp2 = libats2erl_session_channeg_send(Arg0),
  Tmp2.
%} // end-of-function


%%fun%%
f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__ssarray2list(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret3
%% var Tmp4
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_ssarray2list,
  Tmp4 = f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__ssarray2list_vt(Arg0, Arg1),
  Tmp4.
%} // end-of-function


%%fun%%
f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__list2ssarray(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret5
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list2ssarray,
  libats2erl_session_channeg_create(f_libats2erl_session_ssarray_patsfun_5__closurerize(Arg0)).
%} // end-of-function


%%fun%%
f_libats2erl_session_ssarray_fserv_4(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp7
%% var Tmp8
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_ssarray_fserv_4,
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
      libats2erl_session_chanpos_nil_wait(Arg0);
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp7 = ?ATSSELcon(Arg1, 0),
      Tmp8 = ?ATSSELcon(Arg1, 1),
      libats2erl_session_chanpos_send(Arg0, Tmp7),
      f_libats2erl_session_ssarray_fserv_4(Arg0, Tmp8);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
f_libats2erl_session_ssarray_patsfun_5(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_ssarray_patsfun_5,
  f_libats2erl_session_ssarray_fserv_4(Arg0, Env0).
%} // end-of-function


%%fun%%
f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__list2ssarray_vt(Arg0) ->
%{
%%
%% knd = 0
%% var Tmpret11
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_list2ssarray_vt,
  libats2erl_session_channeg_create(f_libats2erl_session_ssarray_patsfun_8__closurerize(Arg0)).
%} // end-of-function


%%fun%%
f_libats2erl_session_ssarray_fserv_7(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmp13
%% var Tmp14
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_ssarray_fserv_7,
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
      libats2erl_session_chanpos_nil_wait(Arg0);
      %% ATSbranchseq_end
      %% ATSbranchseq_beg
      3 ->
      Casefun(Casefun, 4);
      4 ->
      Tmp13 = ?ATSSELcon(Arg1, 0),
      Tmp14 = ?ATSSELcon(Arg1, 1),
      %% ATSINSfreecon(Arg1);,
      libats2erl_session_chanpos_send(Arg0, Tmp13),
      f_libats2erl_session_ssarray_fserv_7(Arg0, Tmp14);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
f_libats2erl_session_ssarray_patsfun_8(Env0, Arg0) ->
%{
%%
%% knd = 0
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_ssarray_patsfun_8,
  f_libats2erl_session_ssarray_fserv_7(Arg0, Env0).
%} // end-of-function


%%fun%%
f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__ssarray2list_vt(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret17
%% var Tmp18
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_ssarray2list_vt,
  Tmp18 = f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__channeg_array_takeout_list(Arg0, Arg1),
  libats2erl_session_channeg_nil_close(Arg0),
  Tmp18.
%} // end-of-function


%%fun%%
f_057_home_057_hwxi_057_Research_057_ATS_055_Postiats_057_contrib_057_CATS_055_atscc2erl_057_TEST_057_Sessiontype_057_SATS_057_array_056_sats__channeg_array_takeout_list(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret20
%% var Tmp30
%% var Tmp31
%% var Tmp32
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab_channeg_array_takeout_list,
  Tmp31 = atscc2erl_null,
  Tmp30 = f_libats2erl_session_ssarray_loop_12(Arg0, Arg1, Tmp31),
  Tmp32 = atscc2erl_null,
  f_libats2erl_session_ssarray_revapp_11(Tmp30, Tmp32).
%} // end-of-function


%%fun%%
f_libats2erl_session_ssarray_revapp_11(Arg0, Arg1) ->
%{
%%
%% knd = 0
%% var Tmpret21
%% var Tmp22
%% var Tmp23
%% var Tmp24
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_ssarray_revapp_11,
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
      Tmp22 = ?ATSSELcon(Arg0, 0),
      Tmp23 = ?ATSSELcon(Arg0, 1),
      %% ATSINSfreecon(Arg0);,
      Tmp24 = {Tmp22, Arg1},
      f_libats2erl_session_ssarray_revapp_11(Tmp23, Tmp24);
      %% ATSbranchseq_end
      _ -> atscc2erl_caseof_deadcode(?FILE, ?LINE)
    end %% endcase
    %} // end-of-switch
  end, %% endfun
  Casefunx1(Casefunx1, 1)
  end.
%} // end-of-function


%%fun%%
f_libats2erl_session_ssarray_loop_12(Arg0, Arg1, Arg2) ->
%{
%%
%% knd = 0
%% var Tmpret25
%% var Tmp26
%% var Tmp27
%% var Tmp28
%% var Tmp29
%% var Tmplab, Tmplab_erl
%%
  %% __patsflab__libats2erl_session_ssarray_loop_12,
  Tmp26 = ats2erlpre_gt_int1_int1(Arg1, 0),
  if
    Tmp26 ->
      Tmp27 = libats2erl_session_channeg_send(Arg0),
      Tmp28 = ats2erlpre_sub_int1_int1(Arg1, 1),
      Tmp29 = {Tmp27, Arg2},
      f_libats2erl_session_ssarray_loop_12(Arg0, Tmp28, Tmp29);
    %% if-then
    true ->
      Arg2
    %% if-else
  end.
%} // end-of-function

%%%%%%
%%
%% end-of-compilation-unit
%%
%%%%%%

%% ****** ****** %%

%% end of [mylibats2erl2_all.hrl] %%
