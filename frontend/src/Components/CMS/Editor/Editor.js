import React from 'react'

import { useState } from 'react'
import { TextField } from '@material-ui/core'
import MUIRichTextEditor from 'mui-rte';
import { useParams } from 'react-router-dom'

import { createPost, usePostByID, useUpdatePostSummaries } from '../../../Utils/ContentAPI'

import './Editor.css'

export default function Editor(props) {
  const id = useParams().postID
  
  const post = id ? usePostByID(id, true) : {title: 'Title', summary: 'What are you writing about?', content: 'start typing'}

  console.log(post)

  const [title, setTitle] = useState(post.title)
  const [summary, setSummary] = useState(post.summary)
  const [tags, setTags] = useState('Tags')

  const onSave = (data) => {
    createPost(title, summary, data, tags)
   // useUpdatePostSummaries() // FIX
  }

  return (
    <div className='editor'>
      <div className='title-editor'>
        <TextField
          id='title'
          label="Title"
          value={post.title}
          onChange={e => setTitle(e.target.value)}
          variant='standard'
          fullWidth={true}
        />
      </div>
      <div className='summary-editor'>
        <TextField
          id='Summary'
          value={post.summary}
          label="Summary"
          onChange={e => setSummary(e.target.value)}
          variant='standard'
          fullWidth={true}
        />
      </div>
      <div className='tags-editor'>
        <TextField
          id='tags'
          label='Tags'
          onChange={e => setTags(e.target.value.split(','))}
          variant='standard'
          fullWidth={true}
        />
      </div>
      <div className='content-editor'>
        <MUIRichTextEditor label="Start Typing" onSave={onSave} />
      </div>
    </div>
  );
}

//        <MUIRichTextEditor defaultValue={'Start typing'} onSave={onSave} />