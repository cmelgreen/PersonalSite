import React from "react";
import "./title.css";

export default function Title() {
  return (
    <div class="title">
      <picture>
        <img class="icon" src={require("./icon.jpg")} alt="icon" />
      </picture>
      <div class="name">Cooper Melgreen! </div>
    </div>
  );
}
