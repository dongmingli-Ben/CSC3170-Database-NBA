import React, { useEffect, useState } from "react";

/**
 * Display the query frame and set new query
 *
 * Proptypes
 * @param {(string) => void} setQuery set current query
 */
const Query = (props) => {
  const [inputQuery, setInputQuery] = useState("");
  return (
    <div className="query-container">
      <QueryInput setInputQuery={setInputQuery} inputQuery={inputQuery} />
      <button
        onClick={() => props.setQuery(inputQuery)}
        value="Query"
        type="submit"
      >
        Query
      </button>
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
      className="NewPostInput-input"
    />
  );
};

export default Query;
