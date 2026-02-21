import * as serverQueryStore from '@sanity/react-loader';
import {
  type QueryParams,
  type UseQueryOptionsDefinedInitial,
} from '@sanity/react-loader';

import Query from '@/sanity/lib/query';
import { clientQueryStore } from '@/sanity/loader/client-query-store';

export function useQuery<Input extends QueryParams, Output>(
  query: Query<Input, Output>,
  params: Input,
  options?: UseQueryOptionsDefinedInitial<Output>,
  clientOnly?: boolean,
) {
  return useRawQuery<Output>(query.query, params, options, clientOnly);
}

/**
 * Exports to be used in client-only or components that render both server and client
 */
export const useRawQuery = <
  QueryResponseResult = unknown,
  QueryResponseError = unknown,
>(
  query: string,
  params?: QueryParams,
  options?: UseQueryOptionsDefinedInitial<QueryResponseResult>,
  clientOnly?: boolean,
) => {
  const queryStore = clientOnly ? clientQueryStore : serverQueryStore;
  const snapshot = queryStore.useQuery<QueryResponseResult, QueryResponseError>(
    query,
    params,
    options,
  );

  // Always throw errors if there are any
  if (snapshot.error) {
    throw snapshot.error;
  }

  return snapshot;
};
