import React from 'react'

import { useState, useEffect } from 'react'
import { TextField } from '@material-ui/core'
import MUIRichTextEditor from 'mui-rte';
import { useParams } from 'react-router-dom'

import { createPost, usePostByID } from '../../../Utils/ContentAPI'

import './Editor.css'

export default function Editor(props) {
  const post = usePostByID(useParams().postID, true)

  console.log(post)

  const [title, setTitle] = useState(post.title)
  const [summary, setSummary] = useState(post.summary)
  const [tags, setTags] = useState('Tags')

  useEffect(() => {
    setTitle(post.title)
    setSummary(post.summary)
  }, [post])

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
        <MUIRichTextEditor defaultValue={post.content} onSave={onSave} />
      </div>
    </div>
  );
}

//        <MUIRichTextEditor defaultValue={'Start typing'} onSave={onSave} />