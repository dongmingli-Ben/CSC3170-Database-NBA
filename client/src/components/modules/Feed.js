import React, { useEffect, useState } from "react";
import TableList from "./TableList.js";
import TableContent from "./TableContent.js";

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

/**
 * The main display content, including list of tables and query result
 *
 * Proptypes
 * @param {string} query the current query
 */
const Feed = (props) => {
  const [queryResult, setQueryResult] = useState([]);
  const [tableList, setTableList] = useState([]);
  // fetch query result from api
  useEffect(() => {
    setTableList(["game", "game_player_info"]);
  }, []);

  useEffect(() => {
    setQueryResult(TABLE);
  }, [props.query]);

  console.log(props.query);

  return (
    <div>
      <TableList list={tableList} />
      <TableContent content={queryResult} />
    </div>
  );
};

export default Feed;
