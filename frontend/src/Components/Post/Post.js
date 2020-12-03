// modules
import React  from 'react'
import { useParams } from 'react-router-dom'
import { Typography } from '@material-ui/core'
// utils
import { getPostByID } from '../../Utils/ContentAPI'
// components
import { HeaderContainer } from '../Header/Header'
// styles
import './Post.css'

export default function PostContainer() {
  const content = getPostByID(useParams().postID)

  return <Post content={content} />
}

function Post(props) {
  return (
    <div className='post'>
      <HeaderContainer />
      <Typography>
        {props.content}
      </Typography>
    </div>
  )
}