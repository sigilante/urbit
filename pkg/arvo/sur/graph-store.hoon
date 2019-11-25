/-  *post
|%
+$  metagraph  (map path graph)
::
+$  graph  (map ship subgraph)
::
+$  subgraph  (map uid post)
::
+$  graph-action
  $%  [%create =path]
      [%subgraph =path =ship =subgraph]
      [%post =path =ship =post]
      [%delete =path]
      [%delete-subgraph =path =ship]
      [%delete-post =path =ship =uid]
  ==
::
+$  graph-initial
  $%  [%graphs =graphs]
      [%graph =path =graph]
      [%subgraph =path =ship =subgraph]
  ==
::
+$  graph-update
  $%  [%keys keys=(set path)]
      [%ships =path keys=(set ship)]
      graph-action
  ==
--
