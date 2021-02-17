import { useEffect, useCallback } from "react";
import { Graphs, UnreadStats } from "~/types";
import { SidebarItemStatus, SidebarAppConfig } from "./types";



export function useGraphModule(
  graphKeys: Set<string>,
  graphs: Graphs,
  graphUnreads: Record<string, Record<string, UnreadStats>>
): SidebarAppConfig {
  const getStatus = useCallback(
    (s: string) => {
      const [, , host, name] = s.split("/");
      const graphKey = `${host.slice(1)}/${name}`;
      if (!graphKeys.has(graphKey)) {
        return "unsubscribed";
      }

      const unreads = graphUnreads?.[s]?.['/']?.unreads;
      if (typeof unreads === 'number' ? unreads > 0 : unreads?.size ?? 0 > 0) {
        return 'unread';
      }

      return undefined;
    },
    [graphs, graphKeys, graphUnreads]
  );

  const lastUpdated = useCallback((s: string) => {
    // cant get link timestamps without loading posts
    const last = graphUnreads?.[s]?.['/']?.last;
    if(last) {
      return last;
    }
    const stat = getStatus(s);
    if(stat === 'unsubscribed') {
      return 0;
    }
    return 1;

  }, [getStatus, graphUnreads]);

  return { getStatus, lastUpdated };
}
