import React from "react";

import "./Editor.css"

import { useState } from "react";
import { TextField } from "@material-ui/core";
import MUIRichTextEditor from "mui-rte";

export default function Editor(props) {
  const [title, setTitle] = useState('Title')
  const [summary, setSummary] = useState('Post Summary')
  const [tags, setTags] = useState('Tags')

  const onSave = (data) => console.log("title: ", title, 'summary ', summary, 'tags: ', tags, "data: ", data);

  return (
    <div className="editor">
      <div className="title-editor">
        <TextField
          id="outlined-basic"
          label="Title"
          onChange={e => setTitle(e.target.value)}
          variant="standard"
          fullWidth={true}
        />
      </div>
      <div className="summary-editor">
        <TextField
          id="outlined-basic"
          label="Summary"
          onChange={e => setSummary(e.target.value)}
          variant="standard"
          fullWidth={true}
        />
      </div>
      <div className="tags-editor">
        <TextField
          id="outlined-basic"
          label="Tags"
          onChange={e => setTags(e.target.value.split(','))}
          variant="standard"
          fullWidth={true}
        />
      </div>
      <div className="content-editor">
        <MUIRichTextEditor label="Start typing..." onSave={onSave} />
      </div>
    </div>
  );
}