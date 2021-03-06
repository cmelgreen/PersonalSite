import React from 'react'

import { useState, useEffect } from 'react'
import { TextField } from '@material-ui/core'
import MUIRichTextEditor from 'mui-rte';
import { useParams, useHistory } from 'react-router-dom'

import { usePostByID, usePostSummaries, createPost, updatePost, deletePost } from '../../../Utils/ContentAPI'
import { NewPost } from '../../../Models/Posts'

import ClearIcon from '@material-ui/icons/Clear';

import './Editor.css'

export default function Editor(props) {
  const history = useHistory()

  const post = usePostByID(useParams().postID, true)

  const [id, setID] = useState(post.id)
  const [title, setTitle] = useState(post.title)
  const [summary, setSummary] = useState(post.summary)
  const [tags, setTags] = useState(post.tags)

  useEffect(() => {
    setID(post.id)
    setTitle(post.title)
    setSummary(post.summary)
  }, [post])

  const [saveState, setSaveState] = useState(true)
  usePostSummaries(-1, saveState)

  const saveType = useParams().postID ? 
    (data) => updatePost(id, title, summary, data, tags) :
    (data) => createPost(title, summary, data, tags)

  const onSave = (data) => {
    saveType(data)
    setSaveState(!saveState)
    history.push("/cms/"+title) 
  }

  return (
    <div className='editor'>
      <div className='title-editor'>
        <TextField
          id='title'
          label="Title"
          value={title}
          onChange={e => setTitle(e.target.value)}
          variant='standard'
          fullWidth={true}
        />
      </div>
      <div className='summary-editor'>
        <TextField
          id='summary'
          label="Summary"
          value={summary}
          onChange={e => setSummary(e.target.value)}
          variant='standard'
          fullWidth={true}
        />
      </div>
      <div className='tags-editor'>
        <TextField
          id='tags'
          label='Tags'
          value={tags}
          onChange={e => setTags(e.target.value.split(','))}
          variant='standard'
          fullWidth={true}
        />
      </div>
      <div className='content-editor'>
        <MUIRichTextEditor 
        defaultValue={post.content} 
        onSave={onSave} 
        controls={["title", "bold", "italic", "underline", "strikethrough", "highlight", "undo", "redo", "link", "media", "numberList", "bulletList", "quote", "code", "clear", "save", "deletePost"]}
        customControls={[
          {
              name: "deletePost",
              icon: <ClearIcon />,
              type: "callback",
              onClick: () => {deletePost(post.title); history.push("/cms/")}
          }
      ]}/>
      </div>
    </div>
  );
}
