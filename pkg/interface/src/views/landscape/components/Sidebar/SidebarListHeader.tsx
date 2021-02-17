import React, { useCallback } from "react";
import * as Yup from "yup";
import {
  Row,
  Box,
  Icon,
  ManagedRadioButtonField as Radio,
  ManagedCheckboxField as Checkbox,
  Col,
  Text,
} from "@tlon/indigo-react";
import { FormikOnBlur } from "~/views/components/FormikOnBlur";
import { Dropdown } from "~/views/components/Dropdown";
import { FormikHelpers } from "formik";
import { SidebarListConfig, Workspace } from "./types";
import { Link, useHistory } from 'react-router-dom';
import { getGroupFromWorkspace } from "~/logic/lib/workspace";
import { roleForShip } from "~/logic/lib/group";
import {Groups, Rolodex, Associations} from "~/types";
import { NewChannel } from "~/views/landscape/components/NewChannel";
import GlobalApi from "~/logic/api/global";

export function SidebarListHeader(props: {
  api: GlobalApi;
  initialValues: SidebarListConfig;
  associations: Associations;
  groups: Groups;
  contacts: Rolodex;
  baseUrl: string;
  selected: string;
  workspace: Workspace;
  handleSubmit: (c: SidebarListConfig) => void;
}) {

  const history = useHistory();
  const onSubmit = useCallback(
    (values: SidebarListConfig, actions: FormikHelpers<SidebarListConfig>) => {
      props.handleSubmit(values);
      actions.setSubmitting(false);
    },
    [props.handleSubmit]
  );

  const groupPath = getGroupFromWorkspace(props.workspace);
  const role = groupPath && props.groups?.[groupPath] ? roleForShip(props.groups[groupPath], window.ship) : undefined;
  const memberMetadata =
    groupPath ? props.associations.groups?.[groupPath].metadata.vip === 'member-metadata' : false;

  const isAdmin = memberMetadata || (role === "admin") || (props.workspace?.type === 'home') || (props.workspace?.type === "messages");

  const noun = (props.workspace?.type === "messages") ? "Messages" : "Channels";

  return (
    <Row
      flexShrink="0"
      alignItems="center"
      justifyContent="space-between"
      py={2}
      px={3}
      height='48px'
    >
      <Box flexShrink='0'>
        <Text>
          {props.initialValues.hideUnjoined ? `Joined ${noun}` : `All ${noun}`}
        </Text>
      </Box>
      <Box
        textAlign='right'
        display='flex'
        alignItems='center'
      >
        {props.workspace?.type === "messages"
        ? (
          <Dropdown
            flexShrink={0}
            dropWidth="300px"
            width="auto"
            alignY="top"
            alignX={["right", "left"]}
            options={
              <Col
                background="white"
                border={1}
                borderColor="washedGray"
              >
              <NewChannel
                api={props.api}
                history={props.history}
                associations={props.associations}
                contacts={props.contacts}
                groups={props.groups}
                workspace={props.workspace}
              />
              </Col>
            }
          >
           <Icon icon="Plus" color="gray" pr='12px'/>
          </Dropdown>
        )
        : (
       <Link style={{
          display: isAdmin ? "inline-block" : "none" }}
        to={!!groupPath
          ? `/~landscape${groupPath}/new`
          : `/~landscape/${props.workspace?.type}/new`}>
           <Icon icon="Plus" color="gray" pr='12px'/>
       </Link>
          )
        }
      <Dropdown
        flexShrink='0'
        width="auto"
        alignY="top"
        alignX={["right", "left"]}
        options={
          <FormikOnBlur initialValues={props.initialValues} onSubmit={onSubmit}>
            <Col bg="white" borderRadius={1} border={1} borderColor="lightGray">
              <Col
                gapY="2"
                borderBottom={1}
                borderBottomColor="washedGray"
                p={2}
              >
                <Box>
                  <Text color="gray">Sort Order</Text>
                </Box>
                <Radio mb="1" label="A -> Z" id="asc" name="sortBy" />
                <Radio label="Last Updated" id="lastUpdated" name="sortBy" />
              </Col>
              <Col px={2}>
                <Checkbox
                  my={3}
                  id="hideUnjoined"
                  label="Hide Unsubscribed Channels"
                />
              </Col>
            </Col>
          </FormikOnBlur>
        }
      >
        <Icon color="gray" icon="Adjust" />
      </Dropdown>
      </Box>
    </Row>
  );
}
