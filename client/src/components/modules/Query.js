import React, { useEffect, useState } from "react";

import "./Query.css";

/**
 * Display the query frame and set new query
 *
 * Proptypes
 * @param {(string) => void} setQuery set current query
 */
const Query = (props) => {
  const [inputQuery, setInputQuery] = useState("");
  return (
    <div className="top-query-container">
      <div className="query-container u-textCenter u-relative">
        <QueryInput setInputQuery={setInputQuery} inputQuery={inputQuery} />
        <button
          onClick={() => props.setQuery(inputQuery)}
          value="Query"
          type="submit"
          className="submit-btn u-pointer"
        >
          Query
        </button>
      </div>
    </div>
  );
};

/**
 * handle user input query
 *
 * Proptypes
 * @param {(string) => void} setInputQuery set user input query
 * @param {string} inputQuery user input query
 */
const QueryInput = (props) => {
  return (
    <input
      type="text"
      placeholder=""
      value={props.inputQuery}
      onChange={(event) => {
        props.setInputQuery(event.target.value);
      }}
      className="newQuery-container"
    />
  );
};

export default Query;
