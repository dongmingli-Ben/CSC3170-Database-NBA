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
      <div className="query-container u-flex u-flex-alignCenter u-flex-justifyCenter">
        <QueryInput setInputQuery={setInputQuery} inputQuery={inputQuery} />
        <button
          onClick={() => {
            console.log(inputQuery);
            props.setQuery(inputQuery);
          }}
          value="Query"
          type="submit"
          className="submit-btn u-pointer u-bold u-flex u-flex-justifyCenter u-flex-alignCenter"
        >
          <div className="query-btn-message-container">Query!</div>
          <img src="/static/cat_logo.png" className="query-image" />
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
    <textarea
      type="text"
      placeholder="SELECT * FROM players LIMIT 100;"
      value={props.inputQuery}
      onChange={(event) => {
        props.setInputQuery(event.target.value);
      }}
      className="newQuery-container input"
    />
  );
};

export default Query;
