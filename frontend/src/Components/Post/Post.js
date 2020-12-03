import React  from 'react'
import { useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux' 
import { useParams } from 'react-router-dom'
import { HeaderContainer } from '../Header/Header'
import { Typography } from '@material-ui/core'

import { fetchPostByID, fetchPostSummaries} from '../../Utils/ContentAPI'
import { setContent, setSummaries } from '../Store/Actions'

export default function PostContainer() {
  const content = useSelector(state => state.content)
  const dispatch = useDispatch()
 
  useEffect(() => {
    dispatch(setContent(fetchPostByID(useParams().postId)))
    return () => setContent('')
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