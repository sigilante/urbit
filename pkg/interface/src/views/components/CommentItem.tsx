import React, { useState } from 'react';
import { Link } from "react-router-dom";
import { Contacts } from '~/types/contact-update';
import GlobalApi from '~/logic/api/global';
import { Box, Row, Text } from '@tlon/indigo-react';
import styled from 'styled-components';
import Author from '~/views/components/Author';
import { GraphNode, TextContent } from '~/types/graph-update';
import tokenizeMessage from '~/logic/lib/tokenizeMessage';
import { Group } from '~/types';
import { MentionText } from '~/views/components/MentionText';
import { getLatestCommentRevision } from '~/logic/lib/publish';

const ClickBox = styled(Box)`
  cursor: pointer;
  padding-left: ${p => p.theme.space[2]}px;
`;

interface CommentItemProps {
  pending?: boolean;
  comment: GraphNode;
  baseUrl: string;
  contacts: Contacts;
  unread: boolean;
  name: string;
  ship: string;
  api: GlobalApi;
  group: Group;
}

export function CommentItem(props: CommentItemProps) {
  const { ship, contacts, name, api, comment, group } = props;
  const [revNum, post] = getLatestCommentRevision(comment);
  const disabled = props.pending || window.ship !== post?.author;

  const onDelete = async () => {
    await api.graph.removeNodes(ship, name, [comment.post?.index]);
  };

  const commentIndexArray = (comment.post?.index || '/').split('/');
  const commentIndex = commentIndexArray[commentIndexArray.length - 1];
  const updateUrl = `${props.baseUrl}/${commentIndex}`

  return (
    <Box mb={4} opacity={post?.pending ? '60%' : '100%'}>
      <Row bg="white" my={3}>
        <Author
          showImage
          contacts={contacts}
          ship={post?.author}
          date={post?.['time-sent']}
          unread={props.unread}
          group={group}
          api={api}
        >
          {!disabled && (
            <Box display="inline-block" verticalAlign="middle">
              <Link to={updateUrl}>
                <Text
                  color="green"
                  ml={2}
                >
                  Update
                </Text>
              </Link>
              <ClickBox display="inline-block" color="red" onClick={onDelete}>
                <Text color='red'>Delete</Text>
              </ClickBox>
            </Box>
          )}
        </Author>
      </Row>
      <Box mb={2}>
        <MentionText
          contacts={contacts}
          group={group}
          content={post?.contents}
        />
      </Box>
    </Box>
  );
}

export default CommentItem;
