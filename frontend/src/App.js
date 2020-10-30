import React from "react";
import "./App.css";

import Linkbar from "./components/linkbar/linkbar";
import Title from "./components/title/title";
import Content from "./components/content/content";

export default function App() {
  return (
    <div className="app">
      <Linkbar />
      <Title />
      <Content />
    </div>
  );
}
