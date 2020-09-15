import React from "react";
import "./App.css";

import Linkbar from "../linkbar/linkbar";
import Title from "../title/title";
import Content from "../content/content";

export default function App() {
  return (
    <div className="app">
      <Linkbar />
      <Title />
      <Content />
    </div>
  );
}
