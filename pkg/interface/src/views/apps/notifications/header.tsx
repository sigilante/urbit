import React from "react";
import { Text as NormalText, Row, Icon, Rule, Box } from "@tlon/indigo-react";
import f from "lodash/fp";
import _ from "lodash";
import moment from "moment";
import { PropFunc } from "~/types/util";
import { getContactDetails, useShowNickname } from "~/logic/lib/util";
import { Associations, Contact, Contacts, Rolodex } from "~/types";

const Text = (props: PropFunc<typeof Text>) => (
  <NormalText fontWeight="500" {...props} />
);

function Author(props: { patp: string; contacts: Contacts; last?: boolean }) {
  const contact: Contact | undefined = props.contacts?.[props.patp];

  const showNickname = useShowNickname(contact);
  const name = contact?.nickname || `~${props.patp}`;

  return (
    <Text mono={!showNickname}>
      {name}
      {!props.last && ", "}
    </Text>
  );
}

export function Header(props: {
  authors: string[];
  archived?: boolean;
  channel?: string;
  group: string;
  contacts: Rolodex;
  description: string;
  moduleIcon?: string;
  time: number;
  read: boolean;
  associations: Associations;
} & PropFunc<typeof Row> ) {
  const { description, channel, group, moduleIcon, read } = props;
  const contacts = props.contacts[group] || {};

  const authors = _.uniq(props.authors);

  const authorDesc = f.flow(
    f.take(3),
    f.entries,
    f.map(([idx, p]: [string, string]) => {
      const lent = Math.min(3, authors.length);
      const last = lent - 1 === parseInt(idx, 10);
      return <Author key={idx} contacts={contacts} patp={p} last={last} />;
    }),
    (auths) => (
      <React.Fragment>
        {auths}

        {authors.length > 3 &&
          ` and ${authors.length - 3} other${authors.length === 4 ? "" : "s"}`}
      </React.Fragment>
    )
  )(authors);

  const time = moment(props.time).format("HH:mm");
  const groupTitle =
    props.associations.groups?.[props.group]?.metadata?.title;

  const app = 'graph';
  const channelTitle =
    (channel && props.associations?.[app]?.[channel]?.metadata?.title) ||
    channel;

  return (
    <Row onClick={props.onClick} p="2" flexWrap="wrap" alignItems="center" gridArea="header">
      {!props.archived && (
        <Icon
          display="block"
          opacity={read ? 0 : 1}
          mr={2}
          icon="Bullet"
          color="blue"
        />
      )}
      <Text mr="1" mono>
        {authorDesc}
      </Text>
      <Text mr="1">{description}</Text>
      {!!moduleIcon && <Icon icon={moduleIcon as any} mr={1} />}
      {!!channel && <Text fontWeight="500" mr={1}>{channelTitle}</Text>}
      <Rule vertical height="12px" mr={1} />
      {groupTitle &&
         <>
          <Text fontWeight="500" mr={1}>{groupTitle}</Text>
          <Rule vertical height="12px" mr={1} />
        </>
      }
      <Text fontWeight="regular" color="lightGray">
        {time}
      </Text>
    </Row>
  );
}
