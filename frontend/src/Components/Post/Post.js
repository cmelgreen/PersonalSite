import React  from 'react'
import { useEffect } from 'react'
import { useDispatch } from 'react-redux'
import { useParams } from 'react-router-dom'
import { HeaderContainer } from '../Header/Header'
import { Typography } from '@material-ui/core'

import { fetchPostByID, clearCurrentPost } from '../../Utils/ContentAPI'

export default function PostContainer() {
  const content = useSelector(state => state.content)
  const dispatch = useDispatch()

  useEffect(() => {
    fetchPostByID(useParams().postId, dispatch)
    return clearCurrentPost(dispatch)
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