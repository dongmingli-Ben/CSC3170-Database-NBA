import React, { useEffect, useState } from "react";

/**
 * display a list of tables
 *
 * Proptypes
 * @param {{string}[]} list the list of tables
 */
const TableList = (props) => {
  let content;

  content = props.list.map((tableName, index) => {
    return <div key={index}>{tableName}</div>;
  });

  return <div className="tableList-container">{content}</div>;
};

export default TableList;
