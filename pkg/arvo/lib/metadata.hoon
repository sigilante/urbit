::  metadata: helpers for getting data from the metadata-store
::
/-  store=metadata-store
/+  resource, grpl=group
::
|_  =bowl:gall
+*  grp  ~(. grpl bowl)
::
++  get-preview
  |=  rid=resource
  |^  ^-  group-preview:store
  ?>  (can-join:grp rid src.bowl)
  =/  members
    ~(wyt in (members:grp rid))
  =/  =metadatum:store
    %-  need
    %+  mate  (peek-metadatum %groups rid)
    (peek-metadatum %graph rid)
  [rid channels members channel-count metadatum]
  ::
  ++  channels
    %-  ~(gas by *associations:store)
    %+  scag  5  
    %+  skim  ~(tap by (app-metadata-for-group rid %graph))
    |=([=md-resource:store group=resource =metadatum:store] preview.metadatum)
  ::   
  ++  channel-count
    ~(wyt by (app-metadata-for-group rid %graph))
  --
::
++  resource-for-update
  |=  =vase
  ^-  (list resource)
  =/  =update:store  !<(update:store vase)
  ?.  ?=(?(%add %remove %initial-group) -.update)  ~
  ~[group.update]
::  
++  app-paths-from-group
  |=  [=app-name:store group=resource]
  ^-  (list resource)
  %+  murn
    %~  tap  in
    =-  (~(gut by -) group ~)
    .^  (jug resource md-resource:store)
      %gy
      (scot %p our.bowl)
      %metadata-store
      (scot %da now.bowl)
      /group-indices
    ==
  |=  =md-resource:store
  ^-  (unit resource)
  ?.  =(app-name.md-resource app-name)  ~
  `resource.md-resource
::
++  app-metadata-for-group
  |=  [group=resource =app-name:store]
  =/  =associations:store
    (metadata-for-group group)
  %-  ~(gas by *associations:store)
  %+  skim  ~(tap by associations)
  |=  [=md-resource:store association:store]
  =(app-name app-name.md-resource)
::
++  metadata-for-group
  |=  group=resource
  .^  associations:store
    %gx  (scot %p our.bowl)  %metadata-store  (scot %da now.bowl)
    %group  (snoc (en-path:resource group) %noun)
  ==
::
++  md-resources-from-group
  |=  group=resource
  =-  (~(get ju -) group)
  .^  (jug resource md-resource:store)
    %gy
    (scot %p our.bowl)
    %metadata-store
    (scot %da now.bowl)
    /group-indices
  ==
::
++  peek-association
  |=  [app-name=term rid=resource]
  .^  (unit association:store)
    %gx  (scot %p our.bowl)  %metadata-store  (scot %da now.bowl)
    %metadata  app-name  (snoc (en-path:resource rid) %noun)
  ==
::
++  peek-metadatum
  |=  =md-resource:store
  %+  bind  (peek-association md-resource)
  |=(association:store metadatum)
::
++  peek-group
  |=  =md-resource:store
  ^-  (unit resource)
  %+  bind  (peek-association md-resource)
  |=(association:store group)
--
