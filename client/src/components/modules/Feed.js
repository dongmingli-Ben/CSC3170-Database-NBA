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

const API_URL = "http://10.31.38.201:34152";

/**
 * The main display content, including list of tables and query result
 *
 * Proptypes
 * @param {string} query the current query
 * @param {(string) => void} setQuery set the query (for exploring tables)
 */
const Feed = (props) => {
  const [queryResult, setQueryResult] = useState(null);
  const [tableList, setTableList] = useState([]);
  // fetch query result from api
  useEffect(() => {
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
