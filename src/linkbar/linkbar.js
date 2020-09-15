import React from "react";
import { InlineIcon } from "@iconify/react";
import githubIcon from "@iconify/icons-logos/github-icon";

import "./linkbar.css";

export default function Linkbar() {
  return (
    <div class="link-bar">
      <InlineIcon icon={githubIcon} />
    </div>
  );
}
