import React  from 'react'

import { HeaderContainer } from '../Header/Header'
import { Typography } from '@material-ui/core'

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