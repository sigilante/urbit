import React, { Component, useEffect, useCallback } from 'react';
import { Route, Switch, RouteComponentProps } from 'react-router-dom';
import Helmet from 'react-helmet';

import './css/custom.css';

import { PatpNoSig } from '~/types/noun';
import GlobalApi from '~/logic/api/global';
import { StoreState } from '~/logic/store/type';
import { GroupsPane } from './components/GroupsPane';
import { Workspace } from '~/types';
import { NewGroup } from './components/NewGroup';
import { JoinGroup } from './components/JoinGroup';

import { cite } from '~/logic/lib/util';
import { Body } from '../components/Body';
import { Box } from '@tlon/indigo-react';
import { Loading } from '../components/Loading';


type LandscapeProps = StoreState & {
  ship: PatpNoSig;
  api: GlobalApi;
  subscription: GlobalSubscription;
}

export function DMRedirect(props: LandscapeProps & RouteComponentProps & { ship: string; }) {
  const { ship, api, history, graphKeys } = props;
  const goToGraph = useCallback((graph: string) => {
    history.push(`/~landscape/messages/resource/chat/ship/~${graph}`);
  }, [history]);

  useEffect(() => {
    const station = `${window.ship}/dm--${ship}`;
    const theirStation = `${ship}/dm--${window.ship}`;

    if (graphKeys.has(station)) {
      goToGraph(station);
      return;
    }

    if (graphKeys.has(theirStation)) {
      goToGraph(theirStation);
      return;
    }

    const aud = ship !== window.ship ? [`~${ship}`] : [];
    const title = `${cite(window.ship)} <-> ${cite(ship)}`;


    api.graph.createUnmanagedGraph(
      `dm--${ship}`,
      title,
      '',
      { invite: { pending: aud } },
      'chat'
    ).then(() => {
      goToGraph(station);
    });

  }, []);

  return (
    <Loading text="Creating DM" />
  );

}

export default class Landscape extends Component<LandscapeProps, {}> {
  componentDidMount() {
    this.props.subscription.startApp('groups');
    this.props.subscription.startApp('graph');
  }

  render() {
    const { props } = this;

    return (
      <>
        <Helmet defer={false}>
          <title>{ props.notificationsCount ? `(${String(props.notificationsCount) }) `: '' }Landscape</title>
        </Helmet>
        <Switch>
          <Route path="/~landscape/ship/:host/:name"
            render={routeProps => {
              const {
                host,
                name
              } = routeProps.match.params as Record<string, string>;
              const groupPath = `/ship/${host}/${name}`;
              const baseUrl = `/~landscape${groupPath}`;
              const ws: Workspace = { type: 'group', group: groupPath };

              return (
                <GroupsPane workspace={ws} baseUrl={baseUrl} {...props} />
              )
            }}/>
          <Route path="/~landscape/home"
            render={routeProps => {
              const ws: Workspace = { type: 'home' };
              return (
                <GroupsPane workspace={ws} baseUrl="/~landscape/home" {...props} />
              );
            }}
          />
          <Route path="/~landscape/messages"
            render={routeProps => {
              const ws: Workspace = { type: 'messages' };
              return (
                <GroupsPane workspace={ws} baseUrl="/~landscape/messages" {...props} />
              );
            }}
          />
          <Route path="/~landscape/new"
            render={routeProps=> {
              return (
                <Body>
                  <Box maxWidth="300px">
                    <NewGroup
                      associations={props.associations}
                      groups={props.groups}
                      contacts={props.contacts}
                      api={props.api}
                      {...routeProps}
                    />
                  </Box>
                </Body>
              );
            }}
          />
          <Route path='/~landscape/dm/:ship?'
          render={routeProps => {
            const { ship } = routeProps.match.params;
            return <DMRedirect {...routeProps} {...props} ship={ship} />
          }}
          />
          <Route path="/~landscape/join/:ship?/:name?"
            render={routeProps=> {
              const { ship, name } = routeProps.match.params;
              const autojoin = ship && name ? `${ship}/${name}` : null;
              return (
                <Body>
                  <Box maxWidth="300px">
                    <JoinGroup
                      groups={props.groups}
                      contacts={props.contacts}
                      api={props.api}
                      autojoin={autojoin}
                      {...routeProps}
                    />
                  </Box>
                </Body>
              );
            }}
          />
        </Switch>
      </>
    );
  }
}

