import React from 'react'

import { useState, useEffect } from 'react'
import { TextField } from '@material-ui/core'
import MUIRichTextEditor from 'mui-rte';
import { useParams } from 'react-router-dom'

import { usePostByID, updatePostSummaries, createPost, updatePost } from '../../../Utils/ContentAPI'

import './Editor.css'

export default function Editor(props) {
  const post = usePostByID(useParams().postID, true)
  const updateSummaries = updatePostSummaries()

  const [id, setID] = useState(post.id)
  const [title, setTitle] = useState(post.title)
  const [summary, setSummary] = useState(post.summary)
  const [tags, setTags] = useState('Tags')

  useEffect(() => {
    setID(post.id)
    setTitle(post.title)
    setSummary(post.summary)
  }, [post])

  const create = (data) => {
    updatePost(id, title, summary, data, tags)
  }
  const update = (data) => createPost(id, title, summary, data, tags)

  const onSave = async () => {
    useParams().postID ? create : update
    updateSummaries()
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
