import React, { useEffect, useState } from "react";

import "./TableList.css";

/**
 * display a list of tables
 *
 * Proptypes
 * @param {{string}[]} list the list of tables
 */
const TableList = (props) => {
  let content;

  content = props.list.map((tableName, index) => {
    return (
      <div key={index} className="tableName-container u-pointer">
        {tableName}
      </div>
    );
  });

  return (
    <div className="tableList-container">
      <h3 className="tableList-header">Tables</h3>
      <div className="tableList-content-container">{content}</div>
    </div>
  );
};

export default TableList;
