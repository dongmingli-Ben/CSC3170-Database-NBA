import React, { useEffect, useState } from "react";
import TableList from "./TableList.js";
import TableContent from "./TableContent.js";
import { get } from "../../utility.js";

import "./Feed.css";

const TABLE = [
  {
    PLAYER_ID: 1,
    PLAYER_NAME: "andrew",
  },
  {
    PLAYER_ID: 2,
    PLAYER_NAME: "ethan",
  },
];

const API_URL = "http://47.242.150.253:39005";

/**
 * The main display content, including list of tables and query result
 *
 * Proptypes
 * @param {string} query the current query
 * @param {(string) => void} setQuery set the query (for exploring tables)
 */
const Feed = (props) => {
  const [queryResult, setQueryResult] = useState(null);
  const [tableList, setTableList] = useState(null);
  // fetch query result from api
  useEffect(() => {
    setTableList(null);
    get(`${API_URL}/tables`).then((result) => {
      console.log(result);
      setTableList(result["content"]);
    });
  }, []);

  const [message, setMessage] = useState("");

  useEffect(() => {
    setQueryResult(null);
    if (props.query === "") {
      setMessage("Please enter a query!");
      return;
    }
    setMessage("Loading query results...");
    get(`${API_URL}/query`, { query: props.query }).then((result) => {
      console.log("query returned:");
      console.log(result);
      if (result.hasOwnProperty("error_message")) {
        // display error message
        setMessage(result.error_message);
        return;
      }
      if (result["content"].length === 0) {
        setQueryResult([]);
      } else {
        setQueryResult(result["content"]);
      }
    });
  }, [props.query]);

  console.log(props.query);

  return (
    <div className="content-container u-flex u-relative">
      <TableList list={tableList} setQuery={props.setQuery} />
      <TableContent content={queryResult} message={message} />
    </div>
  );
};

export default Feed;
