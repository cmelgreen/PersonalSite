import React from "react";

import { useState } from "react";
import { TextField } from "@material-ui/core";
import MUIRichTextEditor from "mui-rte";
import { useParams } from 'react-router-dom'

import { createPost, usePostByID, useUpdatePostSummaries } from '../../../Utils/ContentAPI'

import "./Editor.css"

export default function Editor(props) {
  const id = useParams().postID

  //id ? usePostByID(id, raw=true) :
  const post = {title: 'Start typing...', summary: 'What are you writing about?', content: "start typing"}

  const [title, setTitle] = useState(post.title)
  const [summary, setSummary] = useState(post.summary)
  const [tags, setTags] = useState('Tags')

  const onSave = (data) => {
    createPost(title, summary, data, tags)
   // useUpdatePostSummaries() // FIX
  }

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
        <MUIRichTextEditor defaultValue={post.content} onSave={onSave} />
      </div>
    </div>
  );
}