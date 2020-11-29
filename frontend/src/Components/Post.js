import React  from 'react'
import { useEffect } from 'react'
import { useParams } from 'react-router-dom'
import { HeaderContainer } from './Header'
import { Typography } from '@material-ui/core'

import { getPostByID, clearCurrentPost } from '../Utils/ContentAPI'

export default function PostContainer() {
  const content = getPostByID(useParams().postId)

  return <Post content={content} />
}
function Post(props) {
  return (
    <>
      <HeaderContainer />
      <Typography className="post">
        {props.content}
      </Typography>
    </>
  )
}