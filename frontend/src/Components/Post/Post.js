import React  from 'react'
import { useEffect } from 'react'
import { useParams } from 'react-router-dom'
import { HeaderContainer } from '../Header/Header'
import { Typography } from '@material-ui/core'

import { fetchPostByID, clearCurrentPost } from '../../Utils/ContentAPI'

export default function PostContainer() {
  const content = useSelector(state => state.content)

  useEffect(() => {
    fetchPostByID(useParams().postId)
    return clearCurrentPost()
  }, [])

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