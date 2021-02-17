import React, { useMemo, useState } from 'react';
import {
  Box,
  Text,
  Label,
  Row,
  Col,
  Icon,
  ErrorLabel
} from '@tlon/indigo-react';
import _ from 'lodash';
import { useField, useFormikContext, FieldArray } from 'formik';
import styled from 'styled-components';

import { roleForShip } from '~/logic/lib/group';

import { DropdownSearch } from './DropdownSearch';
import { Groups } from '~/types';
import { Associations, Association } from '~/types/metadata-update';

interface GroupSearchProps<I extends string> {
  disabled?: boolean;
  adminOnly?: boolean;
  publicOnly?: boolean;
  groups: Groups;
  associations: Associations;
  label: string;
  caption?: string;
  id: I;
  maxLength?: number;
}

const CandidateBox = styled(Box)<{ selected: boolean }>`
  &:hover {
    background-color: ${p => p.theme.colors.washedGray};
  }
`;

const Candidate = ({ title, selected, onClick }) => (
  <CandidateBox
    onClick={onClick}
    selected={selected}
    borderColor="washedGray"
    color="black"
    fontSize={0}
    p={2}
    width="100%"
  >
    {title}
  </CandidateBox>
);

function renderCandidate(
  a: Association,
  selected: boolean,
  onSelect: (a: Association) => void
) {
  const { title } = a.metadata;

  const onClick = () => {
    onSelect(a);
  };

  return <Candidate title={title} selected={selected} onClick={onClick} />;
}

type FormValues<I extends string> = {
  [id in I]: string[];
};

export function GroupSearch<I extends string, V extends FormValues<I>>(props: GroupSearchProps<I>) {
  const { id, caption, label } = props;
  const {
    values,
    touched: touchedFields,
    errors,
    initialValues,
    setFieldValue,
    setFieldTouched,
  } = useFormikContext<V>();
  const [inputIdx, setInputIdx] = useState(initialValues[id].length);
  const name = `${id}[${inputIdx}]`;

  const value: string[] = values[id];
  const touched = touchedFields[id] ?? false;
  const error = _.compact(errors[id] as string[]);

  const groups: Association[] = useMemo(() => {
     if (props.adminOnly) {
       return Object.values(
          Object.keys(props.associations?.groups)
            .filter(
              e => roleForShip(props.groups[e], window.ship) === 'admin'
            )
            .reduce((obj, key) => {
              obj[key] = props.associations?.groups[key];
              return obj;
            }, {}) || {}
        );
     } else if (props.publicOnly) {
       return Object.values(
         Object.keys(props.associations?.groups)
           .filter(
             e => props.groups?.[e]?.policy?.open
           )
           .reduce((obj, key) => {
             obj[key] = props.associations?.groups[key];
             return obj;
           }, {}) || {}
       );
     } else {
      return Object.values(props.associations?.groups || {});
     }
  }, [props.associations?.groups]);

  return (
    <FieldArray
      name={id}
      render={(arrayHelpers) => {
        const onSelect = (a: Association) => {
          setFieldValue(name, a.group);
          setFieldTouched(name, true, false);
          setInputIdx(s => s+1);
        };

        const onRemove = (idx: number) => {
          setFieldTouched(name, true, false);
          setInputIdx(s => s - 1);
          arrayHelpers.remove(idx);
        };

        return (
          <Col>
            <Label htmlFor={id}>{label}</Label>
            {caption && (
              <Label gray mt="2">
                {caption}
              </Label>
            )}
              <DropdownSearch<Association>
                mt="2"
                candidates={groups}
                placeholder="Search for groups..."
                disabled={props.maxLength ? value.length >= props.maxLength : false}
                renderCandidate={renderCandidate}
                search={(s: string, a: Association) =>
                  a.metadata.title.toLowerCase().startsWith(s.toLowerCase())
                }
                getKey={(a: Association) => a.group}
                onSelect={onSelect}
                onBlur={() => {}}
              />
              {value?.length > 0 && (
                value.map((e, idx: number) => {
                  const { title } =
                    props.associations.groups?.[e]?.metadata || {};
                  return (
                    <Row
                      key={e}
                      borderRadius="1"
                      mt="2"
                      width="fit-content"
                      border="1"
                      borderColor="gray"
                      height="32px"
                      px="2"
                      alignItems="center"
                    >
                      <Text mr="2">{title || e}</Text>
                      <Icon onClick={() => onRemove(idx)} icon="X" />
                    </Row>
                  );
                })
            )}
            <ErrorLabel hasError={Boolean(touched && error.length > 0)}>
              {error.join(', ')}
            </ErrorLabel>
          </Col>
        );
      }} />
  );
}

export default GroupSearch;
