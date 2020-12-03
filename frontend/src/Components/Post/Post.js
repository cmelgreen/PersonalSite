import React  from 'react'
import { useParams } from 'react-router-dom'
import { Typography } from '@material-ui/core'

import { HeaderContainer } from '../Header/Header'

import { getPostByID } from '../../Utils/ContentAPI'

export default function PostContainer() {
  const content = getPostByID(useParams().postID)

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