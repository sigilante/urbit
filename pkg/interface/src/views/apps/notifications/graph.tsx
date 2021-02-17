import React, { ReactNode, useCallback } from "react";
import moment from "moment";
import { Row, Box, Col, Text, Anchor, Icon, Action } from "@tlon/indigo-react";
import { Link, useHistory } from "react-router-dom";
import _ from "lodash";
import {
  Post,
  GraphNotifIndex,
  GraphNotificationContents,
  Associations,
  Content,
  Rolodex,
  Groups,
} from "~/types";
import { Header } from "./header";
import { cite, deSig, pluralize } from "~/logic/lib/util";
import { Sigil } from "~/logic/lib/sigil";
import RichText from "~/views/components/RichText";
import GlobalApi from "~/logic/api/global";
import ReactMarkdown from "react-markdown";
import { getSnippet } from "~/logic/lib/publish";
import styled from "styled-components";
import {MentionText} from "~/views/components/MentionText";
import ChatMessage, {MessageWithoutSigil} from "../chat/components/ChatMessage";

function getGraphModuleIcon(module: string) {
  if (module === "link") {
    return "Collection";
  }
  return _.capitalize(module);
}

const FilterBox = styled(Box)`
  background: linear-gradient(
    to bottom,
    transparent,
    ${(p) => p.theme.colors.white}
  );
`;

function describeNotification(description: string, plural: boolean) {
  switch (description) {
    case "link":
      return `added ${pluralize("new link", plural)} to`;
    case "comment":
      return `left ${pluralize("comment", plural)} on`;
    case "edit-comment":
      return `updated ${pluralize("comment", plural)} on`;
    case "note":
      return `posted ${pluralize("note", plural)} to`;
    case "edit-note":
      return `updated ${pluralize("note", plural)} in`;
    case "mention":
      return "mentioned you on";
    case "message":
      return `sent ${pluralize("message", plural)} to`;
    default:
      return description;
  }
}

const GraphUrl = ({ url, title }) => (
  <Box borderRadius="2" p="2" bg="scales.black05">
    <Anchor underline={false} target="_blank" color="black" href={url}>
      <Icon verticalAlign="bottom" mr="2" icon="ArrowExternal" />
      {title}
    </Anchor>
  </Box>
);

const GraphNodeContent = ({ group, post, contacts, mod, description, index, remoteContentPolicy }) => {
  const { contents } = post;
  const idx = index.slice(1).split("/");
  if (mod === "link") {
    if (idx.length === 1) {
      const [{ text }, { url }] = contents;
      return <GraphUrl title={text} url={url} />;
    } else if (idx.length === 3) {
      return <MentionText
        content={contents}
        contacts={contacts}
        group={group}
      />
    }
    return null;
  }
  if (mod === "publish") {
    if (idx[1] === "2") {
      return <MentionText
        content={contents}
        group={group}
        contacts={contacts}
        fontSize='14px'
        lineHeight="tall"
      />
    } else if (idx[1] === "1") {
      const [{ text: header }, { text: body }] = contents;
      const snippet = getSnippet(body);
      return (
        <Col>
          <Box mb="2" fontWeight="500">
            <Text>{header}</Text>
          </Box>
          <Box overflow="hidden" maxHeight="400px" position="relative">
            <Text lineHeight="tall">{snippet}</Text>
            <FilterBox
              width="100%"
              zIndex="1"
              height="calc(100% - 2em)"
              bottom="-4px"
              position="absolute"
            />
          </Box>
        </Col>
      );
    }
  }

  if(mod === 'chat') {
    return (
      <Row
        width="100%"
      flexShrink={0}
      flexGrow={1}
      flexWrap="wrap"
    >
      <MessageWithoutSigil
        containerClass="items-top cf hide-child"
        measure={() => {}}
        group={group}
        contacts={contacts}
        groups={{}}
        associations={{ graph: {}, groups: {}}}
        msg={post}
        fontSize='0'
        pt='2'
      />
    </Row>);

  }
  return null;
};

function getNodeUrl(mod: string, hidden: boolean, groupPath: string, graph: string, index: string) {
  if (hidden && mod === 'chat') {
    groupPath = '/messages';
  } else if (hidden) {
    groupPath = '/home';
  }
  const graphUrl = `/~landscape${groupPath}/resource/${mod}${graph}`;
  const idx = index.slice(1).split("/");
  if (mod === "publish") {
    const [noteId] = idx;
    return `${graphUrl}/note/${noteId}`;
  } else if (mod === "link") {
    const [linkId] = idx;
    return `${graphUrl}/${linkId}`;
  } else if (mod === 'chat') {
    return graphUrl;
  }
  return "";
}
const GraphNode = ({
  post,
  contacts,
  author,
  mod,
  description,
  time,
  index,
  graph,
  groupPath,
  group,
  read,
  onRead,
  showContact = false,
  remoteContentPolicy
}) => {
  const { contents } = post;
  author = deSig(author);
  const history = useHistory();

  const img = showContact ? (
    <Sigil
      ship={`~${author}`}
      size={16}
      icon
      color={`#000000`}
      classes="mix-blend-diff"
      padding={2}
    />
    ) : <Box style={{ width: '16px' }}></Box>;

  const groupContacts = contacts[groupPath] ?? {};

  const nodeUrl = getNodeUrl(mod, group?.hidden, groupPath, graph, index);

  const onClick = useCallback(() => {
    if(!read) {
      onRead();
    }
    history.push(nodeUrl);
  }, [read, onRead]);

  return (
    <Row onClick={onClick} gapX="2" pt={showContact ? 2 : 0}>
      <Col>{img}</Col>
      <Col flexGrow={1} alignItems="flex-start">
        {showContact && <Row
          mb="2"
          height="16px"
          alignItems="center"
          p="1"
          backgroundColor="white"
        >
          <Text mono title={author}>
            {cite(author)}
          </Text>
          <Text ml="2" gray>
            {moment(time).format("HH:mm")}
          </Text>
        </Row>}
        <Row width="100%" p="1" flexDirection="column">
          <GraphNodeContent
            contacts={groupContacts}
            post={post}
            mod={mod}
            description={description}
            index={index}
            group={group}
          />
        </Row>
      </Col>
    </Row>
  );
};

export function GraphNotification(props: {
  index: GraphNotifIndex;
  contents: GraphNotificationContents;
  archived: boolean;
  read: boolean;
  time: number;
  timebox: BigInteger;
  associations: Associations;
  groups: Groups;
  contacts: Rolodex;
  api: GlobalApi;
}) {
  const { contents, index, read, time, api, timebox, groups } = props;

  const authors = _.map(contents, "author");
  const { graph, group } = index;
  const icon = getGraphModuleIcon(index.module);
  const desc = describeNotification(index.description, contents.length !== 1);

  const onClick = useCallback(() => {
    if (props.archived || read) {
      return;
    }

    return api.hark["read"](timebox, { graph: index });
  }, [api, timebox, index, read]);

return (
    <>
      <Header
        onClick={onClick}
        archived={props.archived}
        time={time}
        read={read}
        authors={authors}
        moduleIcon={icon}
        channel={graph}
        contacts={props.contacts}
        group={group}
        description={desc}
        associations={props.associations}
      />
      <Box flexGrow={1} width="100%" pl={5} gridArea="main">
        {_.map(contents, (content, idx) => (
          <GraphNode
            post={content}
            author={content.author}
            contacts={props.contacts}
            mod={index.module}
            time={content?.["time-sent"]}
            description={index.description}
            index={content.index}
            graph={graph}
            group={groups[group]}
            groupPath={group}
            read={read}
            onRead={onClick}
            showContact={idx === 0}
          />
        ))}
      </Box>
    </>
  );
}
