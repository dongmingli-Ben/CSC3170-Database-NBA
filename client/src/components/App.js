import React, { useState, useEffect } from "react";
import Query from "./modules/Query.js";
import Feed from "./modules/Feed.js";

// to use styles, import the necessary CSS files
import "./App.css";

/**
 * Define the "App" component as a function.
 */
const App = () => {
  // required method: whatever is returned defines what
  // shows up on screen
  const [query, setQuery] = useState("");
  return (
    // <> is like a <div>, but won't show
    // up in the DOM tree
    <>
      <div className="App-container">
        <Query setQuery={setQuery} />
        <Feed query={query} />
      </div>
    </>
  );
};

export default App;
