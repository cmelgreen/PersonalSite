import React from "react";
import "./App.css";

import Linkbar from "./linkbar";
import Title from "./title";
import Content from "./content";

export default function App() {
  return (
    <div className="app">
      <Linkbar />
      <Title />
      <Content />
    </div>
  );
}
