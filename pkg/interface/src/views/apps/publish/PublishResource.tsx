import React from "react";
import { Box } from "@tlon/indigo-react";

import GlobalApi from "~/logic/api/global";
import { StoreState } from "~/logic/store/type";
import { Association } from "~/types";
import { RouteComponentProps } from "react-router-dom";
import { NotebookRoutes } from "./components/NotebookRoutes";

type PublishResourceProps = StoreState & {
  association: Association;
  api: GlobalApi;
  baseUrl: string;
} & RouteComponentProps;

export function PublishResource(props: PublishResourceProps) {
  const { association, api, baseUrl, notebooks } = props;
  const rid = association.resource;
  const [, , ship, book] = rid.split("/");
  const notebookContacts = props.contacts[association.group];

  return (
    <Box height="100%" width="100%" overflowY="auto">
      <NotebookRoutes
        api={api}
        ship={ship}
        book={book}
        contacts={props.contacts}
        groups={props.groups}
        associations={props.associations}
        association={association}
        notebookContacts={notebookContacts}
        rootUrl={baseUrl}
        baseUrl={`${baseUrl}/resource/publish/ship/${ship}/${book}`}
        history={props.history}
        match={props.match}
        location={props.location}
        unreads={props.unreads}
        graphs={props.graphs}
        s3={props.s3}
      />
    </Box>
  );
}
