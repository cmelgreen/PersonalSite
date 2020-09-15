import React from "react";
import "./App.css";

import Linkbar from "./src/linkbar";
import Title from "./src/title";
import Content from "./src/content";

export default function App() {
  return (
    <div className="app">
      <Linkbar />
      <Title />
      <Content />
    </div>
  );
}
