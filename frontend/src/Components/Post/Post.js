import React  from 'react'
import { useEffect } from 'react'
import { useSelector, useDispatch } from 'react-redux' 
import { useParams } from 'react-router-dom'
import { HeaderContainer } from '../Header/Header'
import { Typography } from '@material-ui/core'
import axios from 'axios'

import { fetchPostByID, fetchPostSummaries} from '../../Utils/ContentAPI'
import { setContent, setSummaries } from '../../Store/Actions'


export default function PostContainer() {
  const content = useSelector(state => state.content)
  const dispatch = useDispatch()
 
  useEffect(() => {
    axios.get(apiRoot+'/post', {params: {id}})
      .then(resp => dispatch(setContent(resp.data.content)))
      .catch(() => dispatch(setContent('')))
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