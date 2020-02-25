/-  *metadata-store
|%
++  nu                                              ::  parse number as hex
  |=  jon/json
  ?>  ?=({$s *} jon)
  (rash p.jon hex)
::
++  rolodex-to-json
  |=  rolo=rolodex
  =,  enjs:format
  ^-  json
  %+  frond  %contact-initial
  %-  pairs
  %+  turn  ~(tap by rolo)
  |=  [pax=^path =contacts]
  ^-  [cord json]
  :-  (spat pax)
  (contacts-to-json contacts)
::
++  contacts-to-json
  |=  con=contacts
  ^-  json
  =,  enjs:format
  %-  pairs
  %+  turn  ~(tap by con)
  |=  [shp=^ship =contact]
  ^-  [cord json]
  :-  (crip (slag 1 (scow %p shp)))
  (contact-to-json contact)
::
++  contact-to-json
  |=  con=contact
  ^-  json
  =,  enjs:format
  %-  pairs
  :~  [%nickname s+nickname.con]
      [%email s+email.con]
      [%phone s+phone.con]
      [%website s+website.con]
      [%notes s+notes.con]
      [%color s+(scot %ux color.con)]
      [%avatar s+'TODO']
  ==
::
++  update-to-json
  |=  upd=contact-update
  =,  enjs:format
  ^-  json
  %+  frond  %contact-update
  %-  pairs
  :~
    ?:  ?=(%create -.upd)
      [%create (pairs [%path (path path.upd)]~)]
    ?:  ?=(%delete -.upd)
      [%delete (pairs [%path (path path.upd)]~)]
    ?:  ?=(%add -.upd)
      :-  %add
      %-  pairs
      :~  [%path (path path.upd)]
          [%ship (ship ship.upd)]
          [%contact (contact-to-json contact.upd)]
      ==
    ?:  ?=(%remove -.upd)
      :-  %remove
      %-  pairs
      :~  [%path (path path.upd)]
          [%ship (ship ship.upd)]
      ==
    ?:  ?=(%edit -.upd)
      :-  %edit
      %-  pairs
      :~  [%path (path path.upd)]
          [%ship (ship ship.upd)]
          [%edit-field (edit-to-json edit-field.upd)]
      ==
    [*@t *^json]
  ==
--
