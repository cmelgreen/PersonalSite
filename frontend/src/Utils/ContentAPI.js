import { useEffect } from 'react'
import { useDispatch, useSelector } from 'react-redux'
import { setContent, setSummaries } from '../Store/Actions'
import axios from 'axios'

const apiRoot = '/api'
const apiPost = apiRoot + '/post'
const apiPostSummaries = apiRoot + '/post-summaries'

export const usePostByID = (id, raw=false) => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiPost, {params: {id, raw}})
      .then(resp => {
        console.log(resp)
        dispatch(setContent(resp.data.content))
      })
      .catch(() => dispatch(setContent('')))
    
      return () => dispatch(setContent(''))
  }, [])

  return useSelector(state => state.content)
}

export const createPost = (title, summary, data, tags) => {
  const post = {title: title, summary: summary, rawContent: data}
  axios.post(apiPost, post)
    .then(resp => console.log("Created", resp))
    .catch(resp => console.log("Error creating post", resp))
}

export const usePostSummaries = (numPosts) => {
  const dispatch = useDispatch()

  useEffect(() => {
    axios.get(apiPostSummaries, {params: {numPosts}})
      .then(resp => {
        console.log(resp)
        dispatch(setSummaries(resp.data.posts))
      })
      .catch(() => dispatch(setSummaries([])))
  }, [])

  return useSelector(state => state.summaries)
}

export const useUpdatePostSummaries = () => {
  const dispatch = useDispatch()

  axios.get(apiPostSummaries)
    .then(resp => dispatch(setSummaries(resp.data.posts)))
    .catch(() => dispatch(setSummaries([])))
}