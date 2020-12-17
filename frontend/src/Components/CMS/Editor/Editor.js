import React from 'react'

import { useState } from 'react'
import { TextField } from '@material-ui/core'
import MUIRichTextEditor from 'mui-rte';
import { useParams } from 'react-router-dom'

import { createPost, usePostByID, useUpdatePostSummaries } from '../../../Utils/ContentAPI'

import './Editor.css'

export default function Editor(props) {
  const id = usePostByID(useParams().postID, true)
  
  const post = id ? id : {title: 'Title', summary: 'What are you writing about?', content: 'start typing'}

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
          defaultValue={post.title}
          onChange={e => setTitle(e.target.value)}
          variant='standard'
          fullWidth={true}
        />
      </div>
      <div className='summary-editor'>
        <TextField
          id='summary'
          label={post.summary}
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