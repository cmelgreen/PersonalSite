// modules
import React  from 'react'
import { useParams } from 'react-router-dom'
import { Typography } from '@material-ui/core'
// utils
import { usePostByID } from '../../Utils/ContentAPI'
import { renderHTML } from '../../Utils/RenderRichText'
// components
import { HeaderContainer } from '../Header/Header'
// styles
import './Post.css'

export default function PostContainer() {
  const post = usePostByID(useParams().postID)

  console.log(useParams().postID)
  console.log(post)

  return <Post content={renderHTML(post.content)} />
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