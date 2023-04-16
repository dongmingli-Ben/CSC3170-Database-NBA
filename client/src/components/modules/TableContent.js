import React, { useEffect, useState } from "react";

/**
 * display the query result (a table)
 *
 * Proptypes
 * @param {Array} content the query result in JSON format
 */
const TableContent = (props) => {
  let content;
  let columns = null;

  if (props.content.length > 0) {
    columns = [];
    for (let columnName in props.content[0]) {
      columns = [...columns, columnName];
    }
  }
  console.log(columns);

  content = props.content.map((row, index) => {
    return <TableRow row={row} columns={columns} key={index} />;
  });

  return <div className="tableContent-container">{content}</div>;
};

/**
 * display a row of the query result
 *
 * Proptypes
 * @param {Object} row a row of query result in JSON format
 * @param {{string}[]} columns the column names to display (for ordering)
 */
const TableRow = (props) => {
  if (props.columns === null) {
    return <></>;
  }

  let content;

  content = props.columns.map((name, index) => {
    return <TableCell value={props.row[name]} key={index} />;
  });

  return <div>{content}</div>;
};

/**
 * display a cell of the table
 *
 * Proptypes
 * @param {Object} value the cell value
 */
const TableCell = (props) => {
  return <div>{props.value}</div>;
};

export default TableContent;
