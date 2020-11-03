import React from "react";
import "./title.css";

export default function Title() {
  return (
    <div className="title">
      <picture>
        <img className="icon" src={require("./static/icon.jpg")} alt="icon" />
      </picture>
      <div className="name">Cooper Melgreen </div>
    </div>
  );
}
