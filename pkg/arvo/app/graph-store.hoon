:: graph-store: data store that holds graph data
::
/-  *graph-store
|%
+$  move  [bone card]
::
+$  card
  $%  [%diff diff]
      [%quit ~]
  ==
::
+$  state
  $%  [%0 state-zero]
  ==
::
+$  state-zero
  $:  =metagraph
  ==
::
+$  diff
  $%  [%graph-initial graph-initial]
      [%graph-update graph-update]
  ==
--
::
|_  [bol=bowl:gall state]
::
++  this  .
::
++  prep
  |=  old=(unit state)
  ^-  (quip move _this)
  [~ ?~(old this this(+<+ u.old))]
::
::  +queries: return data via scry or subscription
::
++  peek-x-all
  |=  pax=path
  ^-  (unit (unit [%noun metagraph]))
  [~ ~ %noun metagraph]
::
++  peek-x-keys
  |=  pax=path
  ^-  (unit (unit [%noun (set path)]))
  [~ ~ %noun ~(key by metagraph)]
::
++  peek-x-graph
  |=  pax=path
  ^-  (unit (unit [%noun graph]))
  ?~  pax
    ~
  =/  graph  (~(get by metagraph) pax)
  ?~  graph
    ~
  [~ ~ %noun u.graph]
::
++  peek-x-subgraph
  |=  pax=path
  ^-  (unit (unit [%noun subgraph]))
  ::  /:path/:ship
  =/  index  (path-to-index pax)
  =/  graph  (~(get by metagraph) path.index)
  ?~  graph
    ~
  =/  thread  (~(get by u.graph) uid.index)
  ?~  thread
    ~
  [~ ~ %noun u.thread]
::
++  peek-x-post
  |=  pax=path
  ^-  (unit (unit [%noun post]))
  ::  /:path/:ship/:uid
  =/  index  (path-to-index pax)
  =/  graph  (~(get by metagraph) path.index)
  ?~  graph
    ~
  =/  thread  (~(get by u.graph) uid.index)
  ?~  thread
    ~
  [~ ~ %noun u.thread]
::
++  peer-keys
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ::  we send the list of keys then send events when they change
  :_  this
  [ost.bol %diff %graph-update [%keys ~(key by metagraph)]]~
::
++  peer-metagraph
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  :_  this
  [ost.bol %diff %graph-initial [%metagraph metagraph]]~
::
++  peer-updates
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ::  we now proxy all events to this path
  [~ this]
::
++  peer-graph
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ?~  pax
    !!
  =/  graph  (~(got by metagraph) pax)
  :_  this
  [ost.bol %diff %graph-initial [%graph graph]]~
::
++  peer-subgraph
  |=  pax=path
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ?~  pax
    !!
  =/  graph  (~(got by metagraph) pax)
  =/  subgraph  (~(got by graph) ship)
  :_  this
  [ost.bol %diff %graph-initial [%subgraph graph]]~
::
::  +actions: handle actions, update state, and send diffs
::
++  poke-graph-action
  |=  action=graph-action
  ^-  (quip move _this)
  ?>  (team:title our.bol src.bol)
  ?-  -.action
      %create        (handle-create +.action)
      %graph         (handle-graph +.action)
      %post          (handle-post +.action)
      %delete        (handle-delete +.action)
      %delete-graph  (handle-delete-graph +.action)
      %delete-post   (handle-delete-post +.action)
  ==
::
++  handle-create
  |=  =path
  ^-  (quip move _this)
  ?:  (~(has by metagraph) path)
    [~ this]
  :-  (send-diff path *ship [%create path])
  this(metagraph (~(put by metagraph) path *graph))
::
++  handle-graph
  |=  [=path =ship =subgraph]
  ^-  (quip move _this)
  ?.  (~(has by metagraph) path)
    [~ this]
  =/  graph  (~(got by metagraph) path)
  ?:  (~(has by graph) ship)
    [~ this]
  =.  graph  (~(put by graph) ship subgraph)
  :-  (send-diff path ship [%graph path ship subgraph])
  this(metagraph (~(put by metagraph) path graph))
::
++  handle-post
  |=  [=path =post]
  ^-  (quip move _this)
  ?.  (~(has by metagraph) path)
    [~ this]
  =/  =graph  (~(got by metagraph) path)
  ?:  (~(has by graph) uid.post)
    [~ this]
  ::
  :-  (send-diff path author.post uid.post [%post path post])
  ?~  (~(has by graph) author.post)
    =/  subgraph  (~(put by *subgraph) uid.post post)
    =.  graph  (~(put by graph) author.post subgraph)
    this(metagraph (~(put by metagraph) path graph))
  ::
  =/  subgraph  (~(got by graph) author.post)
  =.  subgraph  (~(put by subgraph) uid.post post)
  =.  graph  (~(put by graph) author.post subgraph)
  ?~  parent.post
    this(metagraph (~(put by metagraph) path graph))
  ::
  =/  parent-post  (~(get by subgraph) u.parent.post)
  ?~  parent-post
    this(metagraph (~(put by metagraph) path graph))
  =.  children.u.parent-post  (snoc children.u.parent-post uid.post)
  =.  subgraph  (~(put by subgraph) uid.u.parent-post u.parent-post)
  =.  graph  (~(put by graph) author.post subgraph)
  this(metagraph (~(put by metagraph) path graph))
::
++  handle-delete
  |=  =path
  ^-  (quip move _this)
  ?.  (~(has by metagraph) path)
    [~ this]
  :_  this(metagraph (~(del by metagraph) path))
  (send-diff path *ship [%delete path])
::
++  handle-delete-graph
  |=  [=path =ship]
  ^-  (quip move _this)
  =/  graph  (~(get by metagraph) path)
  ?~  graph
    [~ this]
  ?.  (~(has by u.graph) ship)
    [~ this]
  =.  u.graph  (~(del by u.graph) ship)
  :-  (send-diff path ship [%delete-graph path ship])
  this(metagraph (~(put by metagraph) path u.graph))
::
++  handle-delete-post
  |=  [=path =ship =uid]
  ^-  (quip move _this)
  =/  graph  (~(get by metagraph) path)
  ?~  graph
    [~ this]
  =/  subgraph  (~(get by u.graph) ship)
  ?~  subgraph
    [~ this]
  ?.  (~(has by u.subgraph) uid)
    [~ this]
  =.  u.subgraph  (~(del by u.subgraph) uid)
  =.  u.graph  (~(put by u.graph) ship u.subgraph)
  :_  this(metagraph (~(put by metagraph) path u.graph))
  (send-diff path ship [%delete-post path ship uid])
::
::  +utilities
::
++  update-subscribers
  |=  [pax=path act=graph-action]
  ^-  (list move)
  %+  turn  (prey:pubsub:userlib pax bol)
  |=  [=bone *]
  [bone %diff %graph-update act]
::
++  send-diff
  |=  [pax=path =ship act=graph-action]
  ^-  (list move)
  ::  TODO: write a real version of this
  %-  zing
  :~  (update-subscribers /metagraph act)
      (update-subscribers /updates act)
      (update-subscribers /keys act)
      (update-subscribers [%updates pax] act)
      (update-subscribers [%graph pax] act)
      (update-subscribers [%subgraph pax ship] act)
  ==
--
